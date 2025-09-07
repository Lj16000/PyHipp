#!/bin/bash
#SBATCH --job-name=hp_sort
#SBATCH --output=rplhighpass-sort-slurm.%N.%j.out
#SBATCH --error=rplhighpass-sort-slurm.%N.%j.err
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/data/miniconda3/bin/conda init
source ~/.bashrc
envarg=$(/data/src/PyHipp/envlist.py)
conda activate "$envarg"

echo "Start:" $(date)
python -u -c "import PyHipp as pyh; import time; pyh.RPLHighPass(saveLevel=1); from PyHipp import mountain_batch; mountain_batch.mountain_batch(); from PyHipp import export_mountain_cells; export_mountain_cells.export_mountain_cells(); print(time.localtime());"
echo "End:" $(date)

conda deactivate
/data/src/PyHipp/envlist.py "$envarg"
