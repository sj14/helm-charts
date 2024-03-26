export GOBIN=$(PWD)/bin

.PHONY: all
all: go-mod-tidy tests helm-docs

.PHONY: go-mod-tidy
go-mod-tidy:
	cd tools && go mod tidy

.PHONY: tests
tests:
	cd tools && \
	go install \
		helm.sh/helm/v3/cmd/helm \
		github.com/yannh/kubeconform/cmd/kubeconform
	./scripts/test.sh

.PHONY: helm-docs
helm-docs:
	cd tools && go install github.com/norwoodj/helm-docs/cmd/helm-docs
	./bin/helm-docs
