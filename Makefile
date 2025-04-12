.PHONY: all
all: go-mod-tidy tests helm-docs

.PHONY: go-mod-tidy
go-mod-tidy:
	go mod tidy

.PHONY: tests
tests:
	./scripts/test.sh

.PHONY: helm-docs
helm-docs:
	go tool github.com/norwoodj/helm-docs/cmd/helm-docs
