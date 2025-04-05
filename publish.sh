#!/bin/bash

IMAGE_NAME=docker-code-server
VERSION=`date +%Y-%m-%d`

case "$1" in
	docker)
		echo "Publishing ${IMAGE_NAME} in version ${VERSION}"
		docker login ghcr.io -u AlbertWeichselbraun --password-stdin < ../github-token.txt
		docker build -t ${IMAGE_NAME}:${VERSION} .

		# Step 2: Tag
        docker tag ${IMAGE_NAME}:${VERSION} ghcr.io/albertweichselbraun/${IMAGE_NAME}:${VERSION}
        docker tag ${IMAGE_NAME}:${VERSION} ghcr.io/albertweichselbraun/${IMAGE_NAME}:latest

		# Step 3: Publish
		docker push ghcr.io/albertweichselbraun/${IMAGE_NAME}:${VERSION}
		docker push ghcr.io/albertweichselbraun/${IMAGE_NAME}:latest
		;;
esac
