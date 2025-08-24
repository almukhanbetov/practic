# Используем официальный образ Go
FROM golang:1.24 AS builder

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем go.mod и go.sum отдельно для кэширования зависимостей
COPY go.mod go.sum ./
RUN go mod download

# Копируем весь проект
COPY . .

# Собираем бинарник
RUN go build -o main .

# Минимальный образ для запуска
FROM alpine:latest  
RUN apk --no-cache add ca-certificates

WORKDIR /root/
COPY --from=builder /app/main .

# Открываем порт
EXPOSE 8080

# Команда по умолчанию
CMD ["./main"]
