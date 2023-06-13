package main

import (
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		hostname, _ := os.Hostname()
		currentTime := time.Now().Format(time.RFC3339)
		fmt.Fprintf(w, "Current Time: %s\nHostname: %s", currentTime, hostname)
	})

	// Register Prometheus metrics
	http.Handle("/metrics", promhttp.Handler())
	prometheus.MustRegister(prometheus.NewBuildInfoCollector())

	http.ListenAndServe(":8080", nil)
}
