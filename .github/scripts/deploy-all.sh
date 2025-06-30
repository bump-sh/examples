#!/usr/bin/env bash

set -euo pipefail

# Don't return null result on glob patterns
shopt -s nullglob

# Install bump-cli
npm install -g bump-cli

orgaTokenKey="ORGANIZATION_DEMO_BUMP_TOKEN"
echo "Using global token ${orgaTokenKey} for Bump.sh Demo organization"

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
        for overlay in "${hub}""${apiName}"-overlay*.{yml,yaml}; do
            [ -f "${overlay}" ] || continue
            # Overide current api definition file with overlayed
            # definition
            echo "y" | npx bump-cli overlay "${api}" "${overlay}" -o "${api}"
            echo "* API ${apiName}: Overlay ${overlay} applied!"
        done

        # Create documentation <apiName> from the api definition file
        echo "* API ${apiName} (reading token from ${orgaTokenKey})"
        bump deploy --doc "${apiName}" --token "${!orgaTokenKey}" --hub "${hubName}" --auto-create "${api}"
    done
done

# For each *-source.yaml files in the apis/ directory
for api in apis/*-source.{yml,yaml,json}; do
    [ -f "${api}" ] || continue
    echo "Deploying ${api}"

    # Extract the API name from filename `<api_name>-<spec>-source.yaml`
    # Create documentation <apiName> from the api definition file
    apiName="${api%-*}"
    apiName="${apiName%-*}"
    apiName="${apiName#*/}"
    apiName="${apiName#*/}"

    echo "* API ${apiName} (reading token from ${orgaTokenKey}) from file ${api}"
    bump deploy --doc "${apiName}" --token "${!orgaTokenKey}" "${api}"
done
