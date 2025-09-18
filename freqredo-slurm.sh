#!/bin/bash
#SBATCH --job-name=freqredo
#SBATCH --output=freqredo-slurm.%N.%j.out
#SBATCH --error=freqredo-slurm.%N.%j.err
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

echo "Start:" $(date)

# activate conda env
if [ -f /data/miniconda3/etc/profile.d/conda.sh ]; then
  source /data/miniconda3/etc/profile.d/conda.sh
elif [ -f ~/miniconda3/etc/profile.d/conda.sh ]; then
  source ~/miniconda3/etc/profile.d/conda.sh
fi
conda activate env1

python -u -c "import PyHipp as pyh; pyh.FreqSpectrum(saveLevel=1, redoLevel=1)"

echo "End:" $(date)
