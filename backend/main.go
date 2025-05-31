package main

import (
	"fmt"
	"net/http"
	"random-choice/metrics"
	"random-choice/randomizer"

	"github.com/rs/cors"
)

func main() {
	// Set up the route and handler
	http.HandleFunc("/randomize", randomizer.RandomizeHandler)
	// Set up the metrics endpoint
	http.Handle("/metrics", metrics.MetricsHandler())

	// CORS setup
	corsHandler := cors.New(cors.Options{
		AllowedOrigins: []string{"*"},
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders: []string{"Content-Type"},
	})

	// Apply the CORS handler to the HTTP server
	handler := corsHandler.Handler(http.DefaultServeMux)

	// Start the server
	port := ":3000"
	fmt.Println("Server is running at", port)
	if err := http.ListenAndServe(port, handler); err != nil {
		fmt.Println("Error starting server:", err)
	}
}
