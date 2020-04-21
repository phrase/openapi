# OpenAPI specification for Phrase

## Requirements

### openapi-generator

[Install openapi-generator](https://openapi-generator.tech/docs/installation) using your preferred method.

### ReDoc (optinal)

[Install ReDoc](https://github.com/Redocly/redoc) using your preferred method.

## Builing API clients

### Manually

`$ openapi-generator generate -i ./openapi.yaml -g ruby -o clients/ruby`

`-g` defines which generator to use, to list all generators execute `openapi-generator list`

`-o` is a output directory

### Build all supported languages

`$ make`


## Generate API documentation in HTML

Run `$ redoc-cli bundle ./openapi.yaml` and open `redoc-static.html` afterwards.

## Making changes

To make it easier to work with documentation run

`$ make watch`

and visit `localhost:8080` to see documentation.


## Specificaiton

[https://swagger.io/specification/#specification](https://swagger.io/specification/#specification)
[https://swagger.io/docs/specification/about/](https://swagger.io/docs/specification/about/)
