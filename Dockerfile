FROM ghcr.io/r-lib/rig/debian-13-release:latest

USER root

ARG POSITRON_VERSION=2026.10.0-297

# Remove the base image's rig apt repo (fails signature checks on Debian 13)
RUN rm -f $(grep -rl 'rig.r-pkg.org' /etc/apt/sources.list.d 2>/dev/null) ; \
    sed -i '/rig\.r-pkg\.org/d' /etc/apt/sources.list 2>/dev/null || true

# Positron downloads its server into the container, so it needs curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      curl ca-certificates git sudo build-essential && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.positron-server/positron-server-${POSITRON_VERSION} && \
    curl -fSL --retry 5 --retry-delay 3 -o /tmp/positron-server.tar.gz \
      https://cdn.posit.co/positron/releases/reh/x86_64/positron-reh-linux-x64-${POSITRON_VERSION}.tar.gz && \
    tar -xzf /tmp/positron-server.tar.gz \
      -C /root/.positron-server/positron-server-${POSITRON_VERSION} --strip-components=1 && \
    rm /tmp/positron-server.tar.gz