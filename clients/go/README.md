# Go API client for openapi

Phrase is a translation management platform for software projects. You can collaborate on language file translation with your team or order translations through our platform. The API allows you to import locale files, download locale files, tag keys or interact in other ways with the localization data stored in Phrase for your account.
## API Endpoint
<div class=\"resource__code--outer\">
  <div class=\"code-section\">
    <pre><code>https://api.phrase.com/v2/</code></pre>
  </div>
</div>
The API is only accessible via HTTPS, the base URL is <code>https://api.phrase.com/</code>, and the current version is <code>v2</code> which results in the base URL for all requests: <code>https://api.phrase.com/v2/</code>.

## Usage
[curl](http://curl.haxx.se/) is used primarily to send requests to Phrase in the examples. On most you'll find a second variant using the [Phrase API v2 client](https://phrase.com/cli/) that might be more convenient to handle. For further information check its [documentation](https://help.phrase.com/help/phrase-in-your-terminal).

## Use of HTTP Verbs
Phrase API v2 tries to use the appropriate HTTP verb for accessing each endpoint according to REST specification where possible:
<div class=\"table-responsive\">
  <table class=\"basic-table\">
    <thead>
      <tr class=\"basic-table__row basic-table__row--header\">
        <th class=\"basic-table__cell basic-table__cell--header\">Verb</th>
        <th class=\"basic-table__cell basic-table__cell--header\">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class=\"basic-table__cell\">GET</td>
        <td class=\"basic-table__cell\">Retrieve one or multiple resources</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\">POST</td>
        <td class=\"basic-table__cell\">Create a resource</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\">PUT</td>
        <td class=\"basic-table__cell\">Update a resource</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\">PATCH</td>
        <td class=\"basic-table__cell\">Update a resource (partially)</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\">DELETE</td>
        <td class=\"basic-table__cell\">Delete a resource</td>
      </tr>
    </tbody>
  </table>
</div>

## Identification via User-Agent
You must include the User-Agent header with the name of your application or project. It might be a good idea to include some sort of contact information  as well, so that we can get in touch if necessary (e.g. to warn you about Rate-Limiting or badly formed requests). Examples of excellent User-Agent headers:
<pre><code>User-Agent: Frederiks Mobile App (frederik@phrase.com) User-Agent: ACME Inc Python Client (http://example.com/contact)</code></pre>
If you don't send this header, you will receive a response with 400 Bad Request.

## Lists
When you request a list of resources, the API will typically only return an array of resources including their most important attributes. For a detailed representation of the resource you should request its detailed representation.
Lists are usually [paginated](#pagination).

## Parameters
Many endpoints support additional parameters, e.g. for pagination. When passing them in a GET request you can send them as HTTP query string parameters:
<pre><code>$ curl -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects?page=2\"</code></pre>
When performing a POST, PUT, PATCH or DELETE request, we recommend sending parameters that are not already included in the URL, as JSON body:
<pre><code>$ curl -H 'Content-Type: application/json' -d '{\"name\":\"My new project\"}' -u EMAIL_OR_ACCESS_TOKEN https://api.phrase.com/v2/projects</code></pre>
Encoding parameters as JSON means better support for types (boolean, integer) and usually better readability. Don't forget to set the correct Content-Type for your request.
*The Content-Type header is omitted in some of the following examples for better readbility.*

## Errors

### Request Errors
If a request contains invalid JSON or is missing a required parameter (besides resource attributes), the status `400 Bad Request` is returned:
<pre><code>{
  \"message\": \"JSON could not be parsed\"
}</code></pre>

### Validation Errors
When the validation for a resource fails, the status `422 Unprocessable Entity` is returned, along with information on the affected fields:
<pre><code>{
  \"message\": \"Validation Failed\",
  \"errors\": [
    {
      \"resource\": \"Project\",
      \"field\": \"name\",
      \"message\": \"can't be blank\"
    }
  ]
}</code></pre>

## Date Format
Times and dates are returned and expected in [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) date format:
<pre><code>YYYY-MM-DDTHH:MM:SSZ</code></pre>
Instead of 'Z' for UTC time zone you can specify your time zone's locale offset using the following notation:
<pre><code>YYYY-MM-DDTHH:MM:SS¬±hh:mm</code></pre>
Example for CET (1 hour behind UTC):
<pre><code>2015-03-31T13:00+01:00</code></pre>
Please note that in HTTP headers, we will use the appropriate recommended date formats instead of ISO 8601.

## Authentication options
<div class=\"alert alert-info\">For more detailed information on authentication, check out the <a href=\"#authentication\">API v2 Authentication Guide</a>.</div>
There are two different ways to authenticate when performing API requests:
* E-Mail and password * Oauth Access Token

### E-Mail and password
To get started easily, you can use HTTP Basic authentication with your email and password:
<pre><code>$ curl -u username:password \"https://api.phrase.com/v2/projects\"</code></pre>

### OAuth via Access Tokens
You can create and manage access tokens in your [profile settings](https://app.phrase.com/settings/oauth_access_tokens) in Translation Center or via the [Authorizations API](#authorizations).
Simply pass the access token as the username of your request:
<pre><code>$ curl -u ACCESS_TOKEN: \"https://api.phrase.com/v2/projects\"</code></pre>
or send the access token via the `Authorization` header field:
<pre><code>$ curl -H \"Authorization: token ACCESS_TOKEN\" https://api.phrase.com/v2/projects</code></pre>
For more detailed information on authentication, check out the <a href=\"#authentication\">API v2 Authentication Guide</a>.
## Pagination
Endpoints that return a list or resources will usually return paginated results and include 25 items by default. To access further pages, use the `page` parameter:
<pre><code>$ curl -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects?page=2\"</code></pre>
Some endpoints also allow a custom page size by using the `per_page` parameter:
<pre><code>$ curl -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects?page=2&per_page=50\"</code></pre>
Unless specified otherwise in the description of the respective endpoint, `per_page` allows you to specify a page size up to 100 items.

## Link-Headers
We provide you with pagination URLs in the [Link Header field](http://tools.ietf.org/html/rfc5988). Make use of this information to avoid building pagination URLs yourself.
<pre><code>Link: <https://api.phrase.com/v2/projects?page=1>; rel=\"first\", <https://api.phrase.com/v2/projects?page=3>; rel=\"prev\", <https://api.phrase.com/v2/projects?page=5>; rel=\"next\", <https://api.phrase.com/v2/projects?page=9>; rel=\"last\"</code></pre>
Possible `rel` values are:
<div class=\"table-responsive\">
  <table class=\"basic-table\">
    <thead>
      <tr class=\"basic-table__row basic-table__row--header\">
        <th class=\"basic-table__cell basic-table__cell--header\">Value</th>
        <th class=\"basic-table__cell basic-table__cell--header\">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class=\"basic-table__cell\">next</td>
        <td class=\"basic-table__cell\">URL of the next page of results</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\">last</td>
        <td class=\"basic-table__cell\">URL of the last page of results</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\">first</td>
        <td class=\"basic-table__cell\">URL of the first page of results</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\">prev</td>
        <td class=\"basic-table__cell\">URL of the previous page of results</td>
      </tr>
    </tbody>
  </table>
</div>
## Rate Limiting
All API endpoints are subject to rate limiting to ensure good performance for all customers. The rate limit is calculated per user:
* 1000 requests per 5 minutes * 4 concurrent (parallel) requests
For your convenience we send information on the current rate limit within the response headers:
<div class=\"table-responsive\">
  <table class=\"basic-table\">
    <thead>
      <tr class=\"basic-table__row basic-table__row--header\">
        <th class=\"basic-table__cell basic-table__cell--header\">Header</th>
        <th class=\"basic-table__cell basic-table__cell--header\">Description</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class=\"basic-table__cell\" style=\"white-space: nowrap;\"><code>X-Rate-Limit-Limit</code></td>
        <td class=\"basic-table__cell\">Number of max requests allowed in the current time period</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\" style=\"white-space: nowrap;\"><code>X-Rate-Limit-Remaining</code></td>
        <td class=\"basic-table__cell\">Number of remaining requests in the current time period</td>
      </tr>
      <tr>
        <td class=\"basic-table__cell\" style=\"white-space: nowrap;\"><code>X-Rate-Limit-Reset</code></td>
        <td class=\"basic-table__cell\">Timestamp of end of current time period as UNIX timestamp</td>
      </tr>
    </tbody>
  </table>
</div>
If you should run into the rate limit, you will receive the HTTP status code `429: Too many requests`.
If you should need higher rate limits, [contact us](https://phrase.com/contact).

## Conditional GET requests / HTTP Caching
<div class=\"alert alert-info\"><p><strong>Note:</strong> Conditional GET requests are currently only supported for <a href=\"#locales_download\">locales#download</a> and <a href=\"#translations_index\">translations#index</a></p></div>
We will return an ETag or Last-Modified header with most GET requests. When you request a resource we recommend to store this value and submit them on subsequent requests as `If-Modified-Since` and `If-None-Match` headers. If the resource has not changed in the meantime, we will return the status `304 Not Modified` instead of rendering and returning the resource again. In most cases this is less time-consuming and makes your application/integration faster.
Please note that all conditional requests that return a response with status 304 don't count against your rate limits.
<pre><code>$ curl -i -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download\" HTTP/1.1 200 OK ETag: \"abcd1234abcdefefabcd1234efab1234\" Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC Status: 200 OK
$ curl -i -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download\" -H 'If-None-Match: \"abcd1234abcdefefabcd1234efab1234\"' HTTP/1.1 304 Not Modified ETag: \"abcd1234abcdefefabcd1234efab1234\" Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC Status: 304 Not Modified
$ curl -i -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download\" -H \"If-Modified-Since: Wed, 28 Jan 2015 15:31:30 UTC\" HTTP/1.1 304 Not Modified Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC Status: 304 Not Modified</code></pre>

## JSONP
The Phrase API supports [JSONP](http://en.wikipedia.org/wiki/JSONP) for all GET requests in order to deal with cross-domain request issues. Just send a `?callback` parameter along with the request to specify the Javascript function name to be called with the response content:
<pre><code>$ curl \"https://api.phrase.com/v2/projects?callback=myFunction\"</code></pre>
The response will include the normal output for that endpoint, along with a `meta` section including header data:
<pre><code>myFunction({
  {
    \"meta\": {
      \"status\": 200,
      ...
    },
    \"data\": [
      {
        \"id\": \"1234abcd1234abc1234abcd1234abc\"
        ...
      }
    ]
  }
});</code></pre>
To authenticate a JSONP request, you can send a valid [access token](#authentication) as the `?access_token` parameter along the request:
<pre><code>$ curl \"https://api.phrase.com/v2/projects?callback=myFunction&access_token=ACCESS-TOKEN\"</code></pre>


## Overview
This API client was generated by the [OpenAPI Generator](https://openapi-generator.tech) project.  By using the [OpenAPI-spec](https://www.openapis.org/) from a remote server, you can easily generate an API client.

- API version: 2.0.0
- Package version: 1.0.0
- Build package: org.openapitools.codegen.languages.GoClientCodegen
For more information, please visit [https://developers.phrase.com/api/](https://developers.phrase.com/api/)

## Installation

Install the following dependencies:

```shell
go get github.com/stretchr/testify/assert
go get golang.org/x/oauth2
go get golang.org/x/net/context
go get github.com/antihax/optional
```

Put the package under your project folder and add the following in import:

```golang
import "./openapi"
```

## Documentation for API Endpoints

All URIs are relative to *https://api.phrase.com/v2*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*SpacesApi* | [**Space**](docs/SpacesApi.md#space) | **Get** /accounts/{account_id}/spaces/{space_id} | Get Space
*SpacesApi* | [**SpaceCreate**](docs/SpacesApi.md#spacecreate) | **Post** /accounts/{account_id}/spaces | Create space
*SpacesApi* | [**SpaceDelete**](docs/SpacesApi.md#spacedelete) | **Delete** /accounts/{account_id}/spaces/{space_id} | Delete Space
*SpacesApi* | [**SpaceProjectDelete**](docs/SpacesApi.md#spaceprojectdelete) | **Delete** /accounts/{account_id}/spaces/{space_id}/projects/{project_id} | Removes a specified project from the specified space.
*SpacesApi* | [**SpaceProjects**](docs/SpacesApi.md#spaceprojects) | **Get** /accounts/{account_id}/spaces/{space_id}/projects | List all projects for the specified Space..
*SpacesApi* | [**SpaceProjectsCreate**](docs/SpacesApi.md#spaceprojectscreate) | **Post** /accounts/{account_id}/spaces/{space_id}/projects | Adds an existing project to the space.
*SpacesApi* | [**SpaceUpdate**](docs/SpacesApi.md#spaceupdate) | **Patch** /accounts/{account_id}/spaces/{space_id} | Update Space
*SpacesApi* | [**Spaces**](docs/SpacesApi.md#spaces) | **Get** /accounts/{account_id}/spaces | List all Spaces for the given account.


## Documentation For Models

 - [Account](docs/Account.md)
 - [Errors](docs/Errors.md)
 - [ErrorsErrors](docs/ErrorsErrors.md)
 - [InlineObject](docs/InlineObject.md)
 - [InlineObject1](docs/InlineObject1.md)
 - [InlineObject2](docs/InlineObject2.md)
 - [Project](docs/Project.md)
 - [Space](docs/Space.md)


## Documentation For Authorization



## Basic

- **Type**: HTTP basic authentication

Example

```golang
auth := context.WithValue(context.Background(), sw.ContextBasicAuth, sw.BasicAuth{
    UserName: "username",
    Password: "password",
})
r, err := client.Service.Operation(auth, args)
```


## Token

- **Type**: API key

Example

```golang
auth := context.WithValue(context.Background(), sw.ContextAPIKey, sw.APIKey{
    Key: "APIKEY",
    Prefix: "Bearer", // Omit if not necessary.
})
r, err := client.Service.Operation(auth, args)
```



## Author

support@phrase.com

