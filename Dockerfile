FROM        openjdk:8 as warfile
RUN         mkdir -p /build /unpack
WORKDIR     /unpack
ADD         assets/repack.sh .
ARG         FCREPO_VERSION
ENV         FCREPO_VERSION=4.7.5
RUN         bash ./repack.sh

FROM        jetty:9-jre8
LABEL       org.opencontainers.image.source https://github.com/samvera-labs/docker-fcrepo
USER        root
RUN         mkdir -p /data ${JETTY_BASE}/etc ${JETTY_BASE}/modules
ADD         assets/fedora-entrypoint.sh /
ADD         --chown=jetty:0 assets/fedora.xml ${JETTY_BASE}/webapps/fedora.xml
ADD         --chown=jetty:0 assets/repository.json ${JETTY_BASE}/webapps/repository.json
EXPOSE      8080 61613 61616
ENTRYPOINT  "/fedora-entrypoint.sh"

ARG         FCREPO_VERSION
ENV         FCREPO_VERSION=4.7.5
COPY        --chown=jetty:0 --from=warfile /build/* ${JETTY_BASE}/fedora/

# Add auth files
COPY        --chown=jetty:0 examples/auth/. ${JETTY_BASE}

# For K8s OpenShift, ensure all files and directories are readable and executable by group 0
RUN chgrp -R 0 ${JETTY_BASE} && \
    chmod -R g+rwX ${JETTY_BASE}
RUN chown -R jetty /data && \
    chgrp -R 0 /data && \
    chmod -R g+rwX /data
