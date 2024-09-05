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

### Provide build-systems to all subprojects.
ln -s $(pwd)/build-systems $(pwd)/examples/ti/lp-f28379d/bme280/build-systems;

# Symlink bsp and external dependencies into subprojects.
