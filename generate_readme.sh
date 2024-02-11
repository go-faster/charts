#!/bin/bash

set -e

cat << EOF
This repository holds helm templates for the following oteldb releases:

EOF

for version in $(find -- * -name 'oteldb-*.tgz' ! -name "*dev*" | cut -d - -f 2- | cut -d . -f -3 | sed '/-/!{s/$/_/}' | sort -Vr | sed 's/_$//'); do
  echo "* [v$version](https://github.com/go-faster/oteldb/releases/tag/v$version) (_[source](https://github.com/go-faster/oteldb/tree/v$version/install/kubernetes/oteldb)_)"
done
