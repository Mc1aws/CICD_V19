FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libc6 \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*


COPY v19-project.deb /tmp/v19-project.deb

RUN dpkg -i /tmp/v19-project.deb && rm /tmp/v19-project.deb

RUN which v19 && echo "Binary installed at: $(which v19)"

ENTRYPOINT ["/usr/local/bin/v19"]
