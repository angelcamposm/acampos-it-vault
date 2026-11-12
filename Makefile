SHELL = /usr/bin/bash

QUARTZ_GIT_TAG := v5.1.0

.PHONY: build
build:  ## Build the obsidian vault with quartz project
	@echo "🔸 Building Quartz"
	@cd ./quartz; npx quartz build

clean:
	@rm -rf quartz/{*,.*}

clone: clean
	@echo "🔸 Clone Quartz repository on branch $(QUARTZ_GIT_TAG)"
	@git clone --branch $(QUARTZ_GIT_TAG) https://github.com/jackyzha0/quartz.git quartz

install:  ## Install quartz dependencies and plugins
	@echo "🔸 Installing dependencies"
	@cd quartz; npm install --ignore-scripts; npm run install-plugins;

prepare: copy-config copy-styles copy-vault
	@echo "🔸 Removing obsidian config files"
	@rm -rf ./quartz/content/.obsidian/

copy-config:
	@echo "🔸 Copying Quartz configuration"
	@cp ./build/quartz.config.yaml ./quartz

copy-robots:
	@echo "🔸 Copying robots.txt file"
	@cp ./build/robots.txt ./quartz/public/

copy-styles:
	@echo "Copying custom CSS"
	@cp ./build/custom.scss ./quartz/quartz/styles/

copy-vault:
	@echo "🔸 Copying Obsidian Vault"
	@cp -a ./vault/. ./quartz/content/

post-build: copy-robots