package main

import "fmt"

func main() {
	slice := []string{"a b c", "d e f", "g h i"}
	inspect(slice)
	increment(&slice, "4 5 6")
	increment(&slice, "4 5 6")
	increment(&slice, "7 8 9")
	increment(&slice, "10 11 12")

}

func increment(slice *[]string, value string) {
	*slice = append(*slice, value)
	inspect(*slice)
}

func inspect(slice []string) {
	fmt.Println(slice)
	fmt.Println("len: ", len(slice))
	fmt.Println("cap: ", cap(slice))
}
