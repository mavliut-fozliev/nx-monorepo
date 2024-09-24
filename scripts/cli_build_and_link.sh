#!/usr/bin/env bash

if [ ! -f WORKSPACE ]; then
    echo "###########################################"
    echo "Please run this script from workspace root."
    echo "###########################################"
    exit 1;
fi

yarn bazel build //apps/cli:package --config=release

yarn global add "$(pwd)/bazel-bin/apps/cli/package"

echo "###########################################"
echo "Linking was completed successfully."
echo "You may want to invoke cli by running 'spica' in your terminal"
echo "###########################################"

