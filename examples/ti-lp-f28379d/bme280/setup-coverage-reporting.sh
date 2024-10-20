#!/bin/bash

# Create the virtual environment if it doesn't exist
if [ ! -d "env" ]; then
    python3 -m venv env
fi

# Activate the virtual environment
source env/bin/activate

# Install dependencies
pip install -r requirements.txt
