import torch
from torch import nn, einsum
import torch.nn.functional as F
from einops import rearrange, repeat
from einops.layers.torch import Rearrange

# helpers

def exists(val):
    return val is not None

def default(val, d):
    return val if exists(val) else d

# pre-layernorm

class PreNorm(nn.Module):
    def __init__(self, dim, fn):
        super().__init__()
        self.norm = nn.LayerNorm(dim)
        self.fn = fn
    def forward(self, x, **kwargs):
        return self.fn(self.norm(x), **kwargs)

# feedforward

class FeedForward(nn.Module):
    def __init__(self, dim, hidden_dim, dropout = 0.):
        super().__init__()
        self.net = nn.Sequential(
            nn.Linear(dim, hidden_dim),
            nn.GELU(),
            nn.Dropout(dropout),
            nn.Linear(hidden_dim, dim),
            nn.Dropout(dropout)
        )
    def forward(self, x):
        return self.net(x)

# attention

class Attention(nn.Module):
    def __init__(self, dim, heads = 8, dim_head = 64, dropout = 0.):
        super().__init__()
        inner_dim = dim_head *  heads
        self.heads = heads
        self.scale = dim_head ** -0.5

        self.attend = nn.Softmax(dim = -1)
        self.dropout = nn.Dropout(dropout)

        self.to_q = nn.Linear(dim, inner_dim, bias = False)
        self.to_kv = nn.Linear(dim, inner_dim * 2, bias = False)

        self.to_out = nn.Sequential(
            nn.Linear(inner_dim, dim),
            nn.Dropout(dropout)
        )

    def forward(self, x, context = None, kv_include_self = False):
        b, n, _, h = *x.shape, self.heads
        context = default(context, x)

        if kv_include_self:
            context = torch.cat((x, context), dim = 1) # cross attention requires CLS token includes itself as key / value

        qkv = (self.to_q(x), *self.to_kv(context).chunk(2, dim = -1))
        q, k, v = map(lambda t: rearrange(t, 'b n (h d) -> b h n d', h = h), qkv)

        dots = einsum('b h i d, b h j d -> b h i j', q, k) * self.scale

        attn = self.attend(dots)
        attn = self.dropout(attn)

        out = einsum('b h i j, b h j d -> b h i d', attn, v)
        out = rearrange(out, 'b h n d -> b n (h d)')
        return self.to_out(out)

# transformer encoder, for small and large patches

class Transformer(nn.Module):
    def __init__(self, dim, depth, heads, dim_head, mlp_dim, dropout = 0.):
        super().__init__()
        self.layers = nn.ModuleList([])
        self.norm = nn.LayerNorm(dim)
        for _ in range(depth):
            self.layers.append(nn.ModuleList([
                PreNorm(dim, Attention(dim, heads = heads, dim_head = dim_head, dropout = dropout)),
                PreNorm(dim, FeedForward(dim, mlp_dim, dropout = dropout))
            ]))

    def forward(self, x):
        for attn, ff in self.layers:
            x = attn(x) + x
            x = ff(x) + x
        return self.norm(x)

# projecting CLS tokens, in the case that small and large patch tokens have different dimensions

class ProjectInOut(nn.Module): 
    def __init__(self, dim_in, dim_out, fn): #dim_in:200, dim_out:768
        super().__init__()
        self.fn = fn

        need_projection = dim_in != dim_out
        self.project_in = nn.Linear(dim_in, dim_out) if need_projection else nn.Identity()
        self.project_out = nn.Linear(dim_out, dim_in) if need_projection else nn.Identity()

    def forward(self, x, *args, **kwargs):
        x = self.project_in(x)
        x = self.fn(x, *args, **kwargs)
        x = self.project_out(x)
        return x

# cross attention transformer

class CrossTransformer(nn.Module):
    def __init__(self, kg_dim, nlq_dim, depth, heads, dim_head, dropout):
        super().__init__()
        self.layers = nn.ModuleList([])
        for _ in range(depth):
            self.layers.append(nn.ModuleList([
                ProjectInOut(kg_dim, nlq_dim, PreNorm(nlq_dim, Attention(nlq_dim, heads = heads, dim_head = dim_head, dropout = dropout))),
                ProjectInOut(nlq_dim, kg_dim, PreNorm(kg_dim, Attention(kg_dim, heads = heads, dim_head = dim_head, dropout = dropout)))
            ]))

    def forward(self, kg_embs, nlq_embs):
        (kg_cls, kg_embs), (nlq_cls, nlq_embs) = map(lambda t: (t[:, :1], t[:, 1:]), (kg_embs, nlq_embs))
        for kg_attend_nlq, nlq_attend_kg in self.layers:
            kg_cls = kg_attend_nlq(kg_cls, context = nlq_embs, kv_include_self = True) + kg_cls
            nlq_cls = nlq_attend_kg(nlq_cls, context = kg_embs, kv_include_self = True) + nlq_cls
  
        kg_embs = torch.cat((kg_cls, kg_embs), dim = 1)
        nlq_embs = torch.cat((nlq_cls, nlq_embs), dim = 1)
        return kg_embs, nlq_embs



# cross_att = CrossTransformer(kg_dim=768, nlq_dim=768, depth=3, heads=12, dim_head=64, dropout=0.1)
# gcn_embds = torch.randn(1, 19, 768)
# encoder_last_hidden_state = torch.randn(1, 19, 768)
# x, y = cross_att(gcn_embds, encoder_last_hidden_state)
# print('cross_attended gcn embeds shape:',x.shape, torch.equal(x, gcn_embds))
# print('cross_attended encoder embeds shape:', y.shape, torch.equal(y, encoder_last_hidden_state))

