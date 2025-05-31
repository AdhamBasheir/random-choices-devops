package metrics

import (
	"net/http"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Exported metric you can increment from other packages
var RandomizeRequests = promauto.NewCounter(
	prometheus.CounterOpts{
		Name: "randomize_http_requests_total",
		Help: "Total number of calls to /randomize endpoint",
	},
)

// returns a Prometheus HTTP handler for metrics
func MetricsHandler() http.Handler {
	return promhttp.Handler()
}
