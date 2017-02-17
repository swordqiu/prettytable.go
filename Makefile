#####################################################

REPO_PREFIX := github.com/swordqiu/prettytable.go.git

#####################################################

ROOT_DIR := $(shell pwd)
BUILD_DIR := $(ROOT_DIR)/_output

GO_ENV := GOPATH=$(BUILD_DIR)
GO_BUILD := $(GO_ENV) go build
GO_INSTALL := $(GO_ENV) go install
GO_TEST := $(GO_ENV) go test

PKGS := $(GO_ENV) go list all | grep $(REPO_PREFIX) | xargs

all: build

install: prepare_dir
	$(GO_INSTALL) $$($(PKGS))

build: prepare_dir
	$(GO_BUILD) $$($(PKGS))

test: prepare_dir
	$(GO_TEST) $$($(PKGS))

prepare_dir: pkg_dir src_dir bin_dir

pkg_dir: output_dir
	@mkdir -p $(BUILD_DIR)/pkg

bin_dir: output_dir
	@mkdir -p $(BUILD_DIR)/bin

src_dir: output_dir
	@mkdir -p $(BUILD_DIR)/src
	@mkdir -p $(BUILD_DIR)/src/$(REPO_PREFIX)
	@rsync -avzuq $(ROOT_DIR)/ $(BUILD_DIR)/src/$(REPO_PREFIX)/

output_dir:
	@mkdir -p $(BUILD_DIR)

.PHONY: all build prepare_dir clean

clean:
	@rm -fr $(BUILD_DIR)
