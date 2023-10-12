import { LocalesApi } from '../src/apis/LocalesApi';
import { UploadsApi } from '../src/apis/UploadsApi';
import { Configuration } from '../src/runtime';
const FormData = require("form-data")
const fs = require("fs");

global.FormData = FormData;

const getMockFetch = (jsonResponse, textResponse) => jest.fn(() => Promise.resolve({
  json: () => Promise.resolve(jsonResponse),
  text: () => Promise.resolve(textResponse),
  blob: () => Promise.resolve(textResponse),
  status: 200,
  ok: true
})) as jest.Mock;

describe('LocalesApi', () => {
  let mockFetch;
  let configuration;
  let api;

  describe('localesCreate', () => {
    beforeEach(() => {
      mockFetch = getMockFetch({}, 'foo');
      configuration = new Configuration(
        {
          apiKey: `token PHRASE_TOKEN`,
          fetchApi: mockFetch
        }
      );
      api = new LocalesApi(configuration);
    });

    test('downloads a locale', async () => {
      const projectId = 'my-project-id';
      const id = 'my-locale-id';

      await api.localeDownload({id, projectId}).then((response) => {
        expect(response).toBe('foo');
      });

      expect(mockFetch.mock.calls.length).toBe(1);
      expect(mockFetch.mock.calls[0][0]).toBe(`https://api.phrase.com/v2/projects/${projectId}/locales/${id}/download`);
    });
  });

  describe('localesList', () => {
    beforeEach(() => {
      mockFetch = getMockFetch([{id: 'locale_id_1'}], 'foo');
      configuration = new Configuration(
        {
          apiKey: `token PHRASE_TOKEN`,
          fetchApi: mockFetch
        }
      );
      api = new LocalesApi(configuration);
    });

    test('lists locales', async () => {
      const projectId = 'my-project-id';

      await api.localesList({projectId}).then((response) => {
        expect(response[0].id).toBe('locale_id_1');
      });

      expect(mockFetch.mock.calls.length).toBe(1);
      expect(mockFetch.mock.calls[0][0]).toBe(`https://api.phrase.com/v2/projects/${projectId}/locales`);
    });
  });
});

describe('UploadsApi', () => {
  let mockFetch;
  let configuration;
  let api;

  describe('uploadCreate', () => {
    beforeEach(() => {
      mockFetch = getMockFetch({id: "upload_id"}, 'foo');
      configuration = new Configuration(
        {
          apiKey: `token PHRASE_TOKEN`,
          fetchApi: mockFetch
        }
      );
      api = new UploadsApi(configuration);
    });

    test('uploads a file', async () => {
      const projectId = 'my-project-id';
      const file = fs.createReadStream('package.json');

      await api.uploadCreate({projectId, file}).then((response) => {
        expect(response.id).toBe('upload_id');
      });

      expect(mockFetch.mock.calls.length).toBe(1);
      expect(mockFetch.mock.calls[0][0]).toBe(`https://api.phrase.com/v2/projects/${projectId}/uploads`);
    });
  });
});
