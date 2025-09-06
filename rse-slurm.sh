#!/bin/bash
#SBATCH --job-name=rse
#SBATCH --output=rse-slurm.%N.%j.out
#SBATCH --error=rse-slurm.%N.%j.err
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

echo "Start:" $(date)
python -u -c "import PyHipp as pyh; import time, os; t0=time.time(); print(time.localtime()); os.chdir('sessioneye'); pyh.RPLSplit(SkipLFP=False, SkipHighPass=False); print(time.localtime()); print(time.time()-t0);"
echo "End:" $(date)
