#!/bin/bash

git clone --recursive https://github.com/grpc/grpc-swift.git
cd /tmp/grpc-swift
make

cp /tmp/grpc-swift/protoc-gen* /usr/local/bin/

