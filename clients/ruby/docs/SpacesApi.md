# OpenapiClient::SpacesApi

All URIs are relative to *https://api.phrase.com/v2*

Method | HTTP request | Description
------------- | ------------- | -------------
[**space**](SpacesApi.md#space) | **GET** /accounts/{account_id}/spaces/{space_id} | Get Space
[**space_create**](SpacesApi.md#space_create) | **POST** /accounts/{account_id}/spaces | Create space
[**space_delete**](SpacesApi.md#space_delete) | **DELETE** /accounts/{account_id}/spaces/{space_id} | Delete Space
[**space_project_delete**](SpacesApi.md#space_project_delete) | **DELETE** /accounts/{account_id}/spaces/{space_id}/projects/{project_id} | Removes a specified project from the specified space.
[**space_projects**](SpacesApi.md#space_projects) | **GET** /accounts/{account_id}/spaces/{space_id}/projects | List all projects for the specified Space..
[**space_projects_create**](SpacesApi.md#space_projects_create) | **POST** /accounts/{account_id}/spaces/{space_id}/projects | Adds an existing project to the space.
[**space_update**](SpacesApi.md#space_update) | **PATCH** /accounts/{account_id}/spaces/{space_id} | Update Space
[**spaces**](SpacesApi.md#spaces) | **GET** /accounts/{account_id}/spaces | List all Spaces for the given account.



## space

> Space space(account_id, space_id, opts)

Get Space

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
space_id = 'space_id_example' # String | Space ID
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example' # String | Two-Factor-Authentication token
}

begin
  #Get Space
  result = api_instance.space(account_id, space_id, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->space: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **space_id** | **String**| Space ID | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 

### Return type

[**Space**](Space.md)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## space_create

> Space space_create(account_id, inline_object, opts)

Create space

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
inline_object = OpenapiClient::InlineObject.new # InlineObject | 
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example' # String | Two-Factor-Authentication token
}

begin
  #Create space
  result = api_instance.space_create(account_id, inline_object, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->space_create: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **inline_object** | [**InlineObject**](InlineObject.md)|  | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 

### Return type

[**Space**](Space.md)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## space_delete

> space_delete(account_id, space_id, opts)

Delete Space

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
space_id = 'space_id_example' # String | Space ID
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example' # String | Two-Factor-Authentication token
}

begin
  #Delete Space
  api_instance.space_delete(account_id, space_id, opts)
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->space_delete: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **space_id** | **String**| Space ID | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 

### Return type

nil (empty response body)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## space_project_delete

> space_project_delete(account_id, space_id, project_id, opts)

Removes a specified project from the specified space.

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
space_id = 'space_id_example' # String | Space ID
project_id = 'project_id_example' # String | Project ID
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example' # String | Two-Factor-Authentication token
}

begin
  #Removes a specified project from the specified space.
  api_instance.space_project_delete(account_id, space_id, project_id, opts)
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->space_project_delete: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **space_id** | **String**| Space ID | 
 **project_id** | **String**| Project ID | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 

### Return type

nil (empty response body)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## space_projects

> Array&lt;Project&gt; space_projects(account_id, space_id, opts)

List all projects for the specified Space..

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
space_id = 'space_id_example' # String | Space ID
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example', # String | Two-Factor-Authentication token
  page: 1, # Integer | Page number
  per_page: 10 # Integer | allows you to specify a page size up to 100 items, 10 by default
}

begin
  #List all projects for the specified Space..
  result = api_instance.space_projects(account_id, space_id, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->space_projects: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **space_id** | **String**| Space ID | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 
 **page** | **Integer**| Page number | [optional] 
 **per_page** | **Integer**| allows you to specify a page size up to 100 items, 10 by default | [optional] 

### Return type

[**Array&lt;Project&gt;**](Project.md)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## space_projects_create

> Project space_projects_create(account_id, space_id, inline_object2, opts)

Adds an existing project to the space.

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
space_id = 'space_id_example' # String | Space ID
inline_object2 = OpenapiClient::InlineObject2.new # InlineObject2 | 
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example' # String | Two-Factor-Authentication token
}

begin
  #Adds an existing project to the space.
  result = api_instance.space_projects_create(account_id, space_id, inline_object2, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->space_projects_create: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **space_id** | **String**| Space ID | 
 **inline_object2** | [**InlineObject2**](InlineObject2.md)|  | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 

### Return type

[**Project**](Project.md)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## space_update

> Space space_update(account_id, space_id, inline_object1, opts)

Update Space

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
space_id = 'space_id_example' # String | Space ID
inline_object1 = OpenapiClient::InlineObject1.new # InlineObject1 | 
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example' # String | Two-Factor-Authentication token
}

begin
  #Update Space
  result = api_instance.space_update(account_id, space_id, inline_object1, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->space_update: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **space_id** | **String**| Space ID | 
 **inline_object1** | [**InlineObject1**](InlineObject1.md)|  | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 

### Return type

[**Space**](Space.md)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## spaces

> Array&lt;Space&gt; spaces(account_id, opts)

List all Spaces for the given account.

### Example

```ruby
# load the gem
require 'openapi_client'
# setup authorization
OpenapiClient.configure do |config|
  # Configure HTTP basic authorization: Basic
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'

  # Configure API key authorization: Token
  config.api_key['Authorization'] = 'YOUR API KEY'
  # Uncomment the following line to set a prefix for the API key, e.g. 'Bearer' (defaults to nil)
  #config.api_key_prefix['Authorization'] = 'Bearer'
end

api_instance = OpenapiClient::SpacesApi.new
account_id = 'account_id_example' # String | Account ID
opts = {
  x_phrase_app_otp: 'x_phrase_app_otp_example', # String | Two-Factor-Authentication token
  page: 1, # Integer | Page number
  per_page: 10 # Integer | allows you to specify a page size up to 100 items, 10 by default
}

begin
  #List all Spaces for the given account.
  result = api_instance.spaces(account_id, opts)
  p result
rescue OpenapiClient::ApiError => e
  puts "Exception when calling SpacesApi->spaces: #{e}"
end
```

### Parameters


Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **account_id** | **String**| Account ID | 
 **x_phrase_app_otp** | **String**| Two-Factor-Authentication token | [optional] 
 **page** | **Integer**| Page number | [optional] 
 **per_page** | **Integer**| allows you to specify a page size up to 100 items, 10 by default | [optional] 

### Return type

[**Array&lt;Space&gt;**](Space.md)

### Authorization

[Basic](../README.md#Basic), [Token](../README.md#Token)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

