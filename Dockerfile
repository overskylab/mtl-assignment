FROM golang:1.22 as build
WORKDIR /app
COPY . .
RUN go mod download

ENV GOOS=linux
ENV GOARCH=amd64
ENV CGO_ENABLED=0
RUN go build -o ./output/main ./app/main.go


FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /app/output/main /app/main
WORKDIR /app
EXPOSE 8080
USER 65534:65534
CMD ["/app/main"]
