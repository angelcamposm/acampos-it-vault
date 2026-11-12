SHELL = /usr/bin/bash

QUARTZ_GIT_TAG := v5.1.0

build:  ## Build the obsidian vault with quartz project
	@echo "Building Quartz"
	@cd ./quartz; \
	npx quartz build

clean:
	@rm -rf quartz/{*,.*}

clean-content:
	@rm -rf ./quartz/content/{*,.*}

clean-public:
	@rm -rf ./quartz/public/{*,.*}

clone: clean
	@echo "Clone Quartz repository on branch $(QUARTZ_GIT_TAG)"
	@rm -f ./quartz/.gitkeep
	@git clone --branch $(QUARTZ_GIT_TAG) https://github.com/jackyzha0/quartz.git quartz
	@rm -rf ./quartz/.git

install:  ## Install quartz dependencies and plugins
	@echo "Installing dependencies"
	@cd quartz; npm install --ignore-scripts; npm run install-plugins;

prepare: copy-config copy-vault copy-robots
	@echo "Removing obsidian config files"
	@rm -rf ./quartz/content/.obsidian/

copy-config:
	@echo "Copying Quartz configuration"
	@cp ./build/quartz.config.yaml ./quartz

copy-robots:
	@echo "Copying robots.txt file"
	@cp ./build/robots.txt ./quartz/content/

copy-vault:
	@echo "Copying Obsidian Vault"
	@cp -a ./vault/. ./quartz/content/