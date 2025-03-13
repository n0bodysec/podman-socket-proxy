FROM lscr.io/linuxserver/socket-proxy:latest

# Podman fix (thanks to @Alex-K37, see https://github.com/Tecnativa/docker-socket-proxy/pull/113)
# RUN sed -i 's|)?|)?(/\\w+)?|g' /templates/default_*

# Add local files
COPY root/ /
