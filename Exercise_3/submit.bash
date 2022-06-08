#!/bin/bash
#SBATCH -N 1
#SBATCH --cpus-per-task=2
#SBATCH --mem=50GB
#SBATCH --time=01:00:00
#SBATCH -J test.tf-container
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1

## Load the singularity module
module load singularity/3.5.3
## set the path to the gromacs container
CONTAINER=/shared/container_repository/pytorch/pytorch_22.05-py3.sif 
## Enter your desired workspace, and place the script inside. The following is commented out as it assumes the script is in the present working directory.
# cd /path/to/my/workdir
# cp /path/to/tpr .
MY_SCRIPT=train_my_model-pytorch.py
## Run TF with your script, append any additional paths you'll need using the -B options. In this example we append the /scratch/$USER folder (not actually needed for this example):
singularity run --nv -B /scratch/$USER:/mnt $CONTAINER python3 $MY_SCRIPT
