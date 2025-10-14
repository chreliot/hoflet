#!/usr/bin/env bash

# Error reporting
set -euo pipefail
IFS=$'\n\t'

### SET VARIABLES ###

# Interactively get the name and purpose to store in variables.
read -r -p "Last name: " subject_name
echo "You entered: ${subject_name}."

read -r -p "Purpose: " purpose
echo "You entered: ${purpose}."

designator="${subject_name}-${purpose}"
echo "Designator is ${designator}."

### CREATE DIRECTORIES ###

mkdir -v $designator
cd $designator

mkdir -v materials

### CREATE TEMPLATE FILES ###

# Taskpaper

cat > $designator.taskpaper <<EOF
$designator letter tasks:

EOF

# TeX letter body

cat > $designator.tex <<'EOF'
\documentclass{hoflet}

\recipient}{}
\salutation}{}
\mailingaddress}{}

\begin{document}



\end{document}
EOF

echo "Generated directories and files."

### GIT ###

git init

# Fetch TeX gitignore from github using github cli.
gh repo gitignore view TeX > .gitignore

git add .
git commit -m "initial commit"

echo "Initiated git."