package main

import "fmt"

func main() {
	slice := []string{"Brenda", "Lais", "Murilo", "Fofis"}
	for i, nome := range slice {
		fmt.Println(i, " | ", nome)
	}
}
