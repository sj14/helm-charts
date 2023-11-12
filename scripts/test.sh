#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o errtrace

for dir in charts/*; do
	cd "$dir/tests/values"

	for file in *yaml; do
		echo "./bin/helm ${file}"
		helm template ../../ -f "${file}" --include-crds --namespace test-namespace > "../outputs/${file}"
	done
done
