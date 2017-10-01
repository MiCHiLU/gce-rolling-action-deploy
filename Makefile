all: build

NAME=sample
PROJECT=project

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
  go build -a -installsuffix cgo -o bin/main \
  -ldflags "-s -w"

gce: cloud-config.yml
	gcloud compute instance-templates create \
  --image-family cos-stable \
  --image-project cos-cloud \
  --machine-type f1-micro \
  --metadata-from-file user-data=$< \
  --scopes="cloud-platform" \
  --tags="http-server" \
  --project ${PROJECT} \
  --region us-west1 \
  ${NAME}-local-$(shell git describe --always --tags --dirty)
