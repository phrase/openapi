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
	WithColor(ct.Cyan, phrase_logo)
}

func Success(msg string, args ...interface{}) {
	WithColor(ct.Green, msg, args...)
}

func Failure(msg string, args ...interface{}) {
	WithColor(ct.Red, msg, args...)
}

func WithColor(color ct.Color, msg string, args ...interface{}) {
	fprintWithColor(os.Stdout, color, msg, args...)
}

func Error(err error) {
	fprintWithColor(os.Stderr, ct.Red, "ERROR: %s", err)
}

func fprintWithColor(w io.Writer, color ct.Color, msg string, args ...interface{}) {
	ct.Foreground(color, true)
	fmt.Fprintln(w, stringifyJsonMessage(msg, args...))
	ct.ResetColor()
}

// delegate printing to supplied print fn
func PrintWithFn(f fn, msg string, args ...interface{}) {
	if Config.Json {
		f(stringifyJsonMessage(msg, args...))
	} else {
		f(msg, args...)
	}
}

func stringifyJsonMessage(msg string, args ...interface{}) {
	msg_string := fmt.Sprintf(msg, args...)
	msg_json, _ := json.Marshal(msg_string)

	return string(msg_json)
}
