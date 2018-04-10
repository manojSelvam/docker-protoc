ARG alpine=3.6
ARG go=1.9.2

FROM partlab/ubuntu-golang AS build

RUN set -ex && apt-get update && apt-get install -y \
    bash \
    make \
    cmake \
    autoconf \
    automake \
    curl \
    tar \
    libtool \
    g++ \
    git \
    default-jre
	
# use bash instead of dash	
RUN  ln -sf bash /bin/sh

WORKDIR /tmp
COPY install-protobuf.sh /tmp
RUN chmod +x /tmp/install-protobuf.sh
RUN /tmp/install-protobuf.sh

COPY install-protoc-gen-grpc-javalite.sh /tmp
RUN chmod +x /tmp/install-protoc-gen-grpc-javalite.sh
RUN /tmp/install-protoc-gen-grpc-javalite.sh

RUN git clone https://github.com/googleapis/googleapis

FROM swift:latest AS swiftbuild

RUN apt-get -q update \
    && apt-get -q install -y unzip \
    && rm -r /var/lib/apt/lists/*

WORKDIR /tmp
COPY install-swift-protobuf.sh /tmp
RUN chmod +x /tmp/install-swift-protobuf.sh
RUN /tmp/install-swift-protobuf.sh


FROM partlab/ubuntu-golang

#RUN set -ex && apt-get update && apt-get install -y \
#    bash \
#    git \
#    libstdc++

RUN set -ex && apt-get install -y \
    bash \
    git \
    libstdc++

RUN go get -u google.golang.org/grpc
RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN go get -u github.com/micro/protoc-gen-micro

RUN go get github.com/ckaznocha/protoc-gen-lint

RUN go get github.com/gogo/protobuf/proto
RUN go get github.com/gogo/protobuf/jsonpb
RUN go get github.com/gogo/protobuf/protoc-gen-gogo
RUN go get github.com/gogo/protobuf/gogoproto

RUN apt-get update
RUN sudo apt-get install -y clang libicu-dev
RUN sudo apt-get install -y libcurl3 libpython2.7 libpython2.7-dev
RUN wget -q -O - https://swift.org/keys/all-keys.asc | sudo gpg --import -
RUN wget https://swift.org/builds/swift-4.0.3-release/ubuntu1604/swift-4.0.3-RELEASE/swift-4.0.3-RELEASE-ubuntu16.04.tar.gz
RUN sudo tar xzf swift-4.0.3-RELEASE-ubuntu16.04.tar.gz
RUN mv swift-4.0.3-RELEASE-ubuntu16.04 /usr/share/swift

ENV PATH="/usr/share/swift/usr/bin:/usr/share/swift/usr/lib/swift/linux:${PATH}"

RUN swift --version

#RUN ls -la /root/.go/bin/protoc*
#RUN cp /root/.go/bin/protoc_* /usr/local/bin/
RUN ls -la /root/.go/bin
#RUN PATH=$PATH:$GOPATH
#RUN export PATH
ENV PATH="${GOPATH}/bin:${PATH}"

RUN echo $PATH

#RUN cp $GOPATH/bin/protoc_* /usr/local/bin/


#COPY /root/.go/bin/protoc-gen-go /usr/local/bin/
COPY --from=build /tmp/grpc/bins/opt/grpc_* /usr/local/bin/
COPY --from=build /tmp/grpc/bins/opt/protobuf/protoc /usr/local/bin/
COPY --from=build /tmp/grpc/libs/opt/ /usr/local/lib/
COPY --from=build /tmp/grpc-java/compiler/build/exe/java_plugin/protoc-gen-grpc-java /usr/local/bin/
COPY --from=build /tmp/javalite/protoc-gen-javalite /usr/local/bin/

COPY --from=swiftbuild /tmp/grpc-swift/protoc-gen* /usr/local/bin/

COPY --from=build /tmp/googleapis/google /usr/include/google
COPY --from=build /usr/local/include/google /usr/local/include/google


ADD entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /defs
ENTRYPOINT [ "entrypoint.sh" ]