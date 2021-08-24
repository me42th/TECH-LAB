package main

import (
	"fmt"
	"os"
)

func main() {
	// abc
	arquivo, err := os.Open("filae.go")
	if err != nil {
		fmt.Println("Ocorreu um erro [", err, "]")
	} else {
		fmt.Println(arquivo)
	}
}
