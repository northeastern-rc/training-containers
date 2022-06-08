#!/bin/bash
#SBATCH -N 1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50GB
#SBATCH --time=01:00:00
#SBATCH -J test.gromacs-container
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1

## Load the singularity module
module load singularity/3.5.3
## set the path to the gromacs container
CONTAINER=/shared/container_repository/gromacs/gromacs-2020_2.sif
## Enter your desired workspace, and place the tpr file inside. The following is commented out as it assumes the TPR file is in the present working directory.
# cd /path/to/my/workdir
# cp /path/to/tpr .
MYTPR=benchmark.tpr
## Run GROMACAS - using a GPU and 8 threads (CPUs) :
singularity run --nv $CONTAINER gmx mdrun -ntomp 8 -s $MYTPR -v -noconfout -dlb yes
