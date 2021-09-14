package main

import (
	"fmt"
	"time"
)

type ContaCorrente struct {
	agencia int
	conta   int
	titular string
	saldo   float64
}

func (conta *ContaCorrente) Sacar(valor float64) {
	podeSacar := valor <= conta.saldo && valor > 0
	fmt.Println("Tentativa de saque na conta de " + conta.titular)
	if podeSacar {
		conta.saldo -= valor
		fmt.Println("Saque realizado com sucesso!")
	} else {
		fmt.Println("Não foi possível realizar este saque!")
	}
	fmt.Println("Saldo atual ", conta.saldo)
}

func CriarConta(titular string) *ContaCorrente {
	var nova *ContaCorrente
	nova = new(ContaCorrente)
	nova.agencia = 3356
	nova.conta = 9897
	nova.saldo = 50.
	nova.titular = titular
	return nova
}

func main() {
	var nome string
	var valor float64
	for {
		fmt.Println("Informe o nome do titular")
		fmt.Scan(&nome)
		conta := CriarConta(nome)
		fmt.Println("Informe o valor que será sacado")
		fmt.Scan(&valor)
		conta.Sacar(valor)
	}
	numeros(1, 2, 3, 4, 5, 6, 7, 8, 9)
}

func numeros(numeros ...int) {
	for _, numero := range numeros {
		fmt.Println(numero)
		time.Sleep(time.Second)
	}
}
