package main

import (
	"net/http"
	"os"
	"runner"

	"golang.org/x/net/websocket"
)

func main() {
	http.Handle("/echo", websocket.Handler(runner.Echo))
	http.Handle("/", http.FileServer(http.Dir("./web")))
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic("ListenAndServe: " + err.Error())
	}
	defer func() {
		if _, err := os.Stat("./a.out"); err == nil {
			os.Remove("./a.out")
		}
		if _, err := os.Stat("./tmp"); err == nil {
			os.RemoveAll("./tmp")
		}
	}()
}
