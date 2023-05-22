
docker build . -t quotes
docker login docker-registry-default.cpdh.orizon.local
docker tag quotes docker-registry-default.cpdh.orizon.local/fature-auditado-dev/quotes:1.0
docker tag quotes docker-registry-default.cpdh.orizon.local/fature-auditado-dev/quotes:latest
docker push  docker-registry-default.cpdh.orizon.local/fature-auditado-dev/quotes:1.0
docker push  docker-registry-default.cpdh.orizon.local/fature-auditado-dev/quotes:latest