#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o errtrace

for dir in charts/*; do
	rm -R "$dir/tests/outputs/"
	mkdir "$dir/tests/outputs/"
	
	cd "$dir/tests/values"

	for file in *yaml; do
		echo "helm ${file}"
		go tool helm.sh/helm/v3/cmd/helm template ../../ -f "${file}" --include-crds --namespace test-namespace > "../outputs/${file}"
	done
	cd -
done

for dir in charts/*; do
	cd "$dir/tests/outputs"

	for file in *yaml; do
		echo "kubeconform ${file}"
		go tool github.com/yannh/kubeconform/cmd/kubeconform -strict "${file}"
	done
	cd -
done
