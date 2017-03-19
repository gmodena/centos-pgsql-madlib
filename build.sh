#!/usr/bin/env bash
source env.sh

docker build --build-arg PG_VERSION=${PG_VERSION} --build-arg PG_MINOR=${PG_MINOR} --build-arg PG_CENTOS=${PG_CENTOS} --build-arg PG_PORT=${PG_PORT} --build-arg MADLIB_VERSION=${MADLIB_VERSION} --build-arg PG_PGDG_VERSION=${PG_PGDG_VERSION} --no-cache -t madlib .
