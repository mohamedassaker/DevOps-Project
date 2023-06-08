FROM golang:1.16-alpine as builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:3.13

WORKDIR /app

COPY --from=builder /app/app .

ENV MYSQL_HOST="db"
ENV MYSQL_USER="root"
ENV MYSQL_PASS="secret"
ENV MYSQL_PORT="3306"

EXPOSE 9090

CMD ["./app"]