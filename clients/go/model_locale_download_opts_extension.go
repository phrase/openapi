package phrase

import (
	"fmt"

	"github.com/antihax/optional"
)

func (params *LocaleDownloadOpts) ApplyValuesFromMap(defaults map[string]interface{}) error {
	for k, v := range defaults {
		switch k {
		case "branch":
			val, ok := v.(string)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.Branch = optional.NewString(val)

		case "convert_emoji":
			val, ok := v.(bool)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.ConvertEmoji = optional.NewBool(val)

		case "encoding":
			val, ok := v.(string)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.Encoding = optional.NewString(val)

		case "fallback_locale_id":
			val, ok := v.(string)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.FallbackLocaleId = optional.NewString(val)

		case "file_format":
			val, ok := v.(string)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.FileFormat = optional.NewString(val)

		// case "format_options":
		// 	rval, err := ValidateIsRawMap(k, v)
		// 	if err != nil {
		// 		return err
		// 	}
		// 	params.FormatOptions = optional.Interface(rval)

		case "include_empty_translations":
			val, ok := v.(bool)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.IncludeEmptyTranslations = optional.NewBool(val)

		case "include_translated_keys":
			val, ok := v.(bool)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.IncludeTranslatedKeys = optional.NewBool(val)

		case "include_unverified_translations":
			val, ok := v.(bool)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.IncludeUnverifiedTranslations = optional.NewBool(val)

		case "keep_notranslate_tags":
			val, ok := v.(bool)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.KeepNotranslateTags = optional.NewBool(val)

		case "skip_unverified_translations":
			val, ok := v.(bool)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.SkipUnverifiedTranslations = optional.NewBool(val)

		case "tag":
			val, ok := v.(string)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.Tag = optional.NewString(val)

		case "tags":
			val, ok := v.(string)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.Tags = optional.NewString(val)

		case "use_last_reviewed_version":
			val, ok := v.(bool)
			if !ok {
				return fmt.Errorf(cfgValueErrStr, k, v)
			}
			params.UseLastReviewedVersion = optional.NewBool(val)

		default:
			return fmt.Errorf(cfgInvalidKeyErrStr, k)
		}
	}

	return nil
}
