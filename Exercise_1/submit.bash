#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --partition=express
#SBATCH --job-name=python-container-test-run
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --ntasks=1

# Load the Singularity module:
module load singularity/3.5.3
# Define the container image location on Discovery:
CONTAINER=/shared/container_repository/python/python_3_10.sif

## Optioanl - but recommended - work on /scratch or /work file systems to avoid out-of-memory issues:
cd /scratch/$USER
# /tmp folder will be replaced by the folder path you provide. We recommend this as /tmp is limited to 20GB (and shared with other users on the given compute nodes).
export SINGULARITY_TMPDIR=/scratch/$USER/$SLURM_JOB_ID

# Copy the example script:
cp /shared/container_repository/python/HelloWorld.py 

# Run the container python.sif to run a python command:
# Note - your $HOME directory, /tmp and $PWD are automatically mounted and available inside the container:
singularity exec $CONTAINER python3 HelloWorld.py 

