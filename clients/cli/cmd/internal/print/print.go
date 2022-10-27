package print

import (
	"fmt"
	"io"
	"os"

	ct "github.com/daviddengcn/go-colortext"
)

const phrase_logo = `
   *****@@@@@@@@@@@@@@@@@@@@.             
   .********@@@@@@@@@@@@@@@@@@@@           
   .***********             @@@@@          
   .**************          ,@@@@          
   .**************          ,@@@@          
   .**************          ,@@@@          
   .**************          ,@@@@          
   .**************          ,@@@@          
   .**************          ,@@@@          
   .**************          ,@@@@          
   .**************          @@@@@          
   .**************  (@@@@@@@@@@@           
   .**************  (@@@@@@@@@.            
   **************                         
      ***********                         
         ********                         
            ***** 
`

func PhraseLogo() {
	WithColor(ct.Cyan, "message", phrase_logo)
}

func Success(msg string, args ...interface{}) {
	WithColor(ct.Green, "message", msg, args...)
}

func Failure(msg string, args ...interface{}) {
	WithColor(ct.Red, "failure", msg, args...)
}

func WithColor(color ct.Color, mapKey string, msg string, args ...interface{}) {
	fprintWithColor(os.Stdout, color, mapKey, msg, args...)
}

func Error(err error) {
	fprintWithColor(os.Stderr, ct.Red, "error", "ERROR: %s", err)
}

func fprintWithColor(w io.Writer, color ct.Color, mapKey string, msg string, args ...interface{}) {
	ct.Foreground(color, true)
	fmt.Fprintf(w, formatMessage(mapKey, msg, args...))
	fmt.Fprintln(w)
	ct.ResetColor()
}

func formatMessage(mapKey string, msg string, args ...interface{}) {
	formatted_string := fmt.Sprintf(msg, args...)

	if Config.Json {
		msg_map := make(map[string]string)
		msg_map[mapKey] = formatted_string
		formatted_string, _ := string(json.Marshal(msg_map))
	}

	return formatted_string
}
