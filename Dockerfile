ARG PYTHON_VERSION=3.8

FROM python:${PYTHON_VERSION}

ENV PIP_OPTIONS "--no-cache-dir --progress-bar off"

RUN apt-get update \
    && apt-get -y install openmpi-bin libopenmpi-dev libopenblas-dev openjdk-11-jdk-headless \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -U pip \
    && pip install ${PIP_OPTIONS} -U setuptools

RUN pip install google-cloud-ndb

RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin
RUN gcloud components install beta cloud-datastore-emulator --quiet

WORKDIR /workspaces
COPY . .

ENV DATASTORE_EMULATOR_HOST 127.0.0.1:8765
CMD ./datastore_emulator.sh
