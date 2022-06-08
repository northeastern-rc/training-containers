#!/bin/bash
#SBATCH -N 1
#SBATCH --cpus-per-task=2
#SBATCH --mem=50GB
#SBATCH --time=01:00:00
#SBATCH -J test.tf-container
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --output=ex3.out
#SBATCH --error=ex3.err

## Note - this script assumes the python script is in the present working directory
## If it's not there, copy it first by modifying and uncommenting the follwing line:
# cp /path/to/train_my_model-pytorch.py .

## Load the singularity module
module load singularity/3.5.3

# /tmp folder will be replaced by the folder path you provide. We recommend this as /tmp is limited to 20GB (and shared with other users on the given compute nodes).
export SINGULARITY_TMPDIR=/scratch/$USER/$SLURM_JOB_ID
mkdir -p $SINGULARITY_TMPDIR

## set the path to the gromacs container
CONTAINER=/shared/container_repository/pytorch/pytorch_22.05-py3.sif 
MY_SCRIPT=train_my_model-pytorch.py
## Run TF with your script, append any additional paths you'll need using the -B options. In this example we append the /scratch/$USER folder (not actually needed for this example):
singularity run --nv -B /scratch/$USER:/mnt $CONTAINER python3 $MY_SCRIPT

# remove the tmp folder to avoid clutter:
rm -rf $SINGULARITY_TMPDIR
