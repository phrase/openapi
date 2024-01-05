package internal

import (
	"encoding/json"
	"errors"
	"fmt"
	"sort"
	"strings"

	"github.com/antihax/optional"
	"github.com/phrase/phrase-cli/cmd/internal/print"
	prompt "github.com/phrase/phrase-cli/cmd/internal/prompt"
	"github.com/phrase/phrase-cli/cmd/internal/shared"
	"github.com/phrase/phrase-go/v2"
	"golang.org/x/exp/maps"
)

type UploadCleanupCommand struct {
	phrase.Config
	IDs       []string
	ProjectID string
	Confirm   bool
	Branch    string
}

func (cmd *UploadCleanupCommand) Run() error {
	Config = &cmd.Config
	client := newClient()

	return UploadCleanup(client, cmd)
}

func UploadCleanup(client *phrase.APIClient, cmd *UploadCleanupCommand) error {
	commonUnmentionedKeys := map[string]phrase.TranslationKey{}
	alreadyInitialized := false
	for _, id := range cmd.IDs {
		q := "unmentioned_in_upload:" + id
		keysListLocalVarOptionals := phrase.KeysListOpts{
			Page:    optional.NewInt32(1),
			PerPage: optional.NewInt32(100),
			Q:       optional.NewString(q),
			Branch:  optional.NewString(cmd.Branch),
		}
		allUnmentionedKeysInUpload := map[string]phrase.TranslationKey{}
		keys, _, err := client.KeysApi.KeysList(Auth, cmd.ProjectID, &keysListLocalVarOptionals)
		if err != nil {
			return err
		}
		for len(keys) != 0 {
			for _, key := range keys {
				allUnmentionedKeysInUpload[key.Id] = key
			}

			keysListLocalVarOptionals.Page = optional.NewInt32(keysListLocalVarOptionals.Page.Value() + 1)

			keys, _, err = client.KeysApi.KeysList(Auth, cmd.ProjectID, &keysListLocalVarOptionals)
			if err != nil {
				return err
			}
		}

		if alreadyInitialized {
			newUnmentioned := map[string]phrase.TranslationKey{}
			for id, key := range allUnmentionedKeysInUpload {
				if _, ok := commonUnmentionedKeys[id]; ok {
					newUnmentioned[id] = key
				}
			}
			commonUnmentionedKeys = newUnmentioned
		} else {
			commonUnmentionedKeys = allUnmentionedKeysInUpload
			alreadyInitialized = true
		}
	}

	if len(commonUnmentionedKeys) == 0 {
		print.Success("There were no keys unmentioned in that upload.")
		return nil
	}

	keys := maps.Values(commonUnmentionedKeys)
	return deleteUnmentioned(client, cmd, keys)
}

func deleteUnmentioned(client *phrase.APIClient, cmd *UploadCleanupCommand, keys []phrase.TranslationKey) error {
	ids := make([]string, len(keys))
	names := make([]string, len(keys))
	for i, key := range keys {
		ids[i] = key.Id
		names[i] = key.Name
	}

	if !cmd.Confirm {
		if shared.BatchMode {
			return errors.New("Can't ask for confirmation in batch mode. Aborting")
		}
		fmt.Println("You are about to delete the following key(s) from your project:")
		sort.Strings(names)
		fmt.Println(strings.Join(names, "\n"))

		confirmation := ""
		err := prompt.WithDefault("Are you sure you want to continue? (y/n)", &confirmation, "n")
		if err != nil {
			return err
		}

		if strings.ToLower(confirmation) != "y" {
			fmt.Println("Clean up aborted")
			return nil
		}
	}

	const ChunkSize = 100
	totalAffected := int32(0)

	for i := 0; i < len(ids); i += ChunkSize {
		end := i + ChunkSize

		if end > len(ids) {
			end = len(ids)
		}

		q := "ids:" + strings.Join(ids[i:end], ",")
		keysDeletelocalVarOptionals := phrase.KeysDeleteCollectionOpts{
			Q:      optional.NewString(q),
			Branch: optional.NewString(cmd.Branch),
		}
		affected, _, err := client.KeysApi.KeysDeleteCollection(Auth, cmd.ProjectID, &keysDeletelocalVarOptionals)

		if err != nil {
			return err
		}
		totalAffected += affected.RecordsAffected
		if shared.BatchMode {
			jsonBuf, jsonErr := json.MarshalIndent(affected, "", " ")
			if jsonErr != nil {
				print.Error(jsonErr)
			}
			fmt.Printf("%s\n", string(jsonBuf))
		}
	}

	if !shared.BatchMode {
		print.Success("%d key(s) successfully deleted.\n", totalAffected)
	}
	return nil
}
