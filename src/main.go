package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "Hello Gin",
		})
	})

	if err := r.Run(); err != nil {
		fmt.Fprintf(os.Stderr, "failed to run: %v\n", err)
		os.Exit(1)
	}
}
