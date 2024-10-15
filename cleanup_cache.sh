#!/bin/bash

find ~/.emacs.d -name '*.elc' -print0 | xargs -0 --no-run-if-empty rm
find ~/.emacs.d -type d -empty | grep -v .git | xargs --no-run-if-empty rm -r
