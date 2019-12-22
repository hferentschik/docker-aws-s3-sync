IMAGE := hferentschik/aws-s3-sync
VERSION ?= latest

default: docker_build

docker_build:
	@docker build -t $(IMAGE):$(VERSION) \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg BUILD_DATE=$(VERSION) . 

docker_push:
	@docker push $(IMAGE):$(VERSION)

badger:
	@curl -X POST `cat .badgerurl`
