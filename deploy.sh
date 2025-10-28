#!/usr/bin/env bash

# Bash script to deploy hoflet class to texmf folder
# CE 2025-10-28

# Error reporting
set -euo pipefail
IFS=$'\n\t'



rsync -ar ~/code/prodscr/hoflet.cls ~/Library/texmf/tex/latex/hoflet.cls

# report

echo -e "\033[0;32m Attempted to deploy hoflet class to texmf tree. \033[0m"
