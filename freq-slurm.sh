#!/bin/bash
#SBATCH --job-name=freq
#SBATCH --output=freq-slurm.%N.%j.out
#SBATCH --error=freq-slurm.%N.%j.err
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

echo "Start:" $(date)

python -u - <<'PY'
import PyHipp as pyh
import DataProcessingTools as DPT

DPT.objects.processDirs(
    dirs=None,
    exclude=['*eye*','*mountains*'],
    objtype=pyh.FreqSpectrum,
    saveLevel=1
)

DPT.objects.processDirs(
    dirs=None,
    exclude=['*eye*','*mountains*'],
    objtype=pyh.FreqSpectrum,
    loadHighPass=True,
    pointsPerWindow=3000,
    saveLevel=1
)
PY

echo "End:" $(date)
