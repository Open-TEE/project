build:
	docker build -f Dockerfile.opentee . -t opentee:latest

shell:
	$(shell mkdir -p ~/.TEE_secure_storage)
	docker run -it --rm=true --net=host --ipc=host \
	--user $(shell id -u):$(shell id -g) \
	-v /tmp:/tmp \
	-v /opt/OpenTee:/opt/OpenTee \
	-v ~/.TEE_secure_storage:/home/docker/.TEE_secure_storage \
	-v ${PWD}/../..:/home/docker/opentee \
	-v /dev/log:/dev/log \
	opentee
