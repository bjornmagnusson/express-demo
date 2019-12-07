#!/usr/bin/env sh

# Copyright The Helm Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

readonly IMAGE_TAG=v2.4.0
readonly IMAGE_REPOSITORY="quay.io/helmpack/chart-testing"

main() {
    local testcontainer_id
    testcontainer_id=$(create_testcontainer)

    # shellcheck disable=SC2064
    trap "docker container rm --force $testcontainer_id > /dev/null" EXIT
    run_test
}

create_testcontainer() {
    docker container run --interactive --tty --detach \
        --volume "$(pwd):/workdir" --workdir /workdir \
        "$IMAGE_REPOSITORY:$IMAGE_TAG" cat
}

run_test() {
    git fetch origin
    docker exec "$testcontainer_id" ct lint --config="charts/ct_config.yaml"
}

main
