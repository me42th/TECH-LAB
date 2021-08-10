package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	sites := monitoringList()
	for i := 0; i < 4; i++ {
		if doTest(sites[i]) == 200 {
			fmt.Println("Nice like a Rice")
		} else {
			fmt.Println("Bad :(")
		}
		time.Sleep(time.Second)
	}
}

func monitoringList() [4]string {
	var sites [4]string
	sites[0] = "https://random-status-code.herokuapp.com"
	sites[1] = "https://google.com.br"
	sites[2] = "http://eaglecloud.io"
	sites[3] = "http://cabra.io"
	return sites
}

func monitoringSlice() []string {
	sites := []string{"abc", "def", "ghi"}
	fmt.Println("Tamanho: ", len(sites))
	fmt.Println("Capacidade: ", cap(sites))
	sites = append(sites, "jkl")
	fmt.Println("Tamanho: ", len(sites))
	fmt.Println("Capacidade: ", cap(sites))
	return sites
}

func doTest(site string) int {
	response, _ := http.Get(site)
	return response.StatusCode
}
