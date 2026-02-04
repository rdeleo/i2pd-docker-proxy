# Build i2pd from source (latest version from GitHub)
FROM debian:trixie-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        build-essential \
        libboost-date-time-dev \
        libboost-filesystem-dev \
        libboost-program-options-dev \
        libboost-system-dev \
        libssl-dev \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

ARG I2PD_BRANCH=openssl

WORKDIR /src
RUN git clone --depth 1 -b ${I2PD_BRANCH} https://github.com/PurpleI2P/i2pd.git \
    && cd i2pd \
    && make -j$(nproc)

# Runtime image
FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        gosu \
        libboost-date-time1.83.0 \
        libboost-filesystem1.83.0 \
        libboost-program-options1.83.0 \
        libboost-system1.83.0 \
        libssl3t64 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Create i2pd user with specific UID for consistent volume permissions
RUN useradd -r -u 1000 -m -d /home/i2pd -s /usr/sbin/nologin i2pd

# Copy built binary and certificates from builder
COPY --from=builder /src/i2pd/i2pd /usr/bin/i2pd
COPY --from=builder /src/i2pd/contrib/certificates /usr/share/i2pd/certificates

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set up data directory with correct ownership
RUN mkdir -p /home/i2pd/data/certificates \
    && ln -sf /usr/share/i2pd/certificates/family /home/i2pd/data/certificates/family \
    && ln -sf /usr/share/i2pd/certificates/reseed /home/i2pd/data/certificates/reseed \
    && chown -R i2pd:i2pd /home/i2pd

# Declare volume so Docker preserves ownership
VOLUME /home/i2pd/data

WORKDIR /home/i2pd

# Run entrypoint as root to fix volume permissions, then drop to i2pd user
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["--datadir=/home/i2pd/data"]
