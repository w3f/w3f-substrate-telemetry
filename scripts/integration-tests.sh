#!/bin/bash

source /scripts/common.sh
source /scripts/bootstrap-helm.sh


run_tests() {
    echo Running tests...

    wait_pod_ready substrate-telemetry-backend default 2/2
    wait_pod_ready substrate-telemetry-frontend
}

teardown() {
    helm delete --purge substrate-telemetry
}

main(){
    if [ -z "$KEEP_W3F_SUBSTRATE_TELEMETRY" ]; then
        trap teardown EXIT
    fi

    source /scripts/build-helmfile.sh

    run_tests
}

main
