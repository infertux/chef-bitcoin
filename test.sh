#!/bin/bash -eu

set -o pipefail

# e.g. to use filter: ./test.sh KITCHEN_VARIANT=abc
filter="${1:-}"

envs="$(grep -Eo 'KITCHEN_PLATFORM=.*$' .travis.yml | grep -v 'KITCHEN_PLATFORM=ubuntu')"

[ "$filter" ] && envs=$(echo "$envs" | grep "$filter")

echo "### Envs to test:"
echo "$envs"

IFS=$'\n'
for vars in $envs; do
  echo
  echo "### Testing $vars"
  eval "$vars bundle exec kitchen converge"
  eval "$vars bundle exec kitchen verify" && eval "$vars bundle exec kitchen destroy"
done
