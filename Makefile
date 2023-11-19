export GOBIN=$(PWD)/bin

.PHONY: all
all: tests helm-docs

.PHONY: tests
tests:
	cd tools && go install helm.sh/helm/v3/cmd/helm
	./scripts/test.sh

.PHONY: helm-docs
helm-docs:
	cd tools && go install github.com/norwoodj/helm-docs/cmd/helm-docs
	./bin/helm-docs
