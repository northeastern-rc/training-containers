#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --partition=express
#SBATCH --job-name=python-container-test-run
#SBATCH --output=ex1.out
#SBATCH --error=ex1.err
#SBATCH --ntasks=1

## Note - this script assumes the python script is in the present working directory
## If it's not there, copy it first by modifying and uncommenting the follwing line:
# cp /path/to/HelloWorld.py .

# Load the Singularity module:
module load singularity/3.5.3
# Define the container image location on Discovery:
CONTAINER=/shared/container_repository/python/python_3_10.sif

# /tmp folder will be replaced by the folder path you provide. We recommend this as /tmp is limited to 20GB (and shared with other users on the given compute nodes).
export SINGULARITY_TMPDIR=/scratch/$USER/$SLURM_JOB_ID
mkdir -p $SINGULARITY_TMPDIR

# Run the container python.sif to run a python command:
# Note - your $HOME directory, /tmp and $PWD are automatically mounted and available inside the container:
singularity exec $CONTAINER python3 HelloWorld.py 

# remove the tmp folder to avoid clutter:
rm -rf $SINGULARITY_TMPDIR
