package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strings"
)

func main() {
	fmt.Println(getEnv())
}

func getEnv() []string {
	var env []string
	fileName := ".env"
	file, err := openFile(fileName)
	if err != nil {
		fmt.Println("Erro ao abrir o arquivo .env")
		return env
	}
	reader := bufio.NewReader(file)
	for {
		line, err := reader.ReadString('\n')
		site := strings.TrimSpace(line)
		env = append(env, site)
		if err == io.EOF {
			break
		}
	}
	file.Close()
	return env
}

func openFile(fileName string) (*os.File, error) {
	file, err := os.OpenFile(fileName, os.O_APPEND|os.O_CREATE|os.O_RDWR, 0666)
	return file, err
}
