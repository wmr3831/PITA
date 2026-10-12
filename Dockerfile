FROM ghcr.io/r-lib/rig/debian-13-release:latest

USER root

# Remove the base image's rig apt repo (fails signature checks on Debian 13)
RUN rm -f $(grep -rl 'rig.r-pkg.org' /etc/apt/sources.list.d 2>/dev/null) ; \
    sed -i '/rig\.r-pkg\.org/d' /etc/apt/sources.list 2>/dev/null || true

# Positron downloads its server into the container, so it needs curl
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      curl ca-certificates git sudo build-essential && \
    rm -rf /var/lib/apt/lists/*