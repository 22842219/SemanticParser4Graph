#!/bin/bash -l
#SBATCH --job-name=Seq2seq-spider
#SBATCH --partition=week
#SBATCH --account=pmc003
#SBATCH --nodes=1
## this allocate number of cpus to individual jobs
#SBATCH --ntasks=5

## requesting whole GPUs
#SBATCH --gres=gpu:1

# the default mem-per-cpu is 1G the max is 21G
#SBATCH --mem-per-cpu=30G

## OR you can specify the --mem-per-gpu=
## I have not experimented with this so not sure what the defaults 
## are set to.

## Or you can specify --mem if you are using the whole node
## the default is 36G  max is 760G 

#SBATCH --export=ALL

start_time=$( date )

# To configure GNU Environment for Mothur
module load Anaconda3/2021.05

# activate a group wide Python environment 
conda activate py3.7pytorch1.8new


# list the environment loaded by the modules.
# Can remove the two lines below if you want.
# module list
# conda env list
# module avail
module load java/11.0.12
export WANDB_API_KEY=edd277e1d782e96634109705a6235577032da246
export WANDB_PROJECT='text2cypher-Feb(whole-set)-kaya'
export WANDB_ENTITY=leamonzea929

# step1: activate neo4j

cd ${MYGROUP}/neo4j-community-4.4.13/bin
./neo4j start



# step2: build graph database
cd ${MYGROUP}/SemanticParser4Graph/application/rel_db2kg
python schema2graph.py --spider
#echo SLURM_SUBMIT_DIR is ${SLURM_SUBMIT_DIR}
echo running in ${MYGROUP}/SemanticParser4Graph/application/rel_db2kg

# Note: SLURM_JOB_ID is a unique number for every job.
# These are geTabularSemanticParsingneric variables.

# Below is the Python file that would be run. Replace
# validate_gpu.py with your own file name.
SCRIPT=${MYGROUP}/SemanticParser4Graph/semantic_parser/run-text2cypher-exp-T5_base_prefix_text2cypher_with_cell_value.sh

### Just define SCRATCH once. Last call takes precedence in any case
### Job arrays not in use so *_ARRAY_* variables are null.
### Use SLURM_JOB_ID to ensure job separation
SCRATCH=${MYSCRATCH}/run_conda/${SLURM_JOB_ID}

RESULTS=${MYGROUP}/conda_results/${SLURM_JOB_ID}

###############################################
# Creates a unique directory in the SCRATCH directory for this job to run in.
if [ ! -d ${SCRATCH} ]; then
    mkdir -p ${SCRATCH}
fi
echo Working SCRATCH directory is ${SCRATCH}

###############################################
# Creates a unique directory in your GROUP directory for the results of this job
if [ ! -d ${RESULTS} ]; then
     mkdir -p ${RESULTS}
fi
echo Results will be stored in $RESULTS

#############################################

#cd ${SLURM_SUBMIT_DIR}
cd ${MYGROUP}/SemanticParser4Graph/semantic_parser/
#echo SLURM_SUBMIT_DIR is ${SLURM_SUBMIT_DIR}
echo running in ${MYGROUP}/SemanticParser4Graph/semantic_parser/

# copy the mothur analysis script to SCRATCH
#cp ${SCRIPT} ${SCRATCH}

# go to the scratch... directory and create symbolic links to the
# files for the CIFAR-10 dataset and a link to Du's data_loader.py.
#cd ${SCRATCH}

### possible problem here. PYTHONPATH being set to string 'pwd' rather
### than the output of the pwd command which needs backticks ie. `pwd` 

# now run our Python script fileb
bash ${SCRIPT}


#############################################
# Now move the output produced by our Python script from
# the /scratch... directory to my home directory.
cd ${HOME}
mv ${SCRATCH} ${RESULTS}

echo "moving ${SCRATCH} to ${RESULTS}"
echo "Please see the ${RESULTS} directory for any output"

echo
echo " ML - GPU job started  at $start_time"
echo " ML - GPU job finished at `date`"
                                         
                                                                                                                                                           3,24          Top
