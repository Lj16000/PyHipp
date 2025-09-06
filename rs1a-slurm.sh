#!/bin/bash
#SBATCH --job-name=rs1a
#SBATCH --output=rs1a-slurm.%N.%j.out
#SBATCH --error=rs1a-slurm.%N.%j.err
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1

echo "Start:" $(date)
python -u -c "import PyHipp as pyh; import DataProcessingTools as DPT; import time, os; t0=time.time(); print(time.localtime()); DPT.objects.processDirs(dirs=None, objtype=pyh.RPLSplit, channel=[*range(1,33)], SkipHPC=False, HPCScriptsDir='/data/src/PyHipp/', SkipLFP=False, SkipHighPass=False, SkipSort=False); print(time.localtime()); print(time.time()-t0);"
echo "End:" $(date)
