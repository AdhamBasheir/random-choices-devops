package randomizer

import (
	"cmp"
	"encoding/json"
	"fmt"
	"math/rand"
	"net/http"
	"random-choice/metrics"
	"slices"
	"strings"
	"time"
)

// Request and Response Data Structures
type RequestData struct {
	Names []string `json:"names"`
	Count int      `json:"count"`
}

type ResponseData struct {
	RandomChoices []NameFrequency `json:"randomChoices"`
}

type NameFrequency struct {
	Name  string `json:"name"`
	Count int    `json:"count"`
}

// RandomizeHandler handles the randomization API request
func RandomizeHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Received request to /randomize")

	// Increment the metric for randomize requests
	metrics.RandomizeRequests.Inc()

	// Decode the incoming request
	var requestData RequestData
	if err := json.NewDecoder(r.Body).Decode(&requestData); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	// Randomize names and get frequency counts
	nameCounts := RandomizeNames(requestData.Names, requestData.Count)

	// Convert to NameFrequency and sort
	nameFrequencyList := SortNameFrequencies(nameCounts)

	// debug output
	fmt.Printf("Received names: %v\n", requestData.Names)
	fmt.Printf("Count: %d\n", requestData.Count)
	fmt.Printf("Randomized names: %v\n", nameFrequencyList)
	// debug output end

	// Respond with sorted name frequencies
	responseData := ResponseData{RandomChoices: nameFrequencyList}
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(responseData); err != nil {
		http.Error(w, "Failed to encode response", http.StatusInternalServerError)
	}
}

// RandomizeNames picks random names and counts their frequency
func RandomizeNames(names []string, count int) map[string]int {
	randGen := rand.New(rand.NewSource(time.Now().UnixNano()))
	nameCounts := make(map[string]int)

	// Pick random names 'Count' times
	for range count {
		randomIndex := randGen.Intn(len(names))
		selectedName := names[randomIndex]
		nameCounts[selectedName]++
	}

	return nameCounts
}

// SortNameFrequencies sorts name frequencies by count (descending) and then alphabetically by name
func SortNameFrequencies(nameCounts map[string]int) []NameFrequency {
	var nameFrequencyList []NameFrequency
	for name, count := range nameCounts {
		nameFrequencyList = append(nameFrequencyList, NameFrequency{Name: name, Count: count})
	}

	// Sort by count (descending) and name alphabetically
	slices.SortFunc(nameFrequencyList, func(a, b NameFrequency) int {
		if n := cmp.Compare(a.Count, b.Count); n != 0 {
			return n * -1
		}
		return strings.Compare(strings.ToLower(a.Name), strings.ToLower(b.Name))
	})

	return nameFrequencyList
}
