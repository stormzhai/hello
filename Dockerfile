FROM golang:latest as build-dev

ENV GO111MODULE=on
ENV BUILDPATH=gitlab.com/solacowa/hello
#ENV GOPROXY=goproxy.io
ENV GOPATH=/go
RUN mkdir -p /go/src/${BUILDPATH}
COPY ./ /go/src/${BUILDPATH}
RUN cd /go/src/${BUILDPATH}/cmd/client && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install -v
RUN cd /go/src/${BUILDPATH}/cmd/server && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go install -v

FROM alpine:latest

COPY --from=build-env /go/bin/hello /go/bin/hello
WORKDIR /go/bin/
CMD ["/go/bin/hello"]