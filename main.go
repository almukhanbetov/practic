package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

	// Обработка GET-запроса на /
	r.GET("/", func(c *gin.Context) {
		c.String(200, "HELLO WORLD!")
	})

	// Запуск сервера на порту 8080
	r.Run(":8080")
}
