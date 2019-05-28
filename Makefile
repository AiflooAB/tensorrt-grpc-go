#!/usr/bin/make -f

.PHONY: installprotoc get-server proto test

TAG :=v1.2.0
SHELL = /bin/bash

VERSION = $(shell git rev-parse --short HEAD)
PROTO_DIR = ./server/src/core/
PROTO_ROOT_DIR = ./server/
PROTO_OUT_DIR = ./pkg/nvidia_inferenceserver/
SRCDIR = ./server/src/
PROTOS      := $(SRCDIR)/core/api.proto \
               $(SRCDIR)/core/grpc_service.proto \
               $(SRCDIR)/core/model_config.proto \
               $(SRCDIR)/core/request_status.proto \
               $(SRCDIR)/core/server_status.proto


default: get-server proto test

installprotoc:
	@go get -u github.com/golang/protobuf/protoc-gen-go

get-server: 
	rm -rf ./server
	mkdir ./server
	git clone git@github.com:NVIDIA/tensorrt-inference-server.git ./server
	cd ./server;git checkout tags/$(TAG) -b $(TAG);cd ..

# Make the proto files from the specifications
# This requires installation of protocol buffers
# and protoc-gen-go (run make installprotoc)
proto:
	protoc -I=$(PROTO_ROOT_DIR)  $(PROTOS) --go_out=plugins=grpc:$(PROTO_OUT_DIR)
	#workaround on nested dirs
	cp $(PROTO_OUT_DIR)/src/core/*.pb.go $(PROTO_OUT_DIR)
	rm -rf $(PROTO_OUT_DIR)/src

test:
	go build ./...