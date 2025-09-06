#!/usr/bin/env bash
set -e

echo
echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l
echo
echo "#==========================================================="
echo "Start Times"

for f in rplpl-slurm*.out rplspl-slurm*.out; do
  [ -e "$f" ] || continue
  echo "==> $f <=="
  grep -m1 'time.struct_time' "$f" || true
  echo
done

echo "End Times"
for f in rplpl-slurm*.out rplspl-slurm*.out; do
  [ -e "$f" ] || continue
  echo "==> $f <=="
  n=$(grep -n 'time.struct_time' "$f" | tail -n1 | cut -d: -f1)
  if [ -n "$n" ]; then
    sed -n "${n}p;$((n+1))p;$((n+2))p" "$f"
  fi
  echo
done
echo "#==========================================================="
