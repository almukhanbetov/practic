# 🛠 Этап 1: Сборка бинарника
FROM golang:1.24 AS builder

WORKDIR /app

# Копируем зависимости
COPY go.mod go.sum ./
RUN go mod download

# Копируем остальной код и собираем
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# 🧼 Этап 2: Минимальный образ
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/
COPY --from=builder /app/main .

# (опционально) Проверка, что бинарник есть
RUN ls -la ./main

EXPOSE 8080

# 🚀 Запускаем Go-приложение
CMD ["./main"]
