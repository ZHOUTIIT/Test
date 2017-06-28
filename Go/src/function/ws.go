package function

import (
	"bufio"
	"fmt"
	"os"

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

		fmt.Println("Received back from client: " + reply)

		fmt.Println("what do you want to reply?")
		scanner := bufio.NewScanner(os.Stdin)
		var text string
		scanner.Scan()
		text = scanner.Text()
		if err = websocket.Message.Send(ws, text); err != nil {
			fmt.Println("Can't send")
			break
		}
	}
}
