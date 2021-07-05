package variaveis

func soma(p1, p2 int) int {
	return p1 + p2
}

func sub(p1, p2 int) int {
	return p1 - p2
}

func mut(p1, p2 int) int {
	return p1 * p2
}

func Funcoes(p1, p2 int) (int, int) {
	var f1 = func(p1, p2 int) (int, int, int) {
		return soma(p1, p2), sub(p1, p2), mut(p1, p2)
	}
	var v1, v2, _ = f1(p1, p2)
	return v1, v2
}
