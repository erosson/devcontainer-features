#!/bin/bash
set -e
# https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
source dev-container-features-test-lib

check "execute command" qgis_mapserver --version

reportResults