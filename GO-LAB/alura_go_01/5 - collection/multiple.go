package main

import (
	"fmt"
	"net/http"
	"time"
)

const delay = 5

func main() {
	for {
		for _, site := range getSites() {
			isOnline := verifyTest(doTest(site))
			if isOnline {
				fmt.Println(" On  ", site)
			} else {
				fmt.Println(" Off ", site)
			}
		}
		time.Sleep(delay * time.Second)
		fmt.Println("")
	}
}

func getSites() []string {
	sites := []string{"http://google.com.br", "http://github.com", "http://hotmail.com"}
	return sites
}

func doTest(site string) int {
	response, _ := http.Get(site)
	return response.StatusCode
}

func verifyTest(statusCode int) bool {
	fmt.Print(statusCode)
	return statusCode == 200
}
