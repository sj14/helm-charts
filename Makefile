.PHONY: all
all: tests helm-docs

.PHONY: tests
tests:
	./scripts/test.sh

.PHONY: helm-docs
helm-docs:
	# go install github.com/norwoodj/helm-docs/cmd/helm-docs@v1.10.0
	helm-docs
