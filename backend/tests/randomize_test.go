package randomizer

import (
	"math/rand"
	"random-choice/randomizer"
	"reflect"
	"testing"
)

func TestRandomizeNames(t *testing.T) {
	names := []string{"Alice", "Bob", "Charlie"}
	count := 5

	// Use fixed seed for deterministic results
	randGen := rand.New(rand.NewSource(42))

	got := randomizer.RandomizeNames(names, count, randGen)
	want := map[string]int{
		"Alice":   1,
		"Bob":     1,
		"Charlie": 3,
	}

	if !reflect.DeepEqual(got, want) {
		t.Errorf("got: %v, want %v", got, want)
	}
}

func TestSortNameFrequencies(t *testing.T) {
	input := map[string]int{
		"Bob":     2,
		"alice":   3,
		"Charlie": 2,
	}

	got := randomizer.SortNameFrequencies(input)
	want := []randomizer.NameFrequency{
		{Name: "alice", Count: 3},
		{Name: "Bob", Count: 2},
		{Name: "Charlie", Count: 2},
	}

	if !reflect.DeepEqual(got, want) {
		t.Errorf("got: %v, want %v", got, want)
	}
}
