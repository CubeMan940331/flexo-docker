FROM rust AS build

COPY src/* /tmp/

WORKDIR /tmp
RUN ["unzip", "flexo-master.zip"]
RUN ["unzip", "scruffy-main.zip"]

WORKDIR /tmp/flexo-master/flexo
RUN ["cargo", "build", "--release"]

WORKDIR /tmp/scruffy-main
RUN ["cargo", "build", "--release"]

FROM debian:stable-slim

EXPOSE 7878

RUN apt-get update && \
    apt-get install -y curl

COPY --from=build /tmp/flexo-master/flexo/target/release/flexo /usr/bin/
COPY --from=build /tmp/flexo-master/flexo_purge_cache /usr/bin/
COPY --from=build /tmp/flexo-master/flexo/conf/flexo.toml /etc/flexo/
COPY --from=build /tmp/flexo-master/test/docker-test-local/flexo-server/start_flexo.sh /usr/bin/

COPY --from=build /tmp/scruffy-main/target/release/scruffy /usr/bin/

ENV RUST_BACKTRACE="FULL" \
    RUST_LOG="debug"

ENTRYPOINT ["/usr/bin/start_flexo.sh"]
