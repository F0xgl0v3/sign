#!/usr/bin/env bash
# append_signature.sh
# Usage examples:
#   ./append signature located in $HOME/.signatures/ file.txt
set -euo pipefail

# Defaults
sig=$HOME/.signatrues/	# append your default signature here.
target=""

usage() {
  cat <<EOF
Usage: $0 [options] [targetfile]
Options:
  -f file     Specify target file (alternative to positional)
  -s sig      Select signature to stamp (default: $sig)
  -h          Show this help
If both -f and a positional file are given, -f takes precedence.
EOF
  exit 2
}

# Parse options
while getopts ":f:s:h" opt; do
  case $opt in
    f) target="$OPTARG" ;;
    s) sig="$OPTARG" ;;
    h) usage ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage ;;
    :) echo "Option -$OPTARG requires an argument." >&2; usage ;;
  esac
done
shift $((OPTIND-1))

# Positional argument (if -f not used)
if [[ -z "$target" ]]; then
  if [[ $# -ge 1 ]]; then
    target="$1"
  fi
fi

# Validate target
if [[ -z "$target" ]]; then
  echo "Error: no target file specified." >&2
  usage
fi

cat $sig >> $target

echo "Appended signature to: $target"
