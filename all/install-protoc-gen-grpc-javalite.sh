#!/bin/bash

# downlaod and install javalite generator. by default java lite is not included with protoc

mkdir javalite
cd javalite
curl -O https://repo1.maven.org/maven2/com/google/protobuf/protoc-gen-javalite/3.0.0/protoc-gen-javalite-3.0.0-linux-x86_64.exe
mv protoc-gen-javalite-3.0.0-linux-x86_64.exe protoc-gen-javalite
chmod 777 protoc-gen-javalite

#mkdir proto-bins
#cd proto-bins
#
#curl -O https://repo1.maven.org/maven2/com/google/protobuf/protoc/3.5.1-1/protoc-3.5.1-1-linux-x86_64.exe
#mv protoc-3.5.1-1-linux-x86_64.exe protoc
#
#curl -O https://repo1.maven.org/maven2/com/google/protobuf/protoc-gen-javalite/3.0.0/protoc-gen-javalite-3.0.0-linux-x86_64.exe
#mv  protoc-gen-javalite-3.0.0-linux-x86_64.exe protoc-gen-javalite
#
#curl -O https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.9.0/protoc-gen-grpc-java-1.9.0-linux-x86_64.exe
#mv protoc-gen-grpc-java-1.9.0-linux-x86_64.exe protoc-gen-grpc-java


