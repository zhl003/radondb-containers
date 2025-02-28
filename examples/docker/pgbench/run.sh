#!/bin/bash
set -u

# Copyright 2016 - 2021 Crunchy Data Solutions, Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/cleanup.sh

docker run \
    -e PG_DATABASE='userdb' \
    -e PG_HOSTNAME='primary' \
    -e PG_PASSWORD='password' \
    -e PG_PORT='5432' \
    -e PG_USERNAME='testuser' \
    -e PGBENCH_BENCHMARK_OPTS='--connect --progress=2' \
    -e PGBENCH_CLIENTS=10 \
    -e PGBENCH_INIT_OPTS='--no-vacuum' \
    -e PGBENCH_JOBS=5 \
    -e PGBENCH_SCALE=5 \
    -e PGBENCH_TRANSACTIONS=100 \
    --name=pgbench \
    --hostname=pgbench \
    --network=pgnet \
    -d $CCP_IMAGE_PREFIX/radondb-pgbench:$CCP_IMAGE_TAG
