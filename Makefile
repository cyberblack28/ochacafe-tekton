help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[\/a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

setup: ## Fetch packages
	go mod download
	go mod tidy

setup/tools: ## Setup development tools
	go build -o bin/errcheck github.com/kisielk/errcheck
	go build -o bin/staticcheck honnef.co/go/tools/cmd/staticcheck

.PHONY: test
test: ## Run all tests
	go test ./... -v -race -cover

.PHONY: lint
lint: fmt vet staticcheck errcheck  ## Run fmt, vet, staticcheck and errcheck

fmt:
	! gofmt -s -d . | grep -E '^'

vet:
	go vet ./...

staticcheck:
	bin/staticcheck ./...

errcheck:
	bin/errcheck ./...
