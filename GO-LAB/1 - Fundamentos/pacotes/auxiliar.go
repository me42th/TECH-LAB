package pacotes

import (
	"fmt"
	"github.com/badoux/checkmail"
)

func Escrever() {
	fmt.Println("Auxiliar")
	erro := checkmail.ValidateFormat("email@abc.com")
	fmt.Println(erro)
	escrever2()
}
