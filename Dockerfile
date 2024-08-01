FROM golang:latest

EXPOSE 8080

COPY src/main.go /go/src/work/

WORKDIR /go/src/work

RUN go get -u github.com/gin-gonic/gin \
&& go build main.go

CMD ["./main"]