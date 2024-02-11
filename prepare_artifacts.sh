#!/bin/bash

CWD=$(dirname $(readlink -ne $BASH_SOURCE))

set -ex

OTELDB_DIR=$1
if [ $# -lt 1 ] || [ ! -d "$OTELDB_DIR" ]; then
	echo "usage: $0 </path/to/oteldb/repository>" 1>&2
	exit 1
fi

if [ ! -e "$OTELDB_DIR/helm/oteldb/values.yaml" ]; then
	echo "Did you specify a oteldb repository path correctly?"
	echo "command: $0 $1"
	exit 1
fi

CHART_PATH="$OTELDB_DIR/helm/oteldb/Chart.yaml"
VERSION="$(awk '/version:/ { print $2; exit; } ' "$CHART_PATH")"
cd "$OTELDB_DIR/helm"
helm package --destination "$CWD" oteldb
cd -
helm repo index . --merge index.yaml
./generate_readme.sh > README.md
git add README.md index.yaml "oteldb-$VERSION.tgz"
git commit -s -m "feat: add oteldb $VERSION@$(cd "$OTELDB_DIR"; git rev-parse HEAD)"
./fix_dates.sh
git add index.yaml
git commit --amend --no-edit
