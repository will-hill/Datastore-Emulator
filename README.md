# Datastore-Emulator

Minimal code to create and run Python based Google Datastore Emulator.
Container spins up, installs gcloud, start datastore emulator, runs Python code.  


```shell
python3 -m venv venv
source venv/bin/activate
python3 -m pip install google-cloud-ndb pytest

docker build -t datastore-emulator . 
docker run --rm -p 8765:8765 --name db datastore-emulator \
  & sleep 5 \
  && pytest
  
docker kill db
```