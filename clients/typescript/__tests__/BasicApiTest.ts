import { LocalesApi } from '../src/apis/LocalesApi';
import { UploadsApi } from '../src/apis/UploadsApi';
import { Configuration } from '../src/runtime';
const FormData = require("form-data")
const fs = require("fs");

global.FormData = FormData;

const getMockFetch = (jsonResponse, textResponse, headers) => jest.fn(() => Promise.resolve({
  json: () => Promise.resolve(jsonResponse),
  text: () => Promise.resolve(textResponse),
  blob: () => Promise.resolve(textResponse),
  status: 200,
  ok: true,
  headers: {
    get: (name: string) => headers[name.toLowerCase()]
  }
})) as jest.Mock;

describe('LocalesApi', () => {
  let mockFetch;
  let configuration;
  let api;

  describe('localesCreate', () => {
    beforeEach(() => {
      mockFetch = getMockFetch({}, 'foo', {});
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
      mockFetch = getMockFetch([{id: 'locale_id_1'}], 'foo', {});
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

      await api.localesList({projectId}).then((data) => {
        expect(data[0].id).toBe('locale_id_1');
      });

      expect(mockFetch.mock.calls.length).toBe(1);
      expect(mockFetch.mock.calls[0][0]).toBe(`https://api.phrase.com/v2/projects/${projectId}/locales`);
    });
  });

  describe('localesListRaw', () => {
    beforeEach(() => {
      mockFetch = getMockFetch([{id: 'locale_id_1'}], 'foo', {
        pagination: '{"total_count":59,"total_pages_count":3,"current_page":1,"current_per_page":25,"previous_page":null,"next_page":2}',
        link: '<https://api.phrase.com/v2/projects/my-project-id/locales?page=1>; rel=first, <https://api.phrase.com/v2/projects/my-project-id/locales?page=3>; rel=last, <https://api.phrase.com/v2/projects/my-project-id/locales?page=2>; rel=next'
      });
      configuration = new Configuration(
        {
          apiKey: `token PHRASE_TOKEN`,
          fetchApi: mockFetch
        }
      );
      api = new LocalesApi(configuration);
    });

    test('lists locales and checks pagination', async () => {
      const projectId = 'my-project-id';

      await api.localesListRaw({projectId}).then((response) => {
        expect(response.isPaginated).toBe(true);
        expect(response.hasNextPage).toBe(true);
        expect(response.nextPageUrl).toBe('https://api.phrase.com/v2/projects/my-project-id/locales?page=2');
        expect(response.totalCount).toBe(59);
        expect(response.totalPages).toBe(3);
        expect(response.nextPage).toBe(2);
        response.value().then((data) => {
          expect(data[0].id).toBe('locale_id_1');
        });
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
      mockFetch = getMockFetch({id: "upload_id"}, 'foo', {});
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
      const fileFormat = 'json';
      const localeId = 'en';

      await api.uploadCreate({projectId, file, fileFormat, localeId}).then((response) => {
        expect(response.id).toBe('upload_id');
      });

      expect(mockFetch.mock.calls.length).toBe(1);
      expect(mockFetch.mock.calls[0][0]).toBe(`https://api.phrase.com/v2/projects/${projectId}/uploads`);
    });
  });
});
