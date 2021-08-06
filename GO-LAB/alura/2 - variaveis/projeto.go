package main

import (
	"fmt"
	"reflect"
)

func main() {
	var nome string = "David"
	var versao float32 = 1.1
	fmt.Println("Ola ", nome, " estamos na versão ", versao)
	texto := "valor"
	numero := 1.1
	fmt.Println(reflect.TypeOf(texto))
	fmt.Println(reflect.TypeOf(numero))
	fmt.Println("Informe um numero")
	var valor int
	fmt.Scanf("%d", &valor)
	fmt.Scan(&numero)
	fmt.Println(valor, " | ", &valor)
	fmt.Println(numero, " | ", &numero)
}
