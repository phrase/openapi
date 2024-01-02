package phrase

import (
	"context"
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/phrase/phrase-go/v2"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func Test_phrase_CustomMetadataApiService(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Test request parameters
		b, err := ioutil.ReadAll(r.Body)
		if err != nil {
			panic(err)
		}
		assert.Equal(t, "{\"name\":\"my_property\",\"data_type\":\"string\",\"project_ids\":[\"project_id\",\"project_id2\"],\"description\":\"my description\"}\n", string(b))

		// Send the mock response
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)

		response := `{"id": "1", "data_type": "string", "name": "my_property" }`
		w.Write([]byte(response))
	}))

	defer server.Close()

	configuration := phrase.NewConfiguration()
	configuration.BasePath = server.URL
	apiClient := phrase.NewAPIClient(configuration)

	t.Run("Test CustomMetadataService CustomMetadataCreate", func(t *testing.T) {
		customMetadataPropertiesCreateParameters := phrase.CustomMetadataPropertiesCreateParameters{
			Name:        "my_property",
			DataType:    phrase.STRING,
			Description: "my description",
			ProjectIds:  []string{"project_id", "project_id2"},
		}
		localVarOptionals := phrase.CustomMetadataPropertyCreateOpts{}
		resp, httpRes, err := apiClient.CustomMetadataApi.CustomMetadataPropertyCreate(context.Background(), "account_id", customMetadataPropertiesCreateParameters, &localVarOptionals)
		requestUrl := httpRes.Request.URL

		require.Nil(t, err)
		require.NotNil(t, resp)
		assert.Equal(t, 200, httpRes.StatusCode)
		assert.Equal(t, "1", resp.Id)
		assert.Equal(t, "my_property", resp.Name)
		assert.Equal(t, phrase.STRING, resp.DataType)
		assert.Equal(t, "/accounts/account_id/custom_metadata/properties", requestUrl.Path)
		assert.Equal(t, "", requestUrl.RawQuery)
		assert.Equal(t, "POST", httpRes.Request.Method)
	})

}
