#!/bin/sh

chmod +x root/docker-entrypoint.sh
podman build -t socket-proxy .
