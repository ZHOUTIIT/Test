package runner

import (
	"os"
	"os/exec"
	"strings"
)

//RunCode run code
func RunCode(s string) string {
	str := strings.Split(s, "withcode")
	lan := str[0]
	code := str[1]
	createfile(lan, code)
	out := execute(lan, code)
	return out
}
func execute(t string, code string) string {
	var out []byte

	switch t {
	case "go":

		goout, _ := exec.Command("go", "run", "./tmp/main.go").CombinedOutput()
		// check(err)
		out = goout
		break
	case "cpp":

		_, _ = exec.Command("g++", "./tmp/main.cpp").CombinedOutput()
		// check(err)

		cppout, _ := exec.Command("sh", "-c", "./a.out").CombinedOutput()
		// check(err)
		out = cppout
		break
	case "c":

		_, _ = exec.Command("gcc", "./tmp/main.c").CombinedOutput()
		// check(err)

		cout, _ := exec.Command("sh", "-c", "./a.out").CombinedOutput()
		// check(err)
		out = cout
		break
	case "swift":

		goout, _ := exec.Command("swift", "./tmp/main.swift").CombinedOutput()
		// check(err)
		out = goout
		break
	default:
		break
	}
	return string(out)
}
func check(e error) {
	if e != nil {
		panic(e)
	}
}
func createfile(t string, code string) {
	os.MkdirAll("./tmp", 0777)
	path := "./tmp/main." + t
	f, err := os.Create(path)
	check(err)
	f.WriteString(code)
}
