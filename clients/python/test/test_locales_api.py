# coding: utf-8

"""
    Phrase Strings API Reference

    The version of the OpenAPI document: 2.0.0
    Contact: support@phrase.com
    Generated by: https://openapi-generator.tech
"""


from __future__ import absolute_import

import unittest
from unittest.mock import Mock, patch


import phrase_api
from phrase_api.api.locales_api import LocalesApi  # noqa: E501
from phrase_api.rest import ApiException


class TestLocalesApi(unittest.TestCase):
    """LocalesApi unit test stubs"""

    def setUp(self):
        self.configuration = phrase_api.Configuration()
        self.configuration.api_key['Authorization'] = 'YOUR_API_KEY'
        self.configuration.api_key_prefix['Authorization'] = 'token'

    def tearDown(self):
        pass

    def test_account_locales(self):
        """Test case for account_locales

        List locales used in account  # noqa: E501
        """
        pass



    def test_locale_create(self):
        """Test case for locale_create

        Create a locale  # noqa: E501
        """
        pass

    def test_locale_delete(self):
        """Test case for locale_delete

        Delete a locale  # noqa: E501
        """
        pass

    @patch('urllib3.PoolManager.urlopen')
    def test_locale_download(self, mock_get):
        """Test case for locale_download

        Download a locale  # noqa: E501
        """

        body = bytes('{"key":"value"}', 'utf-8')
        mock_get.return_value = Mock(ok=True)
        mock_get.return_value.data = body
        mock_get.return_value.status = 200
        mock_get.return_value.getencoding.return_value = 'utf-8'
        mock_get.return_value.getheader.side_effect = { 'Content-Disposition': None }.get

        with phrase_api.ApiClient(self.configuration) as api_client:
            api_instance = phrase_api.api.locales_api.LocalesApi(api_client)
            api_response = api_instance.locale_download("project_id_example", "en", file_format="simple_json", format_options={"enable_pluralization": True, "custom_metadata_columns": { "E": "text" }})

            self.assertEqual("https://api.phrase.com/v2/projects/project_id_example/locales/en/download?file_format=simple_json&format_options%5Benable_pluralization%5D=True&format_options%5Bcustom_metadata_columns%5D%5BE%5D=text", mock_get.call_args_list[0].args[1])

            self.assertIsNotNone(api_response)
            file = open(api_response, "r")
            content = file.read()
            file.close()
            self.assertEqual(body.decode(), content)

    def test_locale_show(self):
        """Test case for locale_show

        Get a single locale  # noqa: E501
        """
        pass

    def test_locale_update(self):
        """Test case for locale_update

        Update a locale  # noqa: E501
        """
        pass

    @patch('phrase_api.ApiClient.request')
    def test_locales_list(self, mock_get):
        """Test case for locales_list

        List locales  # noqa: E501
        """
        mock_get.return_value = Mock(ok=True)
        mock_get.return_value.data = '[{"id":"locale_id","name":"locale_name","code":"locale_code","default":true,"main":true,"rtl":true,"plural_forms":["plural_forms"]}]'

        project_id = "project_id_example"
        with phrase_api.ApiClient(self.configuration) as api_client:
            api_instance = phrase_api.api.locales_api.LocalesApi(api_client)
            api_response = api_instance.locales_list(project_id)

            self.assertIsNotNone(api_response)
            self.assertEqual(1, len(api_response))
            self.assertIsInstance(api_response[0], phrase_api.models.locale.Locale)
            self.assertEqual("locale_id", api_response[0].id)
            self.assertEqual("locale_id", api_response[0].id)
            self.assertEqual("locale_name", api_response[0].name)



if __name__ == '__main__':
    unittest.main()