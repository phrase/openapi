Phrase is a translation management platform for software projects. You can collaborate on language file translation with your team or order translations through our platform. The API allows you to import locale files, download locale files, tag keys or interact in other ways with the localization data stored in Phrase for your account.

## API Endpoint

```
https://api.phrase.com/v2/
```

The API is only accessible via HTTPS, the base URL is <code>https://api.phrase.com/</code>, and the current version is <code>v2</code> which results in the base URL for all requests: <code>https://api.phrase.com/v2/</code>.

## Usage

[curl](http://curl.haxx.se/) is used primarily to send requests to Phrase in the examples. On most you'll find a second variant using the [Phrase API v2 client](https://phrase.com/cli/) that might be more convenient to handle. For further information check its [documentation](https://help.phrase.com/help/phrase-in-your-terminal).

## Use of HTTP Verbs

Phrase API v2 tries to use the appropriate HTTP verb for accessing each endpoint according to REST specification where possible:

<div class="table-responsive">
  <table class="basic-table">
    <thead>
      <tr class="basic-table__row basic-table__row--header">
        <th class="basic-table__cell basic-table__cell--header">Verb</th>
        <th class="basic-table__cell basic-table__cell--header">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="basic-table__cell">GET</td>
        <td class="basic-table__cell">Retrieve one or multiple resources</td>
      </tr>
      <tr>
        <td class="basic-table__cell">POST</td>
        <td class="basic-table__cell">Create a resource</td>
      </tr>
      <tr>
        <td class="basic-table__cell">PUT</td>
        <td class="basic-table__cell">Update a resource</td>
      </tr>
      <tr>
        <td class="basic-table__cell">PATCH</td>
        <td class="basic-table__cell">Update a resource (partially)</td>
      </tr>
      <tr>
        <td class="basic-table__cell">DELETE</td>
        <td class="basic-table__cell">Delete a resource</td>
      </tr>
    </tbody>
  </table>
</div>


## Identification via User-Agent

You must include the User-Agent header with the name of your application or project. It might be a good idea to include some sort of contact information  as well, so that we can get in touch if necessary (e.g. to warn you about Rate-Limiting or badly formed requests). Examples of excellent User-Agent headers:

```
User-Agent: Example Mobile App (example@phrase.com)
User-Agent: ACME Inc Python Client (http://example.com/contact)
```

If you don't send this header, you will receive a response with 400 Bad Request.


## Lists

When you request a list of resources, the API will typically only return an array of resources including their most important attributes. For a detailed representation of the resource you should request its detailed representation.

Lists are usually [paginated](#pagination).


## Parameters

Many endpoints support additional parameters, e.g. for pagination. When passing them in a GET request you can send them as HTTP query string parameters:

```
$ curl -u EMAIL_OR_ACCESS_TOKEN "https://api.phrase.com/v2/projects?page=2"
```

When performing a POST, PUT, PATCH or DELETE request, we recommend sending parameters that are not already included in the URL, as JSON body:

```
$ curl -H 'Content-Type: application/json' -d '{"name":"My new project"}' -u EMAIL_OR_ACCESS_TOKEN https://api.phrase.com/v2/projects
```

Encoding parameters as JSON means better support for types (boolean, integer) and usually better readability. Don't forget to set the correct Content-Type for your request.

*The Content-Type header is omitted in some of the following examples for better readbility.*


## Errors


### Request Errors

If a request contains invalid JSON or is missing a required parameter (besides resource attributes), the status `400 Bad Request` is returned:

```
{
  "message": "JSON could not be parsed"
}
```


### Validation Errors

When the validation for a resource fails, the status `422 Unprocessable Entity` is returned, along with information on the affected fields:

```
{
  "message": "Validation Failed",
  "errors": [
    {
      "resource": "Project",
      "field": "name",
      "message": "can't be blank"
    }
  ]
}
```


## Date Format

Times and dates are returned and expected in [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) date format:

```
YYYY-MM-DDTHH:MM:SSZ
```

Instead of 'Z' for UTC time zone you can specify your time zone's locale offset using the following notation:

```
YYYY-MM-DDTHH:MM:SS¬±hh:mm
```

Example for CET (1 hour behind UTC):

```
2015-03-31T13:00+01:00
```

Please note that in HTTP headers, we will use the appropriate recommended date formats instead of ISO 8601.


## Authentication

<div class="alert alert-info">For more detailed information on authentication, check out the <a href="#authentication">API v2 Authentication Guide</a>.</div>

There are two different ways to authenticate when performing API requests:

* E-Mail and password
* Oauth Access Token


### E-Mail and password

To get started easily, you can use HTTP Basic authentication with your email and password:

```
$ curl -u username:password "https://api.phrase.com/v2/projects"
```


### OAuth via Access Tokens

You can create and manage access tokens in your [profile settings](https://app.phrase.com/settings/oauth_access_tokens) in Translation Center or via the [Authorizations API](#authorizations).

Simply pass the access token as the username of your request:

```
$ curl -u ACCESS_TOKEN: "https://api.phrase.com/v2/projects"
```

or send the access token via the `Authorization` header field:

```
$ curl -H "Authorization: token ACCESS_TOKEN" https://api.phrase.com/v2/projects
```

For more detailed information on authentication, check out the <a href="#authentication">API v2 Authentication Guide</a>.

#### Send via parameter

As JSONP (and other) requests cannot send HTTP Basic Auth credentials, a special query parameter `access_token` can be used:

```
curl "https://api.phrase.com/v2/projects?access_token=ACCESS_TOKEN"
```

You should only use this transport method if sending the authentication via header or Basic authentication is not possible.

### Two-Factor-Authentication

Users with Two-Factor-Authentication enabled have to send a valid token along their request with certain authentication methods (such as Basic authentication). The necessity of a Two-Factor-Authentication token is indicated by the `X-PhraseApp-OTP: required; :MFA-type` header in the response. The `:MFA-type`field indicates the source of the token, e.g. `app` (refers to your Authenticator application):

```
X-PhraseApp-OTP: required; app
```

To provide a Two-Factor-Authentication token you can simply send it in the header of the request:

```
curl -H "X-PhraseApp-OTP: MFA-TOKEN" -u EMAIL https://api.phrase.com/v2/projects
```

Since Two-Factor-Authentication tokens usually expire quickly, we recommend using an alternative authentication method such as OAuth access tokens.

### Multiple Accounts

Some endpoints require the account ID to be specified if the authenticated user is a member of multiple accounts. You can find the eight-digit account ID inside <a href="https://app.phrase.com/" target="_blank">Translation Center</a> by switching to the desired account and then visiting the account details page. If required, you can specify the account just like a normal parameter within the request.

## Pagination

Endpoints that return a list or resources will usually return paginated results and include 25 items by default. To access further pages, use the `page` parameter:

```
$ curl -u EMAIL_OR_ACCESS_TOKEN "https://api.phrase.com/v2/projects?page=2"
```

Some endpoints also allow a custom page size by using the `per_page` parameter:

```
$ curl -u EMAIL_OR_ACCESS_TOKEN "https://api.phrase.com/v2/projects?page=2&per_page=50"
```

Unless specified otherwise in the description of the respective endpoint, `per_page` allows you to specify a page size up to 100 items.


## Link-Headers

We provide you with pagination URLs in the [Link Header field](http://tools.ietf.org/html/rfc5988). Make use of this information to avoid building pagination URLs yourself.

```
Link: <https://api.phrase.com/v2/projects?page=1>; rel="first", <https://api.phrase.com/v2/projects?page=3>; rel="prev", <https://api.phrase.com/v2/projects?page=5>; rel="next", <https://api.phrase.com/v2/projects?page=9>; rel="last"
```

Possible `rel` values are:

<div class="table-responsive">
  <table class="basic-table">
    <thead>
      <tr class="basic-table__row basic-table__row--header">
        <th class="basic-table__cell basic-table__cell--header">Value</th>
        <th class="basic-table__cell basic-table__cell--header">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="basic-table__cell">next</td>
        <td class="basic-table__cell">URL of the next page of results</td>
      </tr>
      <tr>
        <td class="basic-table__cell">last</td>
        <td class="basic-table__cell">URL of the last page of results</td>
      </tr>
      <tr>
        <td class="basic-table__cell">first</td>
        <td class="basic-table__cell">URL of the first page of results</td>
      </tr>
      <tr>
        <td class="basic-table__cell">prev</td>
        <td class="basic-table__cell">URL of the previous page of results</td>
      </tr>
    </tbody>
  </table>
</div>

## Rate Limiting

All API endpoints are subject to rate limiting to ensure good performance for all customers. The rate limit is calculated per user:

* 1000 requests per 5 minutes
* 4 concurrent (parallel) requests

For your convenience we send information on the current rate limit within the response headers:

<div class="table-responsive">
  <table class="basic-table">
    <thead>
      <tr class="basic-table__row basic-table__row--header">
        <th class="basic-table__cell basic-table__cell--header">Header</th>
        <th class="basic-table__cell basic-table__cell--header">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="basic-table__cell" style="white-space: nowrap;"><code>X-Rate-Limit-Limit</code></td>
        <td class="basic-table__cell">Number of max requests allowed in the current time period</td>
      </tr>
      <tr>
        <td class="basic-table__cell" style="white-space: nowrap;"><code>X-Rate-Limit-Remaining</code></td>
        <td class="basic-table__cell">Number of remaining requests in the current time period</td>
      </tr>
      <tr>
        <td class="basic-table__cell" style="white-space: nowrap;"><code>X-Rate-Limit-Reset</code></td>
        <td class="basic-table__cell">Timestamp of end of current time period as UNIX timestamp</td>
      </tr>
    </tbody>
  </table>
</div>

If you should run into the rate limit, you will receive the HTTP status code `429: Too many requests`.

If you should need higher rate limits, [contact us](https://phrase.com/contact).


## Conditional GET requests / HTTP Caching

<div class="alert alert-info"><p><strong>Note:</strong> Conditional GET requests are currently only supported for <a href="#locales_download">locales#download</a> and <a href="#translations_index">translations#index</a></p></div>

We will return an ETag or Last-Modified header with most GET requests. When you request a resource we recommend to store this value and submit them on subsequent requests as `If-Modified-Since` and `If-None-Match` headers. If the resource has not changed in the meantime, we will return the status `304 Not Modified` instead of rendering and returning the resource again. In most cases this is less time-consuming and makes your application/integration faster.

Please note that all conditional requests that return a response with status 304 don't count against your rate limits.

```
$ curl -i -u EMAIL_OR_ACCESS_TOKEN "https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download"
HTTP/1.1 200 OK
ETag: "abcd1234abcdefefabcd1234efab1234"
Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC
Status: 200 OK

$ curl -i -u EMAIL_OR_ACCESS_TOKEN "https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download" -H 'If-None-Match: "abcd1234abcdefefabcd1234efab1234"'
HTTP/1.1 304 Not Modified
ETag: "abcd1234abcdefefabcd1234efab1234"
Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC
Status: 304 Not Modified

$ curl -i -u EMAIL_OR_ACCESS_TOKEN "https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download" -H "If-Modified-Since: Wed, 28 Jan 2015 15:31:30 UTC"
HTTP/1.1 304 Not Modified
Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC
Status: 304 Not Modified
```


## JSONP

The Phrase API supports [JSONP](http://en.wikipedia.org/wiki/JSONP) for all GET requests in order to deal with cross-domain request issues. Just send a `?callback` parameter along with the request to specify the Javascript function name to be called with the response content:

```
$ curl "https://api.phrase.com/v2/projects?callback=myFunction"
```

The response will include the normal output for that endpoint, along with a `meta` section including header data:

```
myFunction({
  {
    "meta": {
      "status": 200,
      ...
    },
    "data": [
      {
        "id": "1234abcd1234abc1234abcd1234abc"
        ...
      }
    ]
  }
});
```

To authenticate a JSONP request, you can send a valid [access token](#authentication) as the `?access_token` parameter along the request:

```
$ curl "https://api.phrase.com/v2/projects?callback=myFunction&access_token=ACCESS-TOKEN"
```

<div class="section resource">

<div id="examples" class="resource__section resource__section--head" data-target="page.section">

<div class="resource__copy">

## Usage examples

Learn how to work more efficiently with Phrase API v2 with these
workflow-oriented examples.

</div>

</div>

<div id="examples_excluded_translations" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Find excluded translations with a certain content

    GET /v2/projects/:project_id/translations

List excluded translations for the given project which start with the
term `PhraseApp`.

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>sort</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Sort criteria. Can be one of: key_name, created_at, updated_at.<br />
Default: key_name</td>
</tr>
<tr class="even">
<td><code>order</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Order direction. Can be one of: asc, desc.<br />
Default: asc</td>
</tr>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to find translations by content (including wildcards).<br />
<br />
The following qualifiers are supported in the query:<br />

<ul>
<li><code>id:translation_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>tags:XYZ</code> for tags on the translation</li>
<li><code>unverified:{true|false}</code> for verification status</li>
<li><code>reviewed:{true|false}</code> for reviewed status</li>
<li><code>excluded:{true|false}</code> for exclusion status</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/translations?sort=updated_at&order=desc&q=PhraseApp*%20excluded:true" \
  -u USERNAME_OR_ACCESS_TOKEN
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase translations list \
--project_id <project_id> \
--sort updated_at \
--order desc \
--query 'PhraseApp* excluded:true' \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp translations list <project_id> \
--sort updated_at \
--order desc \
--query 'PhraseApp* excluded:true'
```

</div>

</div>

</div>

<div id="examples_unverified_translations" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Find unverified translations with a certain content

    GET /v2/projects/:project_id/translations

List unverified translations for the given project which start with the
term `PhraseApp` and are not verified.

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>sort</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Sort criteria. Can be one of: key_name, created_at, updated_at.<br />
Default: key_name</td>
</tr>
<tr class="even">
<td><code>order</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Order direction. Can be one of: asc, desc.<br />
Default: asc</td>
</tr>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to find translations by content (including wildcards).<br />
<br />
The following qualifiers are supported in the query:<br />

<ul>
<li><code>id:translation_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>tags:XYZ</code> for tags on the translation</li>
<li><code>unverified:{true|false}</code> for verification status</li>
<li><code>reviewed:{true|false}</code> for reviewed status</li>
<li><code>excluded:{true|false}</code> for exclusion status</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/translations?sort=updated_at&order=desc&q=PhraseApp*%20unverified:true" \
  -u USERNAME_OR_ACCESS_TOKEN
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase translations list \
--project_id <project_id> \
--sort updated_at \
--order desc \
--query 'PhraseApp* unverified:true' \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp translations list <project_id> \
--sort updated_at \
--order desc \
--query 'PhraseApp* unverified:true'
```

</div>

</div>

</div>

<div id="examples_verify_translations" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Verify translations selected by query

    PATCH /v2/projects/:project_id/translations/verify

Verify all translations that are matching the query `my dog`.

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to find translations by content (including wildcards).<br />
<br />
The following qualifiers are supported in the query:<br />

<ul>
<li><code>id:translation_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>tags:XYZ</code> for tags on the translation</li>
<li><code>unverified:{true|false}</code> for verification status</li>
<li><code>reviewed:{true|false}</code> for reviewed status</li>
<li><code>excluded:{true|false}</code> for exclusion status</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
<tr class="even">
<td><code>sort</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Sort criteria. Can be one of: key_name, created_at, updated_at.<br />
Default: key_name</td>
</tr>
<tr class="odd">
<td><code>order</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Order direction. Can be one of: asc, desc.<br />
Default: asc</td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/translations/verify" \
  -u USERNAME_OR_ACCESS_TOKEN \
  -X PATCH \
  -d '{"q":"my dog unverified:true","sort":"updated_at","order":"desc"}' \
  -H 'Content-Type: application/json'
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase translations verify \
--project_id <project_id> \
--data '{"query":""my dog unverified:true"", "sort":"updated_at", "order":"desc"}' \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp translations verify <project_id> \
--query "my dog unverified:true" \
--sort updated_at \
--order desc
```

</div>

</div>

</div>

<div id="examples_updated_keys" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Find recently updated keys

    GET /v2/projects/:project_id/keys

Find updated keys with with the `updated_at` qualifier like
`updated_at:>=2013-02-21T00:00:00Z`. This example returns keys that have
been updated on or after 2013-02-21.

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>sort</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Sort by field. Can be one of: name, created_at, updated_at.<br />
Default: name</td>
</tr>
<tr class="even">
<td><code>order</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Order direction. Can be one of: asc, desc.<br />
Default: asc</td>
</tr>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to do broad search for keys by name (including wildcards).<br />
<br />
The following qualifiers are also supported in the search term:<br />

<ul>
<li><code>ids:key_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>name:key_name</code> for text queries on exact key names - whitespaces need to be prefixed with a backspace ("\")</li>
<li><code>tags:tag_name</code> to filter for keys with certain tags</li>
<li><code>translated:{true|false}</code> for translation status (also requires <code>locale_id</code> to be specified)</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
<li><code>unmentioned_in_upload:upload_id</code> to filter keys unmentioned within upload</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
<tr class="even">
<td><code>locale_id</code></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/keys?sort=updated_at&order=desc&q=updated_at:%3E=2013-02-21T00:00:00Z&locale_id=abcd1234abcd1234abcd1234abcd1234" \
  -u USERNAME_OR_ACCESS_TOKEN
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase keys list \
--project_id <project_id> \
--sort updated_at \
--order desc \
--query "updated_at:>=2013-02-21T00:00:00Z" \
--locale_id abcd1234abcd1234abcd1234abcd1234 \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp keys list <project_id> \
--sort updated_at \
--order desc \
--query "updated_at:>=2013-02-21T00:00:00Z" \
--locale-id abcd1234abcd1234abcd1234abcd1234
```

</div>

</div>

</div>

<div id="examples_tagged_keys" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Find keys with a certain tag

    GET /v2/projects/:project_id/keys

Keys with certain tags can be filtered with the qualifier `tags:`.

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to do broad search for keys by name (including wildcards).<br />
<br />
The following qualifiers are also supported in the search term:<br />

<ul>
<li><code>ids:key_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>name:key_name</code> for text queries on exact key names - whitespaces need to be prefixed with a backspace ("\")</li>
<li><code>tags:tag_name</code> to filter for keys with certain tags</li>
<li><code>translated:{true|false}</code> for translation status (also requires <code>locale_id</code> to be specified)</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
<li><code>unmentioned_in_upload:upload_id</code> to filter keys unmentioned within upload</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/keys?q=tags:admin" \
  -u USERNAME_OR_ACCESS_TOKEN
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase keys list \
--project_id <project_id> \
--query "tags:admin" \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp keys list <project_id> \
--query "tags:admin"
```

</div>

</div>

</div>

<div id="examples_tag" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Add tags to collection of keys

    PATCH /v2/projects/:project_id/keys/tag

Add the tags `landing-page` and `release-1.2` to all keys that start
with `dog` and are translated in the locale
`abcd1234abcd1234abcd1234abcd1234`.

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to do broad search for keys by name (including wildcards).<br />
<br />
The following qualifiers are also supported in the search term:<br />

<ul>
<li><code>ids:key_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>name:key_name</code> for text queries on exact key names - whitespaces need to be prefixed with a backspace ("\")</li>
<li><code>tags:tag_name</code> to filter for keys with certain tags</li>
<li><code>translated:{true|false}</code> for translation status (also requires <code>locale_id</code> to be specified)</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
<li><code>unmentioned_in_upload:upload_id</code> to filter keys unmentioned within upload</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
<tr class="even">
<td><code>tags</code></td>
<td><code>string</code></td>
<td>Tag or comma-separated list of tags to add to the matching collection of keys</td>
</tr>
<tr class="odd">
<td><code>locale_id</code><br />
<span class="small">optional</span></td>
<td><code>id</code></td>
<td>Locale used to determine the translation state of a key when filtering for untranslated or translated keys.</td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/keys/tag" \
  -u USERNAME_OR_ACCESS_TOKEN \
  -X PATCH \
  -d '{"q":"dog* translated:true","tags":"landing-page,release-1.2","locale_id":"abcd1234abcd1234abcd1234abcd1234"}' \
  -H 'Content-Type: application/json'
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase keys tag \
--project_id <project_id> \
--data '{"query":"'dog* translated:true'", "tags":"landing-page,release-1.2", "locale_id":"abcd1234abcd1234abcd1234abcd1234"}' \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp keys tag <project_id> \
--query 'dog* translated:true' \
--tags landing-page,release-1.2 \
--locale-id abcd1234abcd1234abcd1234abcd1234
```

</div>

</div>

</div>

<div id="examples_untag" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Remove tags from collection of keys

    PATCH /v2/projects/:project_id/keys/untag

Remove the tags `landing-page` and `release-1.2` from all keys that
start with `dog` and are translated in the locale
`abcd1234abcd1234abcd1234abcd1234`.

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to do broad search for keys by name (including wildcards).<br />
<br />
The following qualifiers are also supported in the search term:<br />

<ul>
<li><code>ids:key_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>name:key_name</code> for text queries on exact key names - whitespaces need to be prefixed with a backspace ("\")</li>
<li><code>tags:tag_name</code> to filter for keys with certain tags</li>
<li><code>translated:{true|false}</code> for translation status (also requires <code>locale_id</code> to be specified)</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
<li><code>unmentioned_in_upload:upload_id</code> to filter keys unmentioned within upload</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
<tr class="even">
<td><code>tags</code></td>
<td><code>string</code></td>
<td>Tag or comma-separated list of tags to remove from the matching collection of keys</td>
</tr>
<tr class="odd">
<td><code>locale_id</code><br />
<span class="small">optional</span></td>
<td><code>id</code></td>
<td>Locale used to determine the translation state of a key when filtering for untranslated or translated keys.</td>
</tr>
</tbody>
</table>

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/keys/untag" \
  -u USERNAME_OR_ACCESS_TOKEN \
  -X PATCH \
  -d '{"q":"dog* translated:true","tags":"landing-page,release-1.2","locale_id":"abcd1234abcd1234abcd1234abcd1234"}' \
  -H 'Content-Type: application/json'
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase keys untag \
--project_id <project_id> \
--data '{"query":"'dog* translated:true'", "tags":"landing-page,release-1.2", "locale_id":"abcd1234abcd1234abcd1234abcd1234"}' \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp keys untag <project_id> \
--query 'dog* translated:true' \
--tags landing-page,release-1.2 \
--locale-id abcd1234abcd1234abcd1234abcd1234
```

</div>

</div>

</div>

<div id="examples_broad_match" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Find keys with broad text match

    GET /v2/projects/:project_id/keys

Example query `my dog`

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to do broad search for keys by name (including wildcards).<br />
<br />
The following qualifiers are also supported in the search term:<br />

<ul>
<li><code>ids:key_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>name:key_name</code> for text queries on exact key names - whitespaces need to be prefixed with a backspace ("\")</li>
<li><code>tags:tag_name</code> to filter for keys with certain tags</li>
<li><code>translated:{true|false}</code> for translation status (also requires <code>locale_id</code> to be specified)</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
<li><code>unmentioned_in_upload:upload_id</code> to filter keys unmentioned within upload</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
</tbody>
</table>

</div>

#### Matches

<span class="result-match">**My dog** is lazy  
</span> <span class="result-match">**my dog** is lazy  
</span> <span class="result-match">angry **dog** in **my** house</span>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/keys?q=my%20dog" \
  -u USERNAME_OR_ACCESS_TOKEN
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase keys list \
--project_id <project_id> \
--query "my dog" \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp keys list <project_id> \
--query "my dog"
```

</div>

</div>

</div>

<div id="examples_exact_match" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Find keys with exact text match

    GET /v2/projects/:project_id/keys

Example query `"my dog is lazy"` (note backslashes before any whitespace
character in the example query)

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to do broad search for keys by name (including wildcards).<br />
<br />
The following qualifiers are also supported in the search term:<br />

<ul>
<li><code>ids:key_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>name:key_name</code> for text queries on exact key names - whitespaces need to be prefixed with a backspace ("\")</li>
<li><code>tags:tag_name</code> to filter for keys with certain tags</li>
<li><code>translated:{true|false}</code> for translation status (also requires <code>locale_id</code> to be specified)</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
<li><code>unmentioned_in_upload:upload_id</code> to filter keys unmentioned within upload</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
</tbody>
</table>

</div>

#### Matches

~~My dog is lazy~~  
<span class="result-match">**my dog is lazy**  
</span> ~~angry dog in my house~~

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/keys?q=name:my%5C%20dog%5C%20is%5C%20lazy" \
  -u USERNAME_OR_ACCESS_TOKEN
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase keys list \
--project_id <project_id> \
--query "name:my\ dog\ is\ lazy" \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp keys list <project_id> \
--query "name:my\ dog\ is\ lazy"
```

</div>

</div>

</div>

<div id="examples_wildcard_match" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Find keys with wildcard character matching

    GET /v2/projects/:project_id/keys

Example query `*dog is*`

#### Parameters

<div class="table-responsive">

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>q</code><br />
<span class="small">optional</span></td>
<td><code>string</code></td>
<td>Specify a query to do broad search for keys by name (including wildcards).<br />
<br />
The following qualifiers are also supported in the search term:<br />

<ul>
<li><code>ids:key_id,...</code> for queries on a comma-separated list of ids</li>
<li><code>name:key_name</code> for text queries on exact key names - whitespaces need to be prefixed with a backspace ("\")</li>
<li><code>tags:tag_name</code> to filter for keys with certain tags</li>
<li><code>translated:{true|false}</code> for translation status (also requires <code>locale_id</code> to be specified)</li>
<li><code>updated_at:{&gt;=|&lt;=}2013-02-21T00:00:00Z</code> for date range queries</li>
<li><code>unmentioned_in_upload:upload_id</code> to filter keys unmentioned within upload</li>
</ul>
Find more examples <a href="#examples">here</a>.</td>
</tr>
</tbody>
</table>

</div>

#### Matches

<span class="result-match">My **dog is** lazy  
</span> <span class="result-match">my **dog is** lazy  
</span> ~~angry dog in my house~~

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/keys?q=*dog%20is*" \
  -u USERNAME_OR_ACCESS_TOKEN
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase keys list \
--project_id <project_id> \
--query '*dog is*' \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp keys list <project_id> \
--query '*dog is*'
```

</div>

</div>

</div>

<div id="examples_xlsx_upload" class="resource__section" data-target="page.section">

<div class="resource__copy">

### Upload an Excel file with several translations

    POST /v2/projects/:project_id/uploads

Suppose you have an excel file where the 'A' column contains the key
names, the 'B' column contains English translations, the 'C' column
contains German translations and the 'D' column contains comments.
Furthermore, the actual content starts in the second row, since the
first row is reserved for a header. You can upload this file and import
all translations at once\!

#### Parameters

<div class="table-responsive">

| Name                                | Type     | Description                                                 |
| ----------------------------------- | -------- | ----------------------------------------------------------- |
| `file`                              | `file`   | File to be imported                                         |
| `file_format`                       | `string` | File format. Auto-detected when possible and not specified. |
| `locale_mapping[en]`                | `string` | Name of the column containing translations for locale en.   |
| `locale_mapping[de]`                | `string` | Name of the column containing translations for locale de.   |
| `format_options[comment_column]`    | `string` | Name of the column containing descriptions for keys.        |
| `format_options[tag_column]`        | `string` | Name of the column containing tags for keys.                |
| `format_options[key_name_column]`   | `string` | Name of the column containing the names of the keys.        |
| `format_options[first_content_row]` | `string` | Name of the first row containing actual translations.       |

</div>

</div>

<div class="resource__code">

#### Example Request

<div class="code-section" data-target="technology-switch.example" data-technology="curl">

``` language-bash
curl "https://api.phrase.com/v2/projects/:project_id/uploads" \
  -u USERNAME_OR_ACCESS_TOKEN \
  -X POST \
  -F file=@/path/to/my/file.xlsx \
  -F file_format=xlsx \
  -F locale_mapping[en]=B \
  -F locale_mapping[de]=C \
  -F format_options[comment_column]=D \
  -F format_options[tag_column]=E \
  -F format_options[key_name_column]=A \
  -F format_options[first_content_row]=2
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v2">

``` language-bash
phrase uploads create \
--project_id <project_id> \
--file /path/to/my/file.xlsx \
--file_format xlsx \
--locale_id abcd1234cdef1234abcd1234cdef1234 \
--tags awesome-feature,needs-proofreading \
--locale_mapping '{"en": "B", "de": "C"}' \
--format_options '{"comment_column": "D", "tag_column": "E", "key_name_column": "A", "first_content_row": "2"}' \
--access_token <token>
```

</div>

<div class="code-section hidden" data-target="technology-switch.example" data-technology="cli v1">

``` language-bash
phraseapp upload create <project_id> \
--file /path/to/my/file.xlsx \
--file-format xlsx \
--locale-mapping[en] B \
--locale-mapping[de] C \
--format-options[comment-column] D \
--format-options[tag-column] E \
--format-options[key-name-column] A \
--format-options[first-content-row] 2
```

</div>

</div>

</div>

</div>
