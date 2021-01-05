#!/bin/bash

find ~/.emacs.d -name '*.elc' | xargs --no-run-if-empty rm
find ~/.emacs.d -type d -empty | grep -v .git | xargs --no-run-if-empty rm -r
