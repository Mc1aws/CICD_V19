FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libc6 \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY v19-project.deb /tmp/v19-project.deb
RUN dpkg -i /tmp/v19-project.deb && rm /tmp/v19-project.deb

RUN which v19 && echo "Binary installed at: $(which v19)"

CMD ["sh", "-c", "echo '7 25 99 14 88 3 56 102 41 18\n30 45 12 -8 50 22 -15 38 -2 60' | v19"]
