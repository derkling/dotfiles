#!/bin/bash

SHA1=${1:-HEAD}

git branch kokonuts/$(date +%Y%m%d_%H%M%S) $SHA1
