package main

import (
	"cmp"
	"encoding/json"
	"fmt"
	"math/rand"
	"net/http"
	"slices"
	"strings"
	"time"

	"github.com/rs/cors"
)

// Request body structure
type RequestData struct {
	Names []string `json:"names"`
	Count int      `json:"count"`
}

// Response structure
type ResponseData struct {
	RandomChoices []NameFrequency `json:"randomChoices"`
}

// NameFrequency holds a name and its frequency count
type NameFrequency struct {
	Name  string `json:"name"`
	Count int    `json:"count"`
}

func randomizeHandler(w http.ResponseWriter, r *http.Request) {
	// Decode the incoming request
	var requestData RequestData
	err := json.NewDecoder(r.Body).Decode(&requestData)
	if err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	// Create a new random source and generator
	randGen := rand.New(rand.NewSource(time.Now().UnixNano()))

	// Create a map to track the frequency of each name
	nameCounts := make(map[string]int)

	// Pick random names 'Count' times
	for range requestData.Count {
		randomIndex := randGen.Intn(len(requestData.Names))
		selectedName := requestData.Names[randomIndex]
		nameCounts[selectedName]++
	}

	// Create a slice of NameFrequency to store names and their frequencies
	var nameFrequencyList []NameFrequency
	for name, count := range nameCounts {
		nameFrequencyList = append(nameFrequencyList, NameFrequency{
			Name:  name,
			Count: count,
		})
	}

	// Sort the nameFrequencyList by Count in descending order
	// If counts are the same, sort alphabetically by name
	slices.SortFunc(nameFrequencyList, func(a, b NameFrequency) int {
		if n := cmp.Compare(a.Count, b.Count); n != 0 {
			return n * -1
		}
		return strings.Compare(strings.ToLower(a.Name), strings.ToLower(b.Name))
	})

	// Create response data
	responseData := ResponseData{
		RandomChoices: nameFrequencyList,
	}

	// Set the content type to application/json and send the response back
	w.Header().Set("Content-Type", "application/json")
	err = json.NewEncoder(w).Encode(responseData)
	if err != nil {
		http.Error(w, "Failed to encode response", http.StatusInternalServerError)
	}
}

func main() {
	// Create a new CORS handler that allows all origins
	corsHandler := cors.New(cors.Options{
		AllowedOrigins: []string{"*"},
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders: []string{"Content-Type"},
	})

	// Set up the route and handler
	http.HandleFunc("/api/randomize", randomizeHandler)

	// Apply the CORS handler to the HTTP server
	handler := corsHandler.Handler(http.DefaultServeMux)

	// Start the server
	port := ":3000"
	fmt.Println("Server is running at", port)
	if err := http.ListenAndServe(port, handler); err != nil {
		fmt.Println("Error starting server:", err)
	}
}
