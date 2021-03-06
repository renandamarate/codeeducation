FROM golang:1.14.2-alpine3.11 as builder

WORKDIR /
COPY app.go .

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o $(pwd)/bin/app app.go

FROM scratch
# Copy our static executable.
COPY --from=builder /bin/app /bin/app
# Run the hello binary.
ENTRYPOINT ["/bin/app"]