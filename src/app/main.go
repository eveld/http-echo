package main

import (
	"bytes"
	"fmt"
	"net/http"
	"strings"
)

// VERSION is the version of this application.
const VERSION = "0.0.1"

func handler(rw http.ResponseWriter, req *http.Request) {
	s := []string{
		fmt.Sprintf("%s %s %s", req.Method, req.URL.RequestURI(), req.Proto),
		fmt.Sprintf("Host: %s", req.Host),
		fmt.Sprintf("Content-Length: %d", req.ContentLength),
		fmt.Sprintf("Version: %s", VERSION),
	}

	for k, v := range req.Header {
		s = append(s, fmt.Sprintf("%s: %s", k, strings.Join(v, ", ")))
	}

	buf := new(bytes.Buffer)
	buf.ReadFrom(req.Body)
	body := buf.String()
	if body != "" {
		s = append(s, body)
	}

	fmt.Fprint(rw, strings.Join(s, "\n"))
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":80", nil)
}
