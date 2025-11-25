#!/bin/bash

TARGET_VER=$1
FILE="package-version.json"

# Check if version argument is provided
if [ -z "$TARGET_VER" ]; then
  echo "Usage: $0 <semver-version>"
  echo "Example: $0 0.0.5"
  exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "File $FILE not found."
    exit 1
fi

# 1. jq: Extracts "version" (key) and "tarball" (value)
# 2. sort -V: Sorts the lines by version number intelligently
# 3. awk: Splits the versions by "." and compares Major, Minor, and Patch numbers

jq -r '.versions | to_entries[] | "\(.key) \(.value.dist.tarball)"' "$FILE" | \
sort -V | \
awk -v target="$TARGET_VER" '
  function is_greater(v_str, t_str) {
    split(v_str, v, ".")
    split(t_str, t, ".")
    
    # Compare Major
    if (v[1]+0 > t[1]+0) return 1
    if (v[1]+0 < t[1]+0) return 0
    
    # Compare Minor
    if (v[2]+0 > t[2]+0) return 1
    if (v[2]+0 < t[2]+0) return 0
    
    # Compare Patch
    if (v[3]+0 > t[3]+0) return 1
    return 0
  }
  {
    # $1 is the version from file, $2 is the tarball URL
    if (is_greater($1, target)) {
      print $2
    }
  }
'
