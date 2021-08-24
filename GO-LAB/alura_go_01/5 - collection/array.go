package main

import (
	"fmt"
	"net/http"
)

func main() {
	sites := getSites()
	for i := 0; i < len(sites); i++ {
		site := sites[i]
		fmt.Print(site)
		if doTest(site) {
			fmt.Println(" Online")
		} else {
			fmt.Println(" Offline")
		}
	}
}

func getSites() [4]string {
	var sites [4]string
	sites[0] = "http://google.com.br"
	sites[1] = "http://facebook.com"
	sites[2] = "http://eaglecloud.io"
	sites[3] = "http://hotmail.com"
	return sites
}

func doTest(site string) bool {
	retorno, _ := http.Get(site)
	return retorno.StatusCode == 200
}
