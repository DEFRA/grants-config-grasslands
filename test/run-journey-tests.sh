#!/bin/bash
set -e

# Usage:
#   Run all journey/acceptance tests:
#     ./test/run-journey-tests.sh

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
cp configurations/grasslands/fg-gas-backend/grasslands.json test/testconfig/gas.schema.json
curl -fsSL \
  https://raw.githubusercontent.com/DEFRA/grants-ui/main/localstack/config-broker/local-allowlists/grasslands.yaml \
  -o test/testconfig/grasslands@0.0.0/grants-ui/allowlist.yaml

"$(dirname "$0")/docker-compose-smoke-test.sh"
