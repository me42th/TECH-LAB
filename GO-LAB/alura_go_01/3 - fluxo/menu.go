package main

import (
	"fmt"
	"os"
)

func main() {
	opcao := leitura("Informe uma opção[1,2,3]")
	condicionalIf(opcao)
	opcao = leitura("Informe outra opcao[4,5,6]")
	condicionalSwitch(opcao)
	os.Exit(0)
}

func leitura(cabecalho string) int {
	var opcao int
	fmt.Println(cabecalho)
	fmt.Scan(&opcao)
	return opcao
}

func condicionalIf(opcao int) {
	if opcao == 1 {
		fmt.Println("Opcao um")
	} else if opcao == 2 {
		fmt.Println("Opcao dois")
	} else if opcao == 3 {
		fmt.Println("Opcao tres")
	} else {
		fmt.Println("Opcao invalida")
		os.Exit(-1)
	}
}

func condicionalSwitch(opcao int) {
	switch opcao {
	case 4:
		fmt.Println("Opcao quatro")
	case 5:
		fmt.Println("Opcao cinco")
	case 6:
		fmt.Println("Opcao seis")
	default:
		fmt.Println("Opcao invalida")
		os.Exit(-1)
	}
}
