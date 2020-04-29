package phrase

import (
	"errors"

	"github.com/mitchellh/go-homedir"
	"github.com/spf13/viper"
)

func ConfigFile(cfgFile string) (*viper.Viper, error) {
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
		viper.AutomaticEnv()

		if err := viper.ReadInConfig(); err != nil {
			return nil, err
		}
	} else {
		// Find home directory.
		home, err := homedir.Dir()
		if err != nil {
			return nil, err
		}

		viper.AddConfigPath(".")
		viper.AddConfigPath(home)
		viper.SetConfigName(".phrase")
		viper.AutomaticEnv()

		if err := viper.ReadInConfig(); err != nil {
			viper.SetConfigName(".phraseapp")
			if err := viper.MergeInConfig(); err != nil {
				return nil, errors.New("Invalid config file structure. 2")
			}
		}
	}

	config := viper.Sub("phrase")
	if config == nil {
		config = viper.Sub("phraseapp")
		if config == nil {
			return nil, errors.New("Invalid config file structure. 3")
		}
	}

	return config, nil
}
