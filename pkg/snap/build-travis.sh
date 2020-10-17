#!/bin/sh

dir="$(dirname "$(readlink -f "$0")")"
solvespace_snap_src="$dir/solvespace-snap-src"
trap "rm -rf $solvespace_snap_src" EXIT

cd "$dir" || travis_terminate $?

git_root="$(git rev-parse --show-toplevel)" || travis_terminate $?
rsync --filter=":- .gitignore" -r "$git_root"/ "$solvespace_snap_src" || travis_terminate $?

snapcraft "$@" || travis_terminate $?
