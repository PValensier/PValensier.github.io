#! /usr/bin/env nix-shell
#! nix-shell -p ghp-import -i bash

set -eu

SITE=$(nix build --no-link .)
ghp-import --message "Automatic update from https://github.com/PValensier/pvalensier.github.io" "$SITE"
git push --force origin gh-pages:gh-pages