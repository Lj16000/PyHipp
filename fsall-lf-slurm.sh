#!/bin/bash
#SBATCH --job-name=fsall_lf
#SBATCH --output=fsall-lf-slurm.%N.%j.out
#SBATCH --error=fsall-lf-slurm.%N.%j.err
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

set -euo pipefail
echo "Start: $(date)"
cd /data/picasso

# activate conda
if [ -f /data/miniconda3/etc/profile.d/conda.sh ]; then
  source /data/miniconda3/etc/profile.d/conda.sh
elif [ -f ~/miniconda3/etc/profile.d/conda.sh ]; then
  source ~/miniconda3/etc/profile.d/conda.sh
fi
conda activate env1

python -u - <<'PY'
import PyHipp as pyh
import DataProcessingTools as DPT
lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1)
lfall.save()
print("lfall saved")
PY

echo "End: $(date)"
