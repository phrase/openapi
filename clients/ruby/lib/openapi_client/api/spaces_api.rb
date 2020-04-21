=begin
#Phrase API Reference

#Phrase is a translation management platform for software projects. You can collaborate on language file translation with your team or order translations through our platform. The API allows you to import locale files, download locale files, tag keys or interact in other ways with the localization data stored in Phrase for your account. ## API Endpoint <div class=\"resource__code--outer\">   <div class=\"code-section\">     <pre><code>https://api.phrase.com/v2/</code></pre>   </div> </div> The API is only accessible via HTTPS, the base URL is <code>https://api.phrase.com/</code>, and the current version is <code>v2</code> which results in the base URL for all requests: <code>https://api.phrase.com/v2/</code>.  ## Usage [curl](http://curl.haxx.se/) is used primarily to send requests to Phrase in the examples. On most you'll find a second variant using the [Phrase API v2 client](https://phrase.com/cli/) that might be more convenient to handle. For further information check its [documentation](https://help.phrase.com/help/phrase-in-your-terminal).  ## Use of HTTP Verbs Phrase API v2 tries to use the appropriate HTTP verb for accessing each endpoint according to REST specification where possible: <div class=\"table-responsive\">   <table class=\"basic-table\">     <thead>       <tr class=\"basic-table__row basic-table__row--header\">         <th class=\"basic-table__cell basic-table__cell--header\">Verb</th>         <th class=\"basic-table__cell basic-table__cell--header\">Description</th>       </tr>     </thead>     <tbody>       <tr>         <td class=\"basic-table__cell\">GET</td>         <td class=\"basic-table__cell\">Retrieve one or multiple resources</td>       </tr>       <tr>         <td class=\"basic-table__cell\">POST</td>         <td class=\"basic-table__cell\">Create a resource</td>       </tr>       <tr>         <td class=\"basic-table__cell\">PUT</td>         <td class=\"basic-table__cell\">Update a resource</td>       </tr>       <tr>         <td class=\"basic-table__cell\">PATCH</td>         <td class=\"basic-table__cell\">Update a resource (partially)</td>       </tr>       <tr>         <td class=\"basic-table__cell\">DELETE</td>         <td class=\"basic-table__cell\">Delete a resource</td>       </tr>     </tbody>   </table> </div>  ## Identification via User-Agent You must include the User-Agent header with the name of your application or project. It might be a good idea to include some sort of contact information  as well, so that we can get in touch if necessary (e.g. to warn you about Rate-Limiting or badly formed requests). Examples of excellent User-Agent headers: <pre><code>User-Agent: Frederiks Mobile App (frederik@phrase.com) User-Agent: ACME Inc Python Client (http://example.com/contact)</code></pre> If you don't send this header, you will receive a response with 400 Bad Request.  ## Lists When you request a list of resources, the API will typically only return an array of resources including their most important attributes. For a detailed representation of the resource you should request its detailed representation. Lists are usually [paginated](#pagination).  ## Parameters Many endpoints support additional parameters, e.g. for pagination. When passing them in a GET request you can send them as HTTP query string parameters: <pre><code>$ curl -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects?page=2\"</code></pre> When performing a POST, PUT, PATCH or DELETE request, we recommend sending parameters that are not already included in the URL, as JSON body: <pre><code>$ curl -H 'Content-Type: application/json' -d '{\"name\":\"My new project\"}' -u EMAIL_OR_ACCESS_TOKEN https://api.phrase.com/v2/projects</code></pre> Encoding parameters as JSON means better support for types (boolean, integer) and usually better readability. Don't forget to set the correct Content-Type for your request. *The Content-Type header is omitted in some of the following examples for better readbility.*  ## Errors  ### Request Errors If a request contains invalid JSON or is missing a required parameter (besides resource attributes), the status `400 Bad Request` is returned: <pre><code>{   \"message\": \"JSON could not be parsed\" }</code></pre>  ### Validation Errors When the validation for a resource fails, the status `422 Unprocessable Entity` is returned, along with information on the affected fields: <pre><code>{   \"message\": \"Validation Failed\",   \"errors\": [     {       \"resource\": \"Project\",       \"field\": \"name\",       \"message\": \"can't be blank\"     }   ] }</code></pre>  ## Date Format Times and dates are returned and expected in [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) date format: <pre><code>YYYY-MM-DDTHH:MM:SSZ</code></pre> Instead of 'Z' for UTC time zone you can specify your time zone's locale offset using the following notation: <pre><code>YYYY-MM-DDTHH:MM:SS¬±hh:mm</code></pre> Example for CET (1 hour behind UTC): <pre><code>2015-03-31T13:00+01:00</code></pre> Please note that in HTTP headers, we will use the appropriate recommended date formats instead of ISO 8601.  ## Authentication options <div class=\"alert alert-info\">For more detailed information on authentication, check out the <a href=\"#authentication\">API v2 Authentication Guide</a>.</div> There are two different ways to authenticate when performing API requests: * E-Mail and password * Oauth Access Token  ### E-Mail and password To get started easily, you can use HTTP Basic authentication with your email and password: <pre><code>$ curl -u username:password \"https://api.phrase.com/v2/projects\"</code></pre>  ### OAuth via Access Tokens You can create and manage access tokens in your [profile settings](https://app.phrase.com/settings/oauth_access_tokens) in Translation Center or via the [Authorizations API](#authorizations). Simply pass the access token as the username of your request: <pre><code>$ curl -u ACCESS_TOKEN: \"https://api.phrase.com/v2/projects\"</code></pre> or send the access token via the `Authorization` header field: <pre><code>$ curl -H \"Authorization: token ACCESS_TOKEN\" https://api.phrase.com/v2/projects</code></pre> For more detailed information on authentication, check out the <a href=\"#authentication\">API v2 Authentication Guide</a>. ## Pagination Endpoints that return a list or resources will usually return paginated results and include 25 items by default. To access further pages, use the `page` parameter: <pre><code>$ curl -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects?page=2\"</code></pre> Some endpoints also allow a custom page size by using the `per_page` parameter: <pre><code>$ curl -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects?page=2&per_page=50\"</code></pre> Unless specified otherwise in the description of the respective endpoint, `per_page` allows you to specify a page size up to 100 items.  ## Link-Headers We provide you with pagination URLs in the [Link Header field](http://tools.ietf.org/html/rfc5988). Make use of this information to avoid building pagination URLs yourself. <pre><code>Link: <https://api.phrase.com/v2/projects?page=1>; rel=\"first\", <https://api.phrase.com/v2/projects?page=3>; rel=\"prev\", <https://api.phrase.com/v2/projects?page=5>; rel=\"next\", <https://api.phrase.com/v2/projects?page=9>; rel=\"last\"</code></pre> Possible `rel` values are: <div class=\"table-responsive\">   <table class=\"basic-table\">     <thead>       <tr class=\"basic-table__row basic-table__row--header\">         <th class=\"basic-table__cell basic-table__cell--header\">Value</th>         <th class=\"basic-table__cell basic-table__cell--header\">Description</th>       </tr>     </thead>     <tbody>       <tr>         <td class=\"basic-table__cell\">next</td>         <td class=\"basic-table__cell\">URL of the next page of results</td>       </tr>       <tr>         <td class=\"basic-table__cell\">last</td>         <td class=\"basic-table__cell\">URL of the last page of results</td>       </tr>       <tr>         <td class=\"basic-table__cell\">first</td>         <td class=\"basic-table__cell\">URL of the first page of results</td>       </tr>       <tr>         <td class=\"basic-table__cell\">prev</td>         <td class=\"basic-table__cell\">URL of the previous page of results</td>       </tr>     </tbody>   </table> </div> ## Rate Limiting All API endpoints are subject to rate limiting to ensure good performance for all customers. The rate limit is calculated per user: * 1000 requests per 5 minutes * 4 concurrent (parallel) requests For your convenience we send information on the current rate limit within the response headers: <div class=\"table-responsive\">   <table class=\"basic-table\">     <thead>       <tr class=\"basic-table__row basic-table__row--header\">         <th class=\"basic-table__cell basic-table__cell--header\">Header</th>         <th class=\"basic-table__cell basic-table__cell--header\">Description</th>       </tr>     </thead>     <tbody>       <tr>         <td class=\"basic-table__cell\" style=\"white-space: nowrap;\"><code>X-Rate-Limit-Limit</code></td>         <td class=\"basic-table__cell\">Number of max requests allowed in the current time period</td>       </tr>       <tr>         <td class=\"basic-table__cell\" style=\"white-space: nowrap;\"><code>X-Rate-Limit-Remaining</code></td>         <td class=\"basic-table__cell\">Number of remaining requests in the current time period</td>       </tr>       <tr>         <td class=\"basic-table__cell\" style=\"white-space: nowrap;\"><code>X-Rate-Limit-Reset</code></td>         <td class=\"basic-table__cell\">Timestamp of end of current time period as UNIX timestamp</td>       </tr>     </tbody>   </table> </div> If you should run into the rate limit, you will receive the HTTP status code `429: Too many requests`. If you should need higher rate limits, [contact us](https://phrase.com/contact).  ## Conditional GET requests / HTTP Caching <div class=\"alert alert-info\"><p><strong>Note:</strong> Conditional GET requests are currently only supported for <a href=\"#locales_download\">locales#download</a> and <a href=\"#translations_index\">translations#index</a></p></div> We will return an ETag or Last-Modified header with most GET requests. When you request a resource we recommend to store this value and submit them on subsequent requests as `If-Modified-Since` and `If-None-Match` headers. If the resource has not changed in the meantime, we will return the status `304 Not Modified` instead of rendering and returning the resource again. In most cases this is less time-consuming and makes your application/integration faster. Please note that all conditional requests that return a response with status 304 don't count against your rate limits. <pre><code>$ curl -i -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download\" HTTP/1.1 200 OK ETag: \"abcd1234abcdefefabcd1234efab1234\" Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC Status: 200 OK $ curl -i -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download\" -H 'If-None-Match: \"abcd1234abcdefefabcd1234efab1234\"' HTTP/1.1 304 Not Modified ETag: \"abcd1234abcdefefabcd1234efab1234\" Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC Status: 304 Not Modified $ curl -i -u EMAIL_OR_ACCESS_TOKEN \"https://api.phrase.com/v2/projects/1234abcd1234abcdefefabcd1234efab/locales/en/download\" -H \"If-Modified-Since: Wed, 28 Jan 2015 15:31:30 UTC\" HTTP/1.1 304 Not Modified Last-Modified: Wed, 28 Jan 2015 15:31:30 UTC Status: 304 Not Modified</code></pre>  ## JSONP The Phrase API supports [JSONP](http://en.wikipedia.org/wiki/JSONP) for all GET requests in order to deal with cross-domain request issues. Just send a `?callback` parameter along with the request to specify the Javascript function name to be called with the response content: <pre><code>$ curl \"https://api.phrase.com/v2/projects?callback=myFunction\"</code></pre> The response will include the normal output for that endpoint, along with a `meta` section including header data: <pre><code>myFunction({   {     \"meta\": {       \"status\": 200,       ...     },     \"data\": [       {         \"id\": \"1234abcd1234abc1234abcd1234abc\"         ...       }     ]   } });</code></pre> To authenticate a JSONP request, you can send a valid [access token](#authentication) as the `?access_token` parameter along the request: <pre><code>$ curl \"https://api.phrase.com/v2/projects?callback=myFunction&access_token=ACCESS-TOKEN\"</code></pre> 

The version of the OpenAPI document: 2.0.0
Contact: support@phrase.com
Generated by: https://openapi-generator.tech
OpenAPI Generator version: 4.3.0

=end

require 'cgi'

module OpenapiClient
  class SpacesApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Get Space
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Space]
    def space(account_id, space_id, opts = {})
      data, _status_code, _headers = space_with_http_info(account_id, space_id, opts)
      data
    end

    # Get Space
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Array<(Space, Integer, Hash)>] Space data, response status code and response headers
    def space_with_http_info(account_id, space_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.space ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.space"
      end
      # verify the required parameter 'space_id' is set
      if @api_client.config.client_side_validation && space_id.nil?
        fail ArgumentError, "Missing the required parameter 'space_id' when calling SpacesApi.space"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces/{space_id}'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s)).sub('{' + 'space_id' + '}', CGI.escape(space_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      # return_type
      return_type = opts[:return_type] || 'Space' 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#space\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Create space
    # @param account_id [String] Account ID
    # @param inline_object [InlineObject] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Space]
    def space_create(account_id, inline_object, opts = {})
      data, _status_code, _headers = space_create_with_http_info(account_id, inline_object, opts)
      data
    end

    # Create space
    # @param account_id [String] Account ID
    # @param inline_object [InlineObject] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Array<(Space, Integer, Hash)>] Space data, response status code and response headers
    def space_create_with_http_info(account_id, inline_object, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.space_create ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.space_create"
      end
      # verify the required parameter 'inline_object' is set
      if @api_client.config.client_side_validation && inline_object.nil?
        fail ArgumentError, "Missing the required parameter 'inline_object' when calling SpacesApi.space_create"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] || @api_client.object_to_http_body(inline_object) 

      # return_type
      return_type = opts[:return_type] || 'Space' 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:POST, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#space_create\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Delete Space
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [nil]
    def space_delete(account_id, space_id, opts = {})
      space_delete_with_http_info(account_id, space_id, opts)
      nil
    end

    # Delete Space
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Array<(nil, Integer, Hash)>] nil, response status code and response headers
    def space_delete_with_http_info(account_id, space_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.space_delete ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.space_delete"
      end
      # verify the required parameter 'space_id' is set
      if @api_client.config.client_side_validation && space_id.nil?
        fail ArgumentError, "Missing the required parameter 'space_id' when calling SpacesApi.space_delete"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces/{space_id}'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s)).sub('{' + 'space_id' + '}', CGI.escape(space_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      # return_type
      return_type = opts[:return_type] 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#space_delete\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Removes a specified project from the specified space.
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param project_id [String] Project ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [nil]
    def space_project_delete(account_id, space_id, project_id, opts = {})
      space_project_delete_with_http_info(account_id, space_id, project_id, opts)
      nil
    end

    # Removes a specified project from the specified space.
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param project_id [String] Project ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Array<(nil, Integer, Hash)>] nil, response status code and response headers
    def space_project_delete_with_http_info(account_id, space_id, project_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.space_project_delete ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.space_project_delete"
      end
      # verify the required parameter 'space_id' is set
      if @api_client.config.client_side_validation && space_id.nil?
        fail ArgumentError, "Missing the required parameter 'space_id' when calling SpacesApi.space_project_delete"
      end
      # verify the required parameter 'project_id' is set
      if @api_client.config.client_side_validation && project_id.nil?
        fail ArgumentError, "Missing the required parameter 'project_id' when calling SpacesApi.space_project_delete"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces/{space_id}/projects/{project_id}'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s)).sub('{' + 'space_id' + '}', CGI.escape(space_id.to_s)).sub('{' + 'project_id' + '}', CGI.escape(project_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      # return_type
      return_type = opts[:return_type] 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#space_project_delete\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # List all projects for the specified Space..
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @option opts [Integer] :page Page number
    # @option opts [Integer] :per_page allows you to specify a page size up to 100 items, 10 by default
    # @return [Array<Project>]
    def space_projects(account_id, space_id, opts = {})
      data, _status_code, _headers = space_projects_with_http_info(account_id, space_id, opts)
      data
    end

    # List all projects for the specified Space..
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @option opts [Integer] :page Page number
    # @option opts [Integer] :per_page allows you to specify a page size up to 100 items, 10 by default
    # @return [Array<(Array<Project>, Integer, Hash)>] Array<Project> data, response status code and response headers
    def space_projects_with_http_info(account_id, space_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.space_projects ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.space_projects"
      end
      # verify the required parameter 'space_id' is set
      if @api_client.config.client_side_validation && space_id.nil?
        fail ArgumentError, "Missing the required parameter 'space_id' when calling SpacesApi.space_projects"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces/{space_id}/projects'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s)).sub('{' + 'space_id' + '}', CGI.escape(space_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'page'] = opts[:'page'] if !opts[:'page'].nil?
      query_params[:'per_page'] = opts[:'per_page'] if !opts[:'per_page'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      # return_type
      return_type = opts[:return_type] || 'Array<Project>' 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#space_projects\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Adds an existing project to the space.
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param inline_object2 [InlineObject2] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Project]
    def space_projects_create(account_id, space_id, inline_object2, opts = {})
      data, _status_code, _headers = space_projects_create_with_http_info(account_id, space_id, inline_object2, opts)
      data
    end

    # Adds an existing project to the space.
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param inline_object2 [InlineObject2] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Array<(Project, Integer, Hash)>] Project data, response status code and response headers
    def space_projects_create_with_http_info(account_id, space_id, inline_object2, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.space_projects_create ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.space_projects_create"
      end
      # verify the required parameter 'space_id' is set
      if @api_client.config.client_side_validation && space_id.nil?
        fail ArgumentError, "Missing the required parameter 'space_id' when calling SpacesApi.space_projects_create"
      end
      # verify the required parameter 'inline_object2' is set
      if @api_client.config.client_side_validation && inline_object2.nil?
        fail ArgumentError, "Missing the required parameter 'inline_object2' when calling SpacesApi.space_projects_create"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces/{space_id}/projects'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s)).sub('{' + 'space_id' + '}', CGI.escape(space_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] || @api_client.object_to_http_body(inline_object2) 

      # return_type
      return_type = opts[:return_type] || 'Project' 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:POST, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#space_projects_create\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Update Space
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param inline_object1 [InlineObject1] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Space]
    def space_update(account_id, space_id, inline_object1, opts = {})
      data, _status_code, _headers = space_update_with_http_info(account_id, space_id, inline_object1, opts)
      data
    end

    # Update Space
    # @param account_id [String] Account ID
    # @param space_id [String] Space ID
    # @param inline_object1 [InlineObject1] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @return [Array<(Space, Integer, Hash)>] Space data, response status code and response headers
    def space_update_with_http_info(account_id, space_id, inline_object1, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.space_update ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.space_update"
      end
      # verify the required parameter 'space_id' is set
      if @api_client.config.client_side_validation && space_id.nil?
        fail ArgumentError, "Missing the required parameter 'space_id' when calling SpacesApi.space_update"
      end
      # verify the required parameter 'inline_object1' is set
      if @api_client.config.client_side_validation && inline_object1.nil?
        fail ArgumentError, "Missing the required parameter 'inline_object1' when calling SpacesApi.space_update"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces/{space_id}'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s)).sub('{' + 'space_id' + '}', CGI.escape(space_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      header_params['Content-Type'] = @api_client.select_header_content_type(['application/json'])
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] || @api_client.object_to_http_body(inline_object1) 

      # return_type
      return_type = opts[:return_type] || 'Space' 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:PATCH, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#space_update\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # List all Spaces for the given account.
    # @param account_id [String] Account ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @option opts [Integer] :page Page number
    # @option opts [Integer] :per_page allows you to specify a page size up to 100 items, 10 by default
    # @return [Array<Space>]
    def spaces(account_id, opts = {})
      data, _status_code, _headers = spaces_with_http_info(account_id, opts)
      data
    end

    # List all Spaces for the given account.
    # @param account_id [String] Account ID
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_phrase_app_otp Two-Factor-Authentication token
    # @option opts [Integer] :page Page number
    # @option opts [Integer] :per_page allows you to specify a page size up to 100 items, 10 by default
    # @return [Array<(Array<Space>, Integer, Hash)>] Array<Space> data, response status code and response headers
    def spaces_with_http_info(account_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: SpacesApi.spaces ...'
      end
      # verify the required parameter 'account_id' is set
      if @api_client.config.client_side_validation && account_id.nil?
        fail ArgumentError, "Missing the required parameter 'account_id' when calling SpacesApi.spaces"
      end
      # resource path
      local_var_path = '/accounts/{account_id}/spaces'.sub('{' + 'account_id' + '}', CGI.escape(account_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'page'] = opts[:'page'] if !opts[:'page'].nil?
      query_params[:'per_page'] = opts[:'per_page'] if !opts[:'per_page'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-PhraseApp-OTP'] = opts[:'x_phrase_app_otp'] if !opts[:'x_phrase_app_otp'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:body] 

      # return_type
      return_type = opts[:return_type] || 'Array<Space>' 

      # auth_names
      auth_names = opts[:auth_names] || ['Basic', 'Token']

      new_options = opts.merge(
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SpacesApi#spaces\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
