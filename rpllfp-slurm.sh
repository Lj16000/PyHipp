#!/bin/bash
#SBATCH --job-name=rpllfp
#SBATCH --output=rpllfp-slurm.%N.%j.out
#SBATCH --error=rpllfp-slurm.%N.%j.err
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

echo "Start:" $(date)
python -u -c "import PyHipp as pyh; import time; pyh.RPLLFP(saveLevel=1); print(time.localtime());"
echo "End:" $(date)
