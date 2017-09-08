#!/bin/bash -eu

envs="$(grep -Eo 'KITCHEN_PLATFORM=.*$' .travis.yml)"

IFS=$'\n'
for vars in $envs; do
  echo "$vars"
  eval "$vars bundle exec kitchen converge"
  eval "$vars bundle exec kitchen verify" && eval "$vars bundle exec kitchen destroy"
done
