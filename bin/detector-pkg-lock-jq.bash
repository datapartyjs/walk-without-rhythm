#!/bin/bash

#!/bin/bash

if [ ! -f "package-lock.json" ]; then
    echo "package-lock.json not found"
    exit 1
fi

# 1. recurses through the JSON tree (..)
# 2. selects objects that have both a "version" and "resolved" field (standard for installed packages)
# 3. extracts the name from the key (handling the "node_modules/" prefix common in v3 lockfiles)
# 4. prints unique "Name Version" pairs

#jq -r '
#  [.. | objects | select(has("version") and has("resolved"))] 
#  | map({name: (.name // "unknown"), version: .version}) 
#  | unique 
#  | .[] 
#  | "\(.name) \(.version)"
#' package-lock.json

jq -r '
  .. 
  | .dependencies? 
  | select(.) 
  | to_entries[] 
  | select(.value.version) 
  | "\(.key) \(.value.version)"
' package-lock.json | sort -u

