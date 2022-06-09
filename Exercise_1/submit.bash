#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --partition=express
#SBATCH --job-name=python-test-run
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --ntasks=1

## Ensure that myscript.py is present in current working directory

module load singularity/3.5.3

## /tmp folder will be replaced by the folder path you provide. We recommend this as /tmp is limited to 20GB (and shared with other users on the given compute nodes)

export SINGULARITY_TMPDIR=/scratch/$USER/$SLURM_JOB_ID
mkdir -p $SINGULARITY_TMPDIR

CONTAINER=/shared/container_repository/python/python_3_10.sif

## execute container python.sif to run a python command:

singularity exec $CONTAINER python3 myscript.py

rm -rf $SINGULARITY_TMPDIR
