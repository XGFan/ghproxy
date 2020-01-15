FROM golang:alpine AS builder
WORKDIR /app
ADD . ./
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s"  -o ghproxy .
RUN ls -al

FROM alpine:3
COPY --from=builder /app/ghproxy /app/ghproxy
EXPOSE 1323
ENTRYPOINT ["/app/ghproxy"]