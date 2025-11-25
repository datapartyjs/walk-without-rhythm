#!/bin/bash

#!/bin/bash

if [ ! -f "package.json" ]; then
    echo "package.json not found"
    exit 1
fi

# 1. Read dependencies and devDependencies (defaulting to empty objects if missing)
# 2. Merge them (+)
# 3. Convert to entries (key/value pairs)
# 4. Print as "Package Version"
jq -r '(.dependencies // {}) + (.devDependencies // {}) | to_entries[] | "\(.key) \(.value)"' package.json
