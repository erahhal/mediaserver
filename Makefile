NIX_FILES = $(shell find . -name '*.nix' -type f)

.PHONY: all build run rebuild

all: help

help:
	@echo Usage
	@echo
	@echo "  make setup                    prepare machine to run"
	@echo "  make build-image              build qemu image on host"
	@echo "  make build                    rebuild system from inside guest"
	@echo "  make flash DEVICE=/dev/sda    flash raspberry pi"
	@echo "  make run                      run mediaserver x86 image"
	@echo "  make ssh                      SSH into running mediaserver kvm"

build-image:
	./build-image.sh

build:
	./build.sh

run:
	./run.sh

flash:
ifndef DEVICE
	$(error please set a device, e.g. "make flash DEVICE=/dev/sda")
endif
	./flash.sh $(DEVICE)

setup:
	./setup.sh

ssh:
	ssh-keygen -R "[localhost]:2223"
	ssh -o StrictHostKeychecking=no -p 2223 mediaserver@localhost
