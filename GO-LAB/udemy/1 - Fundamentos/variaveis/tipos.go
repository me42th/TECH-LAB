package variaveis

import (
	"errors"
	"fmt"
)

func Tipos() {
	var n1 int8 = 123
	var n2 int16 = 456
	var n3 int32 = 234
	var n4 int64 = 123
	var n5 int = 123
	n6 := 123
	n7 := 'a'
	var n8 float32 = 3.14
	var n9 float64 = 3.14
	n10 := 3.14

	var boleano bool = true
	var s1 string = "abc"

	var erro error = errors.New("erro")

	fmt.Println(n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, boleano, s1, erro)
}
