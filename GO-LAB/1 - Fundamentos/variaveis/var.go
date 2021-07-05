package variaveis

import "fmt"

func Variaveis() {
	var v1 = "v1"
	v2 := "v2"
	var (
		v3 string = "v3"
		v4 string = "v4"
	)
	fmt.Println(v1, v2, v3, v4)
	v5, v6 := "v5", "v6"
	fmt.Println(v5, v6)
	v5, v6 = v6, v5
	fmt.Println(v5, v6)
	const c1 string = "c1"
	const (
		c2 string = "c2"
		c3 string = "c3"
	)
	fmt.Println(c1, c2, c3)
}
