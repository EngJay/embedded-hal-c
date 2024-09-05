# Adds symlinks to .gitignore recursively from the working directory.
# 
# This script is intended to be run after symlinks have been created for
# subprojects to prevent git from including them since there are issues across
# platforms.  

find . -type l | sed -e s'/^\.\///g' >> .gitignore
