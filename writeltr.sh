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

# Make the main directory for the letter and move into it
mkdir -v "$designator"
cd "$designator"

# Make a subfolder for reference materials
mkdir -v "materials"

### CREATE TEMPLATE FILES ###

# Taskpaper

cat > $designator.taskpaper <<EOF
$designator letter tasks:

EOF

# TeX letter body

cat > $designator.tex <<'EOF'
\DocumentMetadata{tagging=on,lang=en-US}
\documentclass[12pt]{hoflet}

\recipient{}
\salutation{}
\mailingaddress{}
\myfullname{Christopher H.~Eliot}
\myposition{Associate Professor}

\begin{document}

\end{document}
EOF

echo "Generated directories and files."

### LATEXMK ###

cat > .latexmkrc <<'EOF'
# latexmkrc for hoflet class

# Use LuaLaTeX
$pdf_mode = 4;

# Display processing time
$show_time = 1;

# Disable BibTeX and Biber
$bibtex_use = 0;
EOF

### GIT ###

git init

# Fetch TeX gitignore from github using github cli.
gh repo gitignore view TeX > .gitignore

git add .
git commit -m "initial commit"

echo "Initiated git."