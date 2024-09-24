#!/usr/bin/env bash
set -u -e -o pipefail

echo "Building database, bucket, identity and storage packages"
yarn bazel build //apps/api/src/function/packages/database:package //apps/api/src/function/packages/bucket:package //apps/api/src/function/packages/identity:package //apps/api/src/function/packages/storage:package

(cd "./bazel-bin/apps/api/src/function/packages/database/package")
(cd "./bazel-bin/apps/api/src/function/packages/bucket/package")
(cd "./bazel-bin/apps/api/src/function/packages/identity/package")
(cd "./bazel-bin/apps/api/src/function/packages/storage/package")



echo "Now please provide the root directory of functions which you want install these packages locally.";
echo "If you leave empty /private/tmp/functions will be used as default"
read -p "Path: " FUNCTION_PATH
FUNCTION_PATH=${FUNCTION_PATH:=/private/tmp/functions}


for DIR in $FUNCTION_PATH/*
do
  DATABASE_PATH="$DIR/node_modules/@spica-devkit/database"
  BUCKET_PATH="$DIR/node_modules/@spica-devkit/bucket"
  IDENTITY_PATH="$DIR/node_modules/@spica-devkit/identity"
  STORAGE_PATH="$DIR/node_modules/@spica-devkit/storage"

  (mkdir -p $DATABASE_PATH && rsync -ar --no-owner --no-group ./bazel-bin/apps/api/src/function/packages/database/package/* $DATABASE_PATH)
  (cd $DATABASE_PATH && npm install)
  (mkdir -p $BUCKET_PATH && rsync -ar --no-owner --no-group ./bazel-bin/apps/api/src/function/packages/bucket/package/* $BUCKET_PATH)
  (cd $BUCKET_PATH && npm install)
  (mkdir -p $IDENTITY_PATH && rsync -ar --no-owner --no-group ./bazel-bin/apps/api/src/function/packages/identity/package/* $IDENTITY_PATH)
  (cd $IDENTITY_PATH && npm install)
  (mkdir -p $STORAGE_PATH && rsync -ar --no-owner --no-group ./bazel-bin/apps/api/src/function/packages/storage/package/* $STORAGE_PATH)
  (cd $STORAGE_PATH && npm install)
done
