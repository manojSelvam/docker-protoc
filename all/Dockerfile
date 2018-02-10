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

WORKDIR /tmp
COPY install-protobuf.sh /tmp
RUN chmod +x /tmp/install-protobuf.sh
RUN /tmp/install-protobuf.sh

COPY install-protoc-gen-grpc-javalite.sh /tmp
RUN chmod +x /tmp/install-protoc-gen-grpc-javalite.sh
RUN /tmp/install-protoc-gen-grpc-javalite.sh

RUN git clone https://github.com/googleapis/googleapis

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

COPY --from=build /tmp/googleapis/google /usr/include/google
COPY --from=build /usr/local/include/google /usr/local/include/google


ADD entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /defs
ENTRYPOINT [ "entrypoint.sh" ]