package phrase

import (
	"os"
)

func defaultConfigDir() string {
	return os.Getenv("HOME")
}
