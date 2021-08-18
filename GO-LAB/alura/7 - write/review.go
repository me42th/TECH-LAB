package main

import (
	"bufio"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"
	"strings"
	"time"
)

func main() {
	for {
		sites := getSites()
		for _, site := range sites {
			result := testSite(site)
			saveSiteStatus(site, result)
		}
		//printLog()
		time.Sleep(1 * time.Second)
	}
}

func testSite(site string) bool {
	response, err := http.Get(site)
	if err != nil {
		return false
	}
	return response.StatusCode == 200
}

func saveSiteStatus(site string, status bool) {
	file, err := openFile("log.txt")
	if err != nil {
		file.Close()
		return
	}
	// https://golang.org/src/time/format.go
	writeFile(file, time.Now().Format("02/01/2006 15:04:05 - ")+site+" "+strconv.FormatBool(status))
	file.Close()
}

func getSites() []string {
	var sites []string
	file, err := openFile("sites.txt")
	if err != nil {
		file.Close()
		return nil
	}
	reader := bufio.NewReader(file)
	for {
		line, err := reader.ReadString('\n')
		site := strings.TrimSpace(line)
		sites = append(sites, site)
		if err == io.EOF {
			break
		}
	}
	file.Close()
	return sites
}

func writeFile(file *os.File, line string) {
	file.WriteString(line + "\n")
}

func openFile(fileName string) (*os.File, error) {
	file, err := os.OpenFile(fileName, os.O_APPEND|os.O_CREATE|os.O_RDWR, 0666)
	return file, err
}

func printLog() {
	file, err := ioutil.ReadFile("log.txt")
	if err != nil {
		fmt.Println("Erro")
	} else {
		fmt.Println(string(file))
	}
}
