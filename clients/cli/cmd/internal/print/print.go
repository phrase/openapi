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
	WithColor(ct.Green, formatSuccessMessage(msg, args...))
}

func Failure(msg string, args ...interface{}) {
	WithColor(ct.Red, formatFailureMessage(msg, args...))
}

func WithColor(color ct.Color, msg string) {
	fprintWithColor(os.Stdout, color, msg)
}

func Error(err error) {
	fprintWithColor(os.Stderr, ct.Red, formatErrorMessage("ERROR: %s", err))
}

func fprintWithColor(w io.Writer, color ct.Color, msg string) {
	ct.Foreground(color, true)
	fmt.Fprintf(w, msg)
	fmt.Fprintln(w)
	ct.ResetColor()
}

func formatSuccessMessage(msg string, args ...interface{}) {
	formatMessage("message", msg, args...)
}

func formatFailureMessage(msg string, args ...interface{}) {
	formatMessage("failure", msg, args...)
}

func formatErrorMessage(msg string, args ...interface{}) {
	formatMessage("error", msg, args...)
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
