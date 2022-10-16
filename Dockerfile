FROM eclipse-temurin:11-alpine

ENV PATH $PATH:/root/google-cloud-sdk/bin

RUN apk update && \
    apk upgrade \
    && apk add --no-cache curl bash python3 \
    && ln -sf python3 /usr/bin/python \
    && curl -sSL https://sdk.cloud.google.com | sh \
    && gcloud components install beta cloud-datastore-emulator --quiet \
    && rm -rf /var/lib/apt/lists/*

CMD gcloud beta emulators datastore start \
    --project=emulated \
    --no-store-on-disk \
    --consistency=1.0 \
    --host-port=0.0.0.0:8765
