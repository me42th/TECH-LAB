package main

import (
	"fmt"
)

type ContaCorrente struct {
	titular       string
	numeroAgencia int
	numeroConta   int
	saldo         float64
	SetTitular    func(titular string)
}

type PessoaFisica struct {
	nome  string
	idade int
}

func main() {
	var david PessoaFisica = PessoaFisica{"David Meth", 31}
	brenda := PessoaFisica{nome: "David Meth", idade: 31}
	var murilo *PessoaFisica
	murilo = new(PessoaFisica)
	murilo.nome = "David Meth"
	murilo.idade = 31
	david2 := &david
	fmt.Println(&david, &david2, &murilo, &brenda)
	fmt.Println(david == *murilo)
	fmt.Println(david == brenda)
	fmt.Println(*murilo == brenda)
	fmt.Println(david2 == murilo)

}

func aula1() {
	conta := getConta()
	fmt.Println(conta)
	conta.SetTitular("Murilo")
	fmt.Println(conta)

}

func getConta() ContaCorrente {
	conta := ContaCorrente{
		titular:       "David",
		numeroAgencia: 123,
		numeroConta:   123,
		saldo:         1.1,
		SetTitular: func(nome string) {
			fmt.Println(nome)
		},
	}
	conta2 := ContaCorrente{"Brenda", 123, 123, 1.1, func(nome string) {
		fmt.Println(nome)
	}}
	conta2.SetTitular("David")
	return conta
}
