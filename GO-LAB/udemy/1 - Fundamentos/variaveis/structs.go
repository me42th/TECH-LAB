package variaveis

import "fmt"

type usuario struct {
	Nome     string
	idade    byte
	endereco endereco
	Str      func()
}

type endereco struct {
	rua    string
	numero uint16
}

func New() usuario {

	end := endereco{"Rua Exemplo", 42}
	usuario1 := usuario{"Pessoa", 24, end, func() { fmt.Println("u3") }}
	fmt.Println(usuario1)
	return usuario1
}
