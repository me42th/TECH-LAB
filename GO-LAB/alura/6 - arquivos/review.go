package main

import (
	"bufio"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
	"time"
)

func main() {
	for {
		sites := loadDomains()
		time.Sleep(1 * time.Second)
		for _, site := range sites {
			online := doTest(site)
			if online {
				fmt.Println("Online  |", site)
			} else {
				fmt.Println("Offline |", site)
			}
		}
	}
}

func loadDomains() []string {
	var sites []string
	file, err := os.Open("lista.txt")
	if err != nil {
		fmt.Println("Erro ao Abrir o arquivo")
	} else {
		reader := bufio.NewReader(file)
		for {
			linha, err := reader.ReadString('\n')
			site := strings.TrimSpace(linha)
			sites = append(sites, site)
			if err == io.EOF {
				break
			}
		}
	}
	file.Close()
	return sites
}

func doTest(site string) bool {
	response, err := http.Get(site)
	if err != nil {
		return false
	}
	return response.StatusCode == 200
}
