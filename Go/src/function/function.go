package function

import (
	"bufio"
	"class"
	"fmt"
	"log"
	"math"
	"os"
	"regexp"
	"strconv"
	"strings"
	"util"
)

//Floyd algorithm
func Floyd(w [][]int) {
	n := len(w)
	table := w
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			for k := 0; k < n; k++ {
				table[i][j] = int(math.Min(float64(table[i][j]), float64(table[i][k]+table[k][j])))
			}
		}
	}
	fmt.Println(table)
}

//Knapsack problem
func Knapsack(w []int, v []int, weight int) int {
	n := len(w)
	var table = make([][]int, n+1)
	for i := range table {
		table[i] = make([]int, weight+1)
	}
	for i := 0; i <= n; i++ {
		table[i][0] = 0
	}
	for j := 0; j <= weight; j++ {
		table[0][j] = 0
	}
	for i := 1; i <= n; i++ {
		for j := 1; j <= weight; j++ {
			if j < w[i-1] {
				table[i][j] = table[i-1][j]
			} else {
				table[i][j] = int(math.Max(float64(table[i-1][j]), float64(table[i-1][j-w[i-1]]+v[i-1])))
			}
		}
	}
	fmt.Println(table)
	return table[n][weight]
}

//Numberof2s return number of 2s from 0 to n
func Numberof2s(n int) int {
	count := 0
	for i := 0; i < n+1; i++ {
		str := strconv.Itoa(i)
		count += strings.Count(str, "2")
	}
	return count
}

//AddtwoList add two linked list
func AddtwoList(l1 class.List, l2 class.List) int {
	result := 0.0
	var v1, v2 int
	carry := 0
	bit := 0
	for !l1.Isempty() && !l2.Isempty() {
		v1 = l1.RemoveFront()
		v2 = l2.RemoveFront()
		result += math.Pow10(bit) * float64((v1+v2+carry)%10)
		if v1+v2+carry >= 10 {
			carry = 1
		} else {
			carry = 0
		}
		bit++
	}
	if l1.Isempty() && !l2.Isempty() {
		for !l2.Isempty() {
			v2 = l2.RemoveFront()
			result += math.Pow10(bit) * float64((v2+carry)%10)
			if v2+carry >= 10 {
				carry = 1
			} else {
				carry = 0
			}
			bit++
		}
	} else if l2.Isempty() && !l1.Isempty() {
		for !l1.Isempty() {
			v1 = l1.RemoveFront()
			result += math.Pow10(bit) * float64((v1+carry)%10)
			if v1+carry >= 10 {
				carry = 1
			} else {
				carry = 0
			}
			bit++
		}
	}
	if carry == 1 {
		result += math.Pow10(bit)
	}
	return int(result)
}

// Write an algorithm such that if an element in an MxN matrix is 0,
//its entire row and column is set to 0

//TransferGraph as title
func TransferGraph(g *[][]int) {
	m := len(*g)
	n := len((*g)[0])
	var r string
	var c string
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if (*g)[i][j] == 0 {
				si := strconv.Itoa(i)
				sj := strconv.Itoa(j)
				if !strings.Contains(r, si) {
					r += si
				}
				if !strings.Contains(c, sj) {
					c += sj
				}
			}
		}
	}
	for _, si := range r {
		row, _ := strconv.Atoi(string(si))
		for i := 0; i < n; i++ {
			(*g)[row][i] = 0
		}
	}
	for _, sj := range c {
		column, _ := strconv.Atoi(string(sj))
		for i := 0; i < m; i++ {
			(*g)[i][column] = 0
		}
	}
}

//RotateGraph rotate a graph by 90 degree
func RotateGraph(g *[][]int) {
	n := len(*g)
	for i := 0; i < n/2; i++ {
		rotateout(g, i)
	}
}

func rotateout(g *[][]int, layer int) {
	n := len(*g)
	for i := 0; i < n-2*layer-1; i++ {
		tmp := (*g)[layer+i][layer]
		(*g)[layer+i][layer] = (*g)[n-1-layer][layer+i]
		(*g)[n-1-layer][layer+i] = (*g)[n-1-layer-i][n-1-layer]
		(*g)[n-1-layer-i][n-1-layer] = (*g)[layer][n-1-layer-i]
		(*g)[layer][n-1-layer-i] = tmp
	}
}

//GenerateMeanDev getnerate mean and stand deviation
func GenerateMeanDev() ([]float64, []float64) {
	var data [][]float64
	var meanstring []float64
	var stdestring []float64
	var tmpstring []float64
	count := 0
	sum := 0.0
	file, err := os.Open("/Users/Roger/Downloads/Melbourne UNI/2017/COMP90007/project/lab project/ping.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		o, err := regexp.MatchString("time=[\\S]*", line)
		if err != nil {
			print(err)
		}
		if o == true {
			count++
			r, _ := regexp.Compile("time=[\\S]*")
			num := strings.TrimPrefix(r.FindString(line), "time=")
			n, _ := strconv.ParseFloat(num, 64)
			tmpstring = append(tmpstring, n)
			sum += float64(n)
			if count == 15 {
				count = 0
				data = append(data, tmpstring)
				meanstring = append(meanstring, sum/15)
				sum = 0.0
				tmpstring = []float64{}
			}
		}
	}
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	for i, arr := range data {
		std := 0.0
		for _, n := range arr {
			std += math.Pow(n-meanstring[i], 2)
		}
		std = math.Sqrt(std / 14)
		stdestring = append(stdestring, std)
	}
	return meanstring, stdestring
}

//GivenStringReturnHeap return as title
func GivenStringReturnHeap(a []int) []int {
	n := len(a)
	i := int(math.Floor(float64(n / 2)))
	for i != 0 {
		k := i
		v := a[k-1]
		heap := false
		for !heap && k*2 <= n {
			j := 2 * k
			if j < n {
				if a[j-1] < a[j] {
					j++
				}
			}
			if v >= a[j-1] {
				heap = true
			} else {
				a[k-1] = a[j-1]
				k = j
			}
		}
		a[k-1] = v
		i--
	}
	return a
}

//MinimumDifferencebetweenSubset return Minimum difference between max and min of all K-size subsets
func MinimumDifferencebetweenSubset(a []int, k int) int {
	util.InsertionSort(&a)
	min := int(math.MaxInt64)
	for i := 0; i < len(a)-k+1; i++ {
		if a[i+k-1]-a[i] < min {
			min = a[i+k-1] - a[i]
		}
	}
	return min
}

//LargestDivisibleSubset return as title
//TODO: modify the function
func LargestDivisibleSubset(a []int) []int {
	count := []int{}
	subset := []int{}
	for i := 0; i < len(a); i++ {
		c := 0
		for j := 0; j < len(a); j++ {
			if i != j && a[i]%a[j] == 0 {
				c++
			}
		}
		count = append(count, c)
	}
	subset = append(subset, a[util.MaxIndex(count)])
	for i := 0; i < len(a); i++ {
		if subset[0]%a[i] == 0 {

		}
	}
	return subset
}

//WordwithSameCharSet return string set with same char set
func WordwithSameCharSet(s []string) {
	var table = make([][]byte, len(s))
	for i := range table {
		table[i] = make([]byte, 255)
	}
	for i, str := range s {
		for _, c := range str {
			table[i][c] = '1'
		}
	}
	printcharset(s, table)
}
func printcharset(s []string, table [][]byte) {
	var R = make([]byte, len(s))
	for i := 0; i < len(s); i++ {
		R[i] = '1'
	}
	for strings.Contains(string(R), "1") {
		d := strings.Index(string(R), "1")
		for i := 0; i < len(s); i++ {
			if R[i] == '1' && string(table[i]) == string(table[d]) {
				print(s[i], " ")
				R[i] = '0'
			}
		}
		R[d] = '0'
		print("\n")
	}
}

//AllPossibleBalancedParentheses as title
func AllPossibleBalancedParentheses(n int) {
	left := 0
	right := 0
	var str string
	allpossibleHelper(0, &str, n, left, right)
}

func allpossibleHelper(index int, str *string, n int, left int, right int) {
	if len(*str) == 2*n {
		fmt.Println(*str)
		return
	}
	if left > right {
		*str = (*str)[0:index] + "}"
		right++
		allpossibleHelper(index+1, str, n, left, right)
		right--
	}
	if left < n {
		*str = (*str)[0:index] + "{"
		left++
		allpossibleHelper(index+1, str, n, left, right)
		left--
	}
}

//CountStr return number of string with length n, bcount and ccount
func CountStr(n int, bcount int, ccount int) int {
	if bcount < 0 || ccount < 0 {
		return 0
	}
	if n == 0 {
		return 1
	}
	if bcount == 0 && ccount == 0 {
		return 1
	}
	count := CountStr(n-1, bcount, ccount) + CountStr(n-1, bcount-1, ccount) +
		CountStr(n-1, bcount, ccount-1)
	return count
}

//Dijkstra return the shortest path and total weight of the path
func Dijkstra(a [][]int, s int, d int) ([]int, int) {
	var D = make([]int, len(a[0]))
	var P = make([]int, len(a[0]))
	var R string
	var route []int
	route = append(route, d)
	for i := 0; i < len(a[0]); i++ {
		R += strconv.Itoa(i)
		if i == s {
			D[i] = 0
		} else {
			D[i] = math.MaxInt64
		}
	}
	for strings.Count(R, "_") != len(a[0]) {
		smallestindex := minindex(D, &R)
		util.Assign(&R, '_', smallestindex)
		for _, n := range neighbour(a, smallestindex, &R) {
			if D[smallestindex]+a[smallestindex][n] < D[n] {
				D[n] = D[smallestindex] + a[smallestindex][n]
				P[n] = smallestindex
			}
		}
	}
	for route[len(route)-1] != s {
		route = append(route, P[route[len(route)-1]])
	}
	return route, D[d]
}
func minindex(D []int, R *string) int {
	v := math.MaxInt64
	index := 0
	for i, b := range D {
		if strings.Contains(*R, strconv.Itoa(i)) {
			if v > b {
				v = b
				index = i
			}
		}
	}
	return index
}
func neighbour(a [][]int, n int, R *string) []int {
	nei := []int{}
	for i := 0; i < len(a[n]); i++ {
		if a[n][i] != 0 && strings.Contains(*R, strconv.Itoa(i)) {
			nei = append(nei, i)
		}
	}
	return nei
}

//NumberofDecisiontoReachDestination return as title
func NumberofDecisiontoReachDestination(s []string) int {
	row := len(s)
	column := len(s[0])
	start := [2]int{}
	dest := [2]int{}
	for i := 0; i < len(s); i++ {
		if strings.Index(s[i], "S") != -1 {
			start[0] = i
			start[1] = strings.Index(s[i], "S")
		}
		if strings.Index(s[i], "D") != -1 {
			dest[0] = i
			dest[1] = strings.Index(s[i], "D")
		}
	}
	route := []int{}
	route = append(route, start[0]*10+start[1])
	visited := make([][]bool, row)
	for i := range visited {
		visited[i] = make([]bool, column)
	}
	decisionpoint := make([][]bool, row)
	for i := range decisionpoint {
		decisionpoint[i] = make([]bool, column)
	}
	visited[start[0]][start[1]] = true
	from := make([][]string, row)
	for i := range from {
		from[i] = make([]string, column)
	}
	for visited[dest[0]][dest[1]] == false {
		if len(route) == 0 {
			return -1
		}
		move(&decisionpoint, &from, &route, s, route[0]/10, route[0]%10, &visited)
		route = route[1:]
	}
	return gothrough(&decisionpoint, &from, s, dest, start)
}

func gothrough(decisionpoint *[][]bool, from *[][]string, s []string, dest [2]int, start [2]int) int {
	decision := 0
	now := [2]int{dest[0], dest[1]}
	for now != start {
		if (*decisionpoint)[now[0]][now[1]] {
			decision++
		}
		switch (*from)[now[0]][now[1]] {
		case "up":
			now[0]--
			break
		case "down":
			now[0]++
			break
		case "right":
			now[1]++
			break
		case "left":
			now[1]--
			break
		}
	}
	return decision
}

func move(decisionpoint *[][]bool, from *[][]string, route *[]int, s []string, r int, c int, visited *[][]bool) {
	count := 0
	if r-1 >= 0 && string(s[r-1][c]) != "B" && (*visited)[r-1][c] == false {
		*route = append(*route, 10*(r-1)+c)
		(*visited)[r-1][c] = true
		(*from)[r-1][c] = "down"
		count++
	}
	if r+1 <= len(s)-1 && string(s[r+1][c]) != "B" && (*visited)[r+1][c] == false {
		*route = append(*route, 10*(r+1)+c)
		(*visited)[r+1][c] = true
		(*from)[r+1][c] = "up"
		count++
	}
	if c+1 <= len(s[0])-1 && string(s[r][c+1]) != "B" && (*visited)[r][c+1] == false {
		*route = append(*route, 10*r+c+1)
		(*visited)[r][c+1] = true
		(*from)[r][c+1] = "left"
		count++
	}
	if c-1 >= 0 && string(s[r][c-1]) != "B" && (*visited)[r][c-1] == false {
		*route = append(*route, 10*r+c-1)
		(*visited)[r][c-1] = true
		(*from)[r][c-1] = "right"
		count++
	}
	if count > 1 {
		(*decisionpoint)[r][c] = true
	}
}

//RefactorableNumber return whether a is a RefactorableNumber or not
func RefactorableNumber(a int) bool {
	count := 0
	for i := 1; i <= int(math.Ceil(math.Pow(float64(a), 0.5))); i++ {
		if a%i == 0 && a != i*i {
			count += 2
		} else if a == i*i {
			count++
		}
	}
	fmt.Println(count)
	if a%count == 0 {
		return true
	}
	return false
}

//MaximumSumofHourGlassinMatrix return as title
func MaximumSumofHourGlassinMatrix(a [][]int) int {
	sum := []int{}
	for i := 0; i < len(a)-2; i++ {
		for j := 0; j < len(a)-2; j++ {
			s := a[i][j] + a[i][j+1] + a[i][j+2] + a[i+1][j+1] + a[i+2][j] + a[i+2][j+1] + a[i+2][j+2]
			sum = append(sum, s)
		}
	}
	return util.Max(sum)
}

//XORallElementexceptitself return the array with xor value of all elements except itself
func XORallElementexceptitself(a []int) []int {
	str := []string{}
	result := []int{}
	for i := 0; i < len(a); i++ {
		str = append(str, strconv.FormatInt(int64(a[i]), 2))
	}
	var sumstr []string
	var tmp string
	for i := 0; i < len(a); i++ {
		sum := 0
		for j := 0; j < len(a); j++ {
			if i == j {
				continue
			}
			b, _ := strconv.Atoi(str[j])
			sum += b
		}
		tmp = strconv.Itoa(sum)
		sumstr = append(sumstr, xorstring(tmp))
	}
	for i := 0; i < len(a); i++ {
		c, _ := strconv.ParseInt(sumstr[i], 2, 0)
		result = append(result, int(c))
	}
	return result
}

func xorstring(s string) string {
	result := ""
	for i := 0; i < len(s); i++ {
		b, _ := strconv.Atoi(string(s[len(s)-i-1]))
		if b%2 == 0 {
			result = "0" + result
		} else {
			result = "1" + result
		}
	}
	return result
}

//KDifferencePermutaiton return the array that abs(resulti-pi)=k
func KDifferencePermutaiton(n int, k int) []int {
	if (n % (2 * k)) != 0 {
		return nil
	}
	result := []int{}
	for i := 0; i < n; i++ {
		if (i/k)%2 == 0 {
			result = append(result, i+1+k)
		} else {
			result = append(result, i+1-k)
		}
	}
	return result
}

//SingleAppearCharinString return the char that appear once in the string s
func SingleAppearCharinString(s string) string {
	for i := range s {
		if strings.Count(s, string(s[i])) == 1 {
			return string(s[i])
		}
	}
	return "no such string"
}

//MaximumAdjacentDifference return the maximum adjacent difference after modification
func MaximumAdjacentDifference(a []int) int {
	size := len(a)
	var new string
	sum := []int{}
	maximumadjacentdifferenceHelper(a, &sum, 0, size, &new)
	return util.Max(sum)
}

func maximumadjacentdifferenceHelper(a []int, sum *[]int, index int, size int, new *string) {
	if index == size {
		*sum = append(*sum, util.SumofAdajcentDifference(*new))
		return
	}
	for i := 0; i < size; i++ {
		if !strings.Contains((*new)[0:index], strconv.Itoa(a[i])) {
			*new = (*new)[0:index] + strconv.Itoa(a[i])
			maximumadjacentdifferenceHelper(a, sum, index+1, size, new)
		}
	}
}

//ExpressedAsSumofNthPowerofUniqueNaturalNumber return as title
func ExpressedAsSumofNthPowerofUniqueNaturalNumber(x int, n int) int {
	bond := int(math.Ceil(math.Pow(float64(x), 1/float64(n))))
	combination := []int{}
	count := 0
	bits := 0
	sum := []int{}
	expressHelper(&bits, &count, x, n, &sum, 1, bond, &combination)
	return count
}

func expressHelper(bits *int, count *int, x int, n int, sum *[]int, index int, bond int, combination *[]int) {
	if index > bond {
		*bits -= 2
	}
	for i := index; i <= bond; i++ {
		*combination = append((*combination)[0:*bits], i)
		*sum = append((*sum)[0:*bits], int(math.Pow(float64(i), float64(n))))
		*bits++
		if util.Sum(*sum) > x {
			*bits -= 2
			return
		}
		if util.Sum(*sum) == x {
			fmt.Println(*combination)
			*count++
			*bits -= 2
			return
		}
		expressHelper(bits, count, x, n, sum, i+1, bond, combination)
	}
}

//Dividedby11 return whether a large int can be divided by 11 or not
func Dividedby11(str string) bool {
	sumodd := 0
	sumeven := 0
	for i := 0; i < len(str); i++ {
		d, _ := strconv.Atoi(string(str[len(str)-i-1]))
		if i%2 == 0 {
			sumodd += d
		} else {
			sumeven += d
		}
	}
	if (sumeven-sumodd)%11 == 0 {
		return true
	}
	return false
}

//Hamiltonian return whether there is a Hamiltonian path in M and return the path
func Hamiltonian(M [][]int) (bool, string) {
	stack := "1"
	size := len(M[0])
	visited := make([]bool, size)
	visited[0] = true
	hamiltonianHelper(M, &stack, size, &visited, 0)
	if len(stack) == size+1 {
		return true, stack
	}
	return false, "no such path"
}

func hamiltonianHelper(M [][]int, stack *string, size int, visited *[]bool, node int) {
	if len(*stack) == size {
		if M[node][0] != 1 {
			(*visited)[node] = false
			*stack = (*stack)[0 : size-1]
		} else {
			*stack += "1"
		}
		return
	}
	for i := 0; i < size; i++ {
		if M[node][i] == 1 && (*visited)[i] == false {
			*stack += strconv.Itoa(i + 1)
			(*visited)[i] = true
			hamiltonianHelper(M, stack, size, visited, i)
			if len(*stack) == size+1 {
				return
			}
		}
		if i == size-1 {
			*stack = (*stack)[0 : len(*stack)-1]
			(*visited)[node] = false
		}
	}
}

//UnderIntK return the number of bits in a sorted array that abs(a[i])<=k
func UnderIntK(a []int, k int) int {
	left := binarySearch(a, -k, 0, len(a)-1)
	right := binarySearch(a, k, 0, len(a)-1)
	return right - left + 1
}

func binarySearch(a []int, k int, low int, high int) int {
	mid := low + (high-low)/2
	if a[mid] == k {
		return mid
	}
	if low == high && k > a[low] {
		if k > 0 {
			return low
		}
		return low + 1
	}
	if low == high && k < a[low] {
		if k > 0 {
			return low - 1
		}
		return low
	}
	if a[mid] > k {
		return binarySearch(a, k, low, mid-1)
	}
	return binarySearch(a, k, mid+1, high)
}

//SumofTwoLargeNumber return sum of two large int as string
func SumofTwoLargeNumber(a string, b string) string {
	var size int
	carry := 0
	var str string
	var strapd string
	if len(a) > len(b) {
		size = len(b)
		strapd = a[0 : len(a)-size]
	} else {
		size = len(a)
		strapd = b[0 : len(b)-size]
	}
	for i := 0; i < size; i++ {
		va, _ := strconv.Atoi(string(a[len(a)-1-i]))
		vb, _ := strconv.Atoi(string(b[len(b)-1-i]))
		str = str + strconv.Itoa((va+vb+carry)%10)
		if va+vb+carry > 10 {
			carry = 1
		} else {
			carry = 0
		}
	}
	index := -1
	for carry == 1 {
		index++
		v, _ := strconv.Atoi(string(strapd[len(strapd)-index-1]))
		if len(strapd)-index-1 == 0 {
			if strapd[0] == '9' {
				strapd = "10" + strapd[1:len(strapd)]
				break
			}
		}
		if v+carry >= 10 {
			mb := []byte(strapd)
			mb[len(strapd)-index-1] = []byte(strconv.Itoa((v + carry) % 10))[0]
			strapd = string(mb)
			carry = 1
		} else {
			carry = 0
		}
	}
	return strapd + util.Reversed(str)
}

//Minimum1s2s return minimum number of 1s and 2s to get n that is multiple of k
func Minimum1s2s(n int, k int) int {
	if n < k {
		return -1
	}
	return (n/2 + n%2) + k - (n/2+n%2)%k
}

//BruteForceAssignmentProblem return the minimum cost of assignment problem
func BruteForceAssignmentProblem(A [][]int) (int, string) {
	var constructor string
	var allocation []string
	var overallcost []int
	var cost []int
	assignmentHelper(0, len(A[0]), constructor, cost, A, &overallcost, &allocation)
	return util.Min(overallcost), allocation[util.MinIndex(overallcost)]
}

func assignmentHelper(index int, length int, constructor string, cost []int, A [][]int, overallcost *[]int, allocation *[]string) {
	for i := 0; i < length; i++ {
		if strings.Contains(constructor[0:index], strconv.Itoa(i)) {
			continue
		}
		constructor = constructor[0:index] + strconv.Itoa(i)
		cost = append(cost[0:index], A[index][i])
		if index == length-1 {
			sum := 0
			for _, v := range cost {
				sum = sum + v
			}
			*overallcost = append(*overallcost, sum)
			*allocation = append(*allocation, constructor)
		}
		if index < length {
			assignmentHelper(index+1, length, constructor, cost, A, overallcost, allocation)
		}
	}
}

//BitStuffing return the string after destuffing
func BitStuffing(a string) []string {
	b := strings.Split(a, "0111111001111110")
	for i := range b {
		b[i] = strings.TrimPrefix(strings.TrimSuffix(b[i], "01111110"), "01111110")
		b[i] = strings.Replace(b[i], "111110", "11111", -1)
	}
	return b
}

//FirstRepeatedIndex return the first repeated index in a string
func FirstRepeatedIndex(a string) int {
	var table [127]int
	for i, c := range a {
		if table[c] == 1 {
			return i
		}
		table[c] = 1
	}
	return -1
}

//SubPassword return the longest substring of a string that with no 0 and at least 1 uppercase
func SubPassword(s string) int {
	splitstring := strings.Split(s, "0")
	var best = 0
	for _, sub := range splitstring {
		o, err := regexp.MatchString("[A-Z]", sub)
		if err != nil {
			fmt.Println(err)
		}
		if o == true {
			if best < len(sub) {
				best = len(sub)
			}
		}
	}
	return best
}

//Intersection return the intersection array of two ordered int array
func Intersection(a []int, b []int) []int {
	var c []int
	i, j := 0, 0
	for true {
		if a[i] < b[j] {
			i++
			if i > len(a)-1 {
				break
			}
		} else if a[i] > b[j] {
			j++
			if j > len(b)-1 {
				break
			}
		} else {
			c = append(c, a[i])
			i++
			if i > len(a)-1 {
				break
			}
		}
	}
	return c
}

//Sum return the sum of 1 to a recursively
func Sum(a int) int {
	if a == 1 {
		return 1
	}
	return a + Sum(a-1)
}

//DigitNum return the digit number of a recursively
func DigitNum(a int) int {
	if a/10 == 0 {
		return 1
	}
	return 1 + DigitNum(a/10)
}

//Largest return the largets element in a recursively
func Largest(a []int) int {
	if len(a) == 1 {
		return a[0]
	}
	if Largest(a[:len(a)-1]) > a[len(a)-1] {
		return Largest(a[:len(a)-1])
	}
	return a[len(a)-1]
}
