#!/bin/bash
#SBATCH -N 1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50GB
#SBATCH --time=01:00:00
#SBATCH -J test.gromacs-container
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1

## Note - this script assumes that benchmark.tpr is in the present working directory
## If it's not there, copy it first by modifying and uncommenting the follwing line:
# cp /path/to/benchmark.tpr .

## Load the singularity module
module load singularity/3.5.3

# /tmp folder will be replaced by the folder path you provide. We recommend this as /tmp is limited to 20GB (and shared with other users on the given compute nodes).
export SINGULARITY_TMPDIR=/scratch/$USER/$SLURM_JOB_ID
mkdir -p $SINGULARITY_TMPDIR

## set the path to the gromacs container
CONTAINER=/shared/container_repository/gromacs/gromacs-2020_2.sif
MYTPR=benchmark.tpr

## Run GROMACAS - using a GPU and 8 threads (CPUs) :
singularity run --nv $CONTAINER gmx mdrun -ntomp 8 -s $MYTPR -v -noconfout -dlb yes

# remove the tmp folder to avoid clutter:
rm -rf $SINGULARITY_TMPDIR
