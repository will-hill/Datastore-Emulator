#!/bin/bash -

nohup bash -c "gcloud beta emulators datastore start --project=test --no-store-on-disk --host-port=127.0.0.1:8765 &" && sleep 5
python datastore_emulator.py
