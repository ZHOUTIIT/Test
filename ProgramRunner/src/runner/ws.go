package runner

import (
	"fmt"

	"golang.org/x/net/websocket"
)

//Echo echo
func Echo(ws *websocket.Conn) {
	var err error
	for {
		var reply string
		if err = websocket.Message.Receive(ws, &reply); err != nil {
			fmt.Println("Can't receive")
			break
		}
		text := RunCode(reply)
		if err = websocket.Message.Send(ws, text); err != nil {
			fmt.Println("Can't send")
			break
		}
	}
}
