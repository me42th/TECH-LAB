package main

import "fmt"

type ContaCorrente struct {
	titular string
	conta   int
	saldo   float64
}

func main() {
	contas := []ContaCorrente{}
	var numeroConta int = 1
	for {
		conta := new(ContaCorrente)
		fmt.Println("Informe o nome do titular")
		fmt.Scan(&conta.titular)
		fmt.Println("Qual o saldo?")
		fmt.Scan(&conta.saldo)
		numeroConta += 1
		conta.conta = numeroConta
		contas = append(contas, *conta)
		fmt.Println(contas)
	}
}
