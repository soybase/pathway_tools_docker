#!/bin/bash

Xvfb $DISPLAY &
set -o xtrace
/opt/pathway-tools/pathway-tools -www "$@"
