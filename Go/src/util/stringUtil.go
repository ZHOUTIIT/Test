package util

import (
	"math"
	"strconv"
)

//SumofAdajcentDifference return the sum of adjacent differenct of a int string
func SumofAdajcentDifference(s string) int {
	sum := 0
	for i := 0; i < len(s)-1; i++ {
		a, _ := strconv.Atoi(string(s[i]))
		b, _ := strconv.Atoi(string(s[i+1]))
		sum += int(math.Abs(float64(b - a)))
	}
	return sum
}

//Assign assign the string
func Assign(s *string, c byte, i int) {
	mbyte := []byte(*s)
	mbyte[i] = c
	*s = string(mbyte)

}

//Swap swap the ath and bth char in a string s
func Swap(s *string, a int, b int) {
	mbyte := []byte(*s)
	tmp := mbyte[a]
	mbyte[a] = mbyte[b]
	mbyte[b] = tmp
	*s = string(mbyte)
}

//Reversed return the reversed s
func Reversed(s string) string {
	var str string
	for i := 0; i < len(s); i++ {
		str = str + string(s[len(s)-1-i])
	}
	return str
}
