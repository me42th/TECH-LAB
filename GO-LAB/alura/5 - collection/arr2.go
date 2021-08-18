package main

import (
	"fmt"
	"reflect"
)

func main() {
	var array [4]string
	array[0] = "zero"
	array[1] = "um"
	array[2] = "dois"
	array[3] = "tres"
	fmt.Println(array)
	fmt.Println(reflect.TypeOf(array))
}
