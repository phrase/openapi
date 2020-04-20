run:
	openapi-generator generate -i ./openapi.yaml -g ruby -o clients/ruby
	openapi-generator generate -i ./openapi.yaml -g go -o clients/go
