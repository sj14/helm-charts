#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o errtrace

export GOBIN="${GOBIN:-/usr/local/bin}"

fail_count=0
results=()

for dir in charts/*; do
    values_dir="$dir/tests/values"
    output_dir="$dir/tests/outputs"
    expected_dir="$dir/tests/expected_outputs"  # Directory for expected outputs

    [[ -d "$values_dir" ]] || { echo "Directory $values_dir not found."; continue; }
    [[ -d "$output_dir" ]] || mkdir -p "$output_dir"
    [[ -d "$expected_dir" ]] || { echo "Directory $expected_dir not found."; continue; }

    for file in "$values_dir"/*yaml; do
        output_file="${output_dir}/$(basename "$file")"
        echo "helm ${file}"
        "${GOBIN}/helm" template "$dir" -f "$file" --include-crds --namespace test-namespace > "$output_file"

        # Check if the output matches the expected content
        if diff -q "$output_file" "${expected_dir}/$(basename "$file")" > /dev/null; then
            results+=("$(printf "%-60s OK" "$output_file")")
        else
            results+=("$(printf "%-60s FAIL" "$output_file")")
            ((fail_count++))
        fi
    done
done

for dir in charts/*; do
    output_dir="$dir/tests/outputs"

    [[ -d "$output_dir" ]] || { echo "Directory $output_dir not found."; continue; }

    for file in "$output_dir"/*yaml; do
        echo "kubeconform ${file}"
        "${GOBIN}/kubeconform" -strict "$file"
    done
done

echo -e "\nValidation Results:\n"
printf "%-60s %-4s\n" "Output Directory" "Result"
printf "%-60s %-4s\n" "--------------------------------------------" "------"
for entry in "${results[@]}"; do
    echo "$entry"
done

if (( fail_count > 0 )); then
    echo -e "\n$fail_count file(s) did not match expected content."
    exit 1
else
    echo -e "\nAll files matched the expected content."
fi
