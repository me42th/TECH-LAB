package variaveis

import "fmt"

func Operadores() {
	var v1, v2 int8 = 1, 1
	var v3 int16 = 3
	// ERRO: fmt.Println(v1 + v3)
	fmt.Println(v1*v2+v1%v2-v1/(v1+v2), v3)
	// ERRO: v3 = true?1:2
	if v1 == v2 {
		v3 = 5
	} else {
		v3 = 6
	}
	// ERRO: ++v2
	v2++
	// ERRO: --v3
	v3--
	fmt.Println(v2, v3)

}
