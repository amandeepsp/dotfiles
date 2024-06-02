#!/bin/zsh

##
# Prompt theme
#

autoload colors && colors

# Reduce startup time by making the left side of the primary prompt visible
# *immediately.*

if command -v starship > /dev/null; then
    znap eval starship 'starship init zsh --print-full-init';
    znap prompt
else
    echo "starship not installed";
fi
