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
	WithColor(ct.Green, msgformatter.Success(msg, args...))
}

func Failure(msg string, args ...interface{}) {
	WithColor(ct.Red, msgformatter.Failure(msg, args...))
}

func WithColor(color ct.Color, msg string) {
	fprintWithColor(os.Stdout, color, msg)
}

func Error(err error) {
	fprintWithColor(os.Stderr, ct.Red, msgformatter.Error("ERROR: %s", err))
}

func fprintWithColor(w io.Writer, color ct.Color, msg string) {
	ct.Foreground(color, true)
	fmt.Fprintf(w, msg)
	fmt.Fprintln(w)
	ct.ResetColor()
}
