#!/bin/bash

##
# Create symlinks to include common sources in examples.
# 
# Symlinking directories into the examples is a workaround to avoid
# duplicating loads of files when including stand-alone examples as Meson
# projects.
#
# NOTE: Symlinks are found recursively from the present working directory and
# deleted before creating symlinks in order to prevent accidentally creating
# recursive symlinks.

# Find all symlinks from pwd down and delete them as a guardrail to avoid
# accidentally creating recursive symlinks.
# 
find . -type l -delete

# Provide build-systems to all subprojects.
# 
ln -s $(pwd)/build-systems $(pwd)/examples/lp-f28379d/bme280/build-systems;

# Provide project root to examples as a subproject.
#
# While developing this repo (embedded-c-hal), the changes won't be included
# through the wrap dependency because only the HEAD of main will be pulled from
# GitHub. To solve this, the root of the repo is symlinked into the subprojects
# dir, so the current state of the local files is included instead of the remote
# files from the repo on GitHub. 
# 
ln -s $(pwd) $(pwd)/examples/lp-f28379d/bme280/subprojects/embedded-hal-c;

# Symlink external dependencies into subprojects.
