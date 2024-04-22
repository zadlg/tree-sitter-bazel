#!/usr/bin/env bash

set -eu

echo "$1" > "${BUILD_WORKSPACE_DIRECTORY}/.bazelversion"
