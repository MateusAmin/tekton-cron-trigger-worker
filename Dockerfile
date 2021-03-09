# Dockerfile for creating a statically-linked Rust application using docker's
# multi-stage build feature.
FROM ekidd/rust-musl-builder AS builder

COPY --chown=rust:rust ./ ./
RUN cargo build --release --target x86_64-unknown-linux-musl

RUN cargo install --force cargo-strip
RUN cargo strip

FROM scratch
COPY --from=builder \
    /home/rust/src/target/x86_64-unknown-linux-musl/release/tk-cron-worker \
    /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/tk-cron-worker"]