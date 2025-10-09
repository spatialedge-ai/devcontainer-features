#!/usr/bin/env bash

# This test can be run with the following command (from the root of this repo)
#    devcontainer features test \
#               --features '{"gcloud": {"google-cloud-cli-anthos-auth": true, "google-cloud-cli-cbt": true}}' \
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# List of all available components
ALL_COMPONENTS=(
    "google-cloud-cli-anthos-auth"
    "google-cloud-cli-app-engine-go"
    "google-cloud-cli-app-engine-grpc"
    "google-cloud-cli-app-engine-java"
    "google-cloud-cli-app-engine-python"
    "google-cloud-cli-app-engine-python-extras"
    "google-cloud-cli-bigtable-emulator"
    "google-cloud-cli-cbt"
    "google-cloud-cli-cloud-build-local"
    "google-cloud-cli-cloud-run-proxy"
    "google-cloud-cli-config-connector"
    "google-cloud-cli-datastore-emulator"
    "google-cloud-cli-firestore-emulator"
    "google-cloud-cli-gke-gcloud-auth-plugin"
    "google-cloud-cli-kpt"
    "google-cloud-cli-kubectl-oidc"
    "google-cloud-cli-local-extract"
    "google-cloud-cli-minikube"
    "google-cloud-cli-nomos"
    "google-cloud-cli-pubsub-emulator"
    "google-cloud-cli-skaffold"
    "google-cloud-cli-spanner-emulator"
    "google-cloud-cli-terraform-validator"
    "google-cloud-cli-tests"
)

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check "gcloud version" gcloud --version

# Check components
for component in "${ALL_COMPONENTS[@]}"; do
    var_name=$(echo "$component" | tr 'a-z-' 'A-Z_')
    if [ "${!var_name}" = "true" ]; then
        check "Component '$component' is installed" dpkg -s "$component"
    fi
done


# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults