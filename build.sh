#!/usr/bin/env bash
DOCKER_BUILDKIT=1 docker build -t icculp/jupyter-ai-notebook .
docker image push icculp/jupyter-ai-notebook 

