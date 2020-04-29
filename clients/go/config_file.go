package phrase

import (
	"errors"

	"github.com/mitchellh/go-homedir"
	"github.com/spf13/viper"
)

type Config struct {
	AccessToken string `mapstructure:"access_token"`
}

func ConfigFile(cfgFile string) (*Config, error) {
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
				return nil, errors.New("Invalid config file structure.")
			}
		}
	}

	var config Config

	if viper.IsSet("phrase") {
		if err := viper.UnmarshalKey("phrase", &config); err != nil {
			return nil, errors.New("Invalid config file structure.")
		}
	} else {
		if viper.IsSet("phraseapp") {
			if err := viper.UnmarshalKey("phraseapp", &config); err != nil {
				return nil, errors.New("Invalid config file structure.")
			}
		} else {
			return nil, errors.New("Invalid config file structure.")
		}
	}

	return &config, nil
}
