# Этап сборки
FROM golang:1.21 AS builder

WORKDIR /app

# Копируем зависимости
COPY go.mod go.sum ./
RUN go mod download

# Копируем весь проект
COPY . .

# Собираем бинарник с нужной архитектурой
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# Финальный минимальный образ
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/
COPY --from=builder /app/main .

# Проверим, что файл есть
RUN ls -la ./main

# Открываем порт
EXPOSE 8080

# Устанавливаем команду по умолчанию
CMD ["./main"]
