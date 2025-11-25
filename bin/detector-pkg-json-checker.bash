#!/bin/bash

find . -type f -name "package.json" -print0 | while IFS= read -r -d '' file; do
    if grep -Fq '"preinstall": "node setup_bun.js"' "$file" && ! grep -q '"bun":' "$file"; then
        echo "$file"
    fi
done
