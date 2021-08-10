package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	for {
		status, code := webVerify("https://random-status-code.herokuapp.com")
		makeResult(status, code)
		time.Sleep(2 * time.Second)
	}
}

func webVerify(site string) (bool, int) {
	request, _ := http.Get(site)
	return request.StatusCode == 200, request.StatusCode
}

func makeResult(status bool, code int) {
	if status {
		fmt.Print("Online ")
	} else {
		fmt.Print("Offline ")
	}
	fmt.Println(code)
}
