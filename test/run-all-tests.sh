#!/bin/bash
set -e

# Usage:
#   Run all journey/acceptance tests:
#     ./test/run-all-tests.sh

TEST_COMMAND='npm run test:ci'

export COMPOSE_EXPERIMENTAL_GIT_REMOTE=true

export ACCEPTANCE_TESTS_HOOK="
  docker compose -f https://github.com/DEFRA/grants-ui.git#main:compose.tests.yml -f test/compose.testlocal.yml run --interactive=false -T --quiet-pull --rm grants-ui-grasslands-tests $TEST_COMMAND &&
  docker compose -f https://github.com/DEFRA/grants-ui.git#main:compose.tests.yml down
"

if [ "${CI}" = "true" ]; then
  export ACCEPTANCE_TESTS_HOOK="yes | ${ACCEPTANCE_TESTS_HOOK}"
fi

mkdir -p test/testconfig
cp -r configurations/grasslands/ test/testconfig/grasslands@0.0.0
cp $(dirname "$0")/release.yml test/testconfig/
cp configurations/grasslands/gas/gas.json test/testconfig/gas.schema.json
curl -fsSL \
  https://raw.githubusercontent.com/DEFRA/grants-ui/main/compose/config-broker/local-allowlists/grasslands.yaml \
  -o test/testconfig/grasslands@0.0.0/grants-ui/allowlist.yaml
LAND_GRANTS_TMP="$(mktemp -d)"
git clone --depth 1 https://github.com/DEFRA/grants-config-land-grants.git "$LAND_GRANTS_TMP"
mkdir -p test/testconfig/land-grants@0.0.0
cp -r "$LAND_GRANTS_TMP/configurations/land-grants/." test/testconfig/land-grants@0.0.0/
rm -rf "$LAND_GRANTS_TMP"

"$(dirname "$0")/docker-compose-smoke-test.sh"
