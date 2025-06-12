#!/usr/bin/env bash

set -euo pipefail

# Don't return null result on glob patterns
shopt -s nullglob

# Install bump-cli
npm install -g bump-cli

# For each directory in the hubs/ directory
for hub in hubs/*/; do
    for api in "${hub}"*-source.{yml,yaml,json}; do
        [ -f "${api}" ] || continue
        # Extract the Hub name from directory structure
        hubName="${hub%/*}"
        hubName="${hubName#*/}"

        # Extract the API name from filename `<api_name>-<spec>-source.yaml`
        apiName="${api%-*}"
        apiName="${apiName%-*}"
        apiName="${apiName#*/}"
        apiName="${apiName#*/}"

        # Apply any available overlays from filename
        # `<api_name>-overlay*.yaml`
        for overlay in "${hub}"/"${apiName}"-overlay*.{yml,yaml}; do
            [ -f "${overlay}" ] || continue
            # Overide current api definition file with overlayed
            # definition
            yes | npx bump-cli overlay "${api}" "${overlay}" -o "${api}"
        done

        # Create documentation <apiName> from the api definition file
        tokenKey="${hubName//-/_}_BUMP_TOKEN"
        tokenKey="${tokenKey^^}"
        echo "* API ${apiName} (reading token from ${tokenKey})"
        bump deploy --doc "${apiName}" --token "${!tokenKey}" --hub "${hubName}" --auto-create "${api}"
    done
done

# For each *-source.yaml files in the apis/ directory
for api in apis/*-source.{yml,yaml,json}; do
    # Extract the API name from filename `<api_name>-<spec>-source.yaml`
    apiName="${api%-*}"
    apiName="${apiName%-*}"
    apiName="${apiName#*/}"
    apiName="${apiName#*/}"

    # Create documentation <apiName> from the api definition file
    tokenKey="${apiName//-/_}_BUMP_TOKEN"
    tokenKey="${tokenKey^^}"
    echo "* API ${apiName} (reading token from ${tokenKey})"
    bump deploy --doc "${apiName}" --token "${!tokenKey}" "${api}"
done
