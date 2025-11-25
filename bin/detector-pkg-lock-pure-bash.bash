#!/bin/bash

grep -E '^\s*"[^"]+": \{|^\s*"version":' package-lock.json | \
grep -B1 '"version":' | \
sed -n 's/.*"\([^"]*\)": {/\1/p; s/.*"version": "\([^"]*\)".*/\1/p' | \
xargs -n2 | \
grep -vE "^(dependencies|engines|dist|packages|require)$" | \
sort -u
