FROM r-rig-base:latest

# R version for this project: "release" (the image's default) or e.g. 4.4.3
ARG R_VERSION=release
RUN [ "$R_VERSION" = "release" ] || (rig add "$R_VERSION" && rig default "$R_VERSION")

# Project packages, one per line in packages.txt
COPY packages.txt /tmp/packages.txt
RUN apt-get update && \
    Rscript -e 'p <- trimws(readLines("/tmp/packages.txt")); p <- p[nzchar(p) & !startsWith(p, "#")]; if (length(p)) pak::pak(p)' && \
    rm -rf /var/lib/apt/lists/* /tmp/packages.txt