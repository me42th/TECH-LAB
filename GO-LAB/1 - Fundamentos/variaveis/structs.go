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

func Objetos() usuario {
	var u1 usuario
	fmt.Println(u1)
	u1.Nome = "David"
	u1.idade = 30
	fmt.Println(u1)

	u2 := usuario{Nome: "Murilo", idade: 11}
	fmt.Println(u2)

	end := endereco{"Rua Nagé", 42}
	u3 := usuario{"Brenda", 24, end, func() { fmt.Println("u3") }}
	fmt.Println(u3)
	return u3
}
