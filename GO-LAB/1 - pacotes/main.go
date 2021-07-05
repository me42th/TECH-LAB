package main

import (
	"fmt"
	"modulo/auxiliar"

	"github.com/badoux/checkmail"
)

func main() {
	fmt.Println("main")
	auxiliar.Escrever()
	erro := checkmail.ValidateFormat("email@abc.com")
	fmt.Println(erro)
}
