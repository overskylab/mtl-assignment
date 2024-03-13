# Variables
IMAGE_NAME = overskylab/mtl-assignment
TAG := $(or $(tag), latest)

# Build the image
build-image:
	docker build -t $(IMAGE_NAME):$(TAG) .

# Push the image to the registry
push-image:
	docker push $(IMAGE_NAME):$(TAG)

# Build and push the image
build-push-image: build-image push-image

# Build a set of KRM resources
kustomize-build:
	kustomize build manifests/base

# Template the chart
helm-template:
	helm template mtl-assignment ./charts/app -f ./charts/app/values.yaml
