package util

import "math"

//InsertionSort sort the int array
func InsertionSort(a *[]int) {
	for i := 1; i < len(*a); i++ {
		v := (*a)[i]
		j := i - 1
		for j >= 0 && v < (*a)[j] {
			(*a)[j+1] = (*a)[j]
			j--
		}
		(*a)[j+1] = v
	}
}

//Sum return the sum of a int array
func Sum(a []int) int {
	sum := 0
	for _, b := range a {
		sum += b
	}
	return sum
}

//Max return the maximum in an array
func Max(a []int) int {
	v := math.MinInt64
	for _, b := range a {
		if v < b {
			v = b
		}
	}
	return v
}

//Min return the minimum in an array
func Min(a []int) int {
	v := math.MaxInt64
	for _, b := range a {
		if v > b {
			v = b
		}
	}
	return v
}

//MaxIndex return the maximum index in an array
func MaxIndex(a []int) int {
	v := math.MinInt64
	index := 0
	for i, b := range a {
		if v < b {
			v = b
			index = i
		}
	}
	return index
}

//MinIndex return the minimum in an array
func MinIndex(a []int) int {
	v := math.MaxInt64
	index := 0
	for i, b := range a {
		if v > b {
			v = b
			index = i
		}
	}
	return index
}
