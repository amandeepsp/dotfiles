#!/bin/zsh

# Zsh Config is based on https://github.com/marlonrichert/zsh-launchpad/

() {
  # Load all of the files in rc.d that start with <number>- and end in `.zsh`.
  local file=
  for file in $ZDOTDIR/rc.d/<->-*.zsh(n); do
    . $file   # `.` is like `source`, but doesn't search your $path.
  done
} "$@"
