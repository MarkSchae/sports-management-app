#!/bin/bash

# Create venv
python3 -m venv .venv
source .venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install dependencies
pip install -r requirements.txt

# Create .gitignore if it doesn't exist
cat <<EOL > .gitignore
# Python bytecode
__pycache__/
*.py[cod]
*$py.class

# Virtual environment
.venv/

# Environment variables
.env

# VS Code
.vscode/

# PyCharm
.idea/

# Logs
*.log
EOL

echo ".gitignore created"
