#! /usr/bin/env nix-shell
#! nix-shell -p ghp-import -p jq -i bash

set -eu

SITE=$(nix build --json | jq -r '.[].outputs | to_entries[].value')
ghp-import --message "Automatic update from https://github.com/PValensier/pvalensier.github.io" "$SITE"
git push --force origin gh-pages:gh-pages