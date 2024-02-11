#!/bin/bash

set -e

cat << EOF
This repository holds helm templates for the following Cilium releases:

EOF

for version in $(find -- * -name 'cilium-*.tgz' ! -name "*dev*" | cut -d - -f 2- | cut -d . -f -3 | sed '/-/!{s/$/_/}' | sort -Vr | sed 's/_$//'); do
  echo "* [v$version](https://github.com/go-faster/cilium/releases/tag/v$version) (_[source](https://github.com/go-faster/cilium/tree/v$version/install/kubernetes/cilium)_)"
done

cat << EOF

This repository holds helm templates for the following Tetragon releases:

EOF

for version in $(find -- * -name 'tetragon-*.tgz' ! -name "*dev*" | cut -d - -f 2- | cut -d . -f -3 | sed '/-/!{s/$/_/}' | sort -Vr | sed 's/_$//'); do
  echo "* [v$version](https://github.com/go-faster/tetragon/releases/tag/v$version) (_[source](https://github.com/go-faster/tetragon/tree/v$version/install/kubernetes)_)"
done

cat << EOF

The following Cilium development releases pull the latest backports for the corresponding branch:

EOF

for version in $(find -- * -name 'cilium-*-dev.tgz' | cut -d - -f 2 | sort -Vr ); do
  echo "* [v$version-dev](https://github.com/go-faster/cilium/tree/v$version) (_[source](https://github.com/go-faster/cilium/tree/v$version/install/kubernetes/cilium)_)"
done

