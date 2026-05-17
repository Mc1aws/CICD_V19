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

CMD ["sh", "-c", "echo '1 2 3 4 5 6 7 8 9 100\n10 20 30 40 50 -5 -10 0 25 35' | v19"]
