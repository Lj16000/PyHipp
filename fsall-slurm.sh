#!/bin/bash
#SBATCH --job-name=fsall
#SBATCH --output=fsall-slurm.%N.%j.out
#SBATCH --error=fsall-slurm.%N.%j.err
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
set -euo pipefail
echo "Start:" $(date)

PY="/data/miniconda3/envs/env1/bin/python"
[ -x "$PY" ] || PY="$HOME/miniconda3/envs/env1/bin/python"

"$PY" -u - <<'PY'
import PyHipp as pyh
import DataProcessingTools as DPT

lfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, saveLevel=1)
lfall.save()
hfall = DPT.objects.processDirs(dirs=None, exclude=['*eye*','*mountains*'], objtype=pyh.FreqSpectrum, loadHighPass=True, pointsPerWindow=3000, saveLevel=1)
hfall.save()
PY

echo "End:" $(date)

aws sns publish --topic-arn arn:aws:sns:ap-southeast-1:075502423015:awsnotify --message "FSJobDone"
