run:
	make lint
	make bundle
	make ruby
	make go
	make cli
	@echo Clients library genrated, check clients directory.
lint:
	swagger-cli validate main.yaml
bundle:
	swagger-cli bundle -t yaml -w 300 main.yaml > tmp/compiled.yaml
watch:
	redoc-cli serve ./main.yaml --watch --options.noAutoAuth --options.expandSingleSchemaField --options.suppressWarnings
docs:
	redoc-cli bundle -o doc/index.html ./main.yaml --options.noAutoAuth --options.expandSingleSchemaField --options.suppressWarnings
ruby:
	openapi-generator generate -i tmp/compiled.yaml -g ruby -o clients/ruby -t ./openapi-generator/templates/ruby-client -c ./openapi-generator/ruby_lang.yaml
go:
	openapi-generator generate -i tmp/compiled.yaml -g go -o clients/go -t ./openapi-generator/templates/go -c ./openapi-generator/go_lang.yaml
typescript:
	openapi-generator generate -i tmp/compiled.yaml -g typescript-fetch -o clients/typescript -t ./openapi-generator/templates/typescript-fetch -c ./openapi-generator/typescript_lang.yaml
python:
	openapi-generator generate -i tmp/compiled.yaml -g python -o clients/python -t ./openapi-generator/templates/python -c ./openapi-generator/python_lang.yaml
swift:
	openapi-generator generate -i tmp/compiled.yaml -g swift4 -o clients/swift -c ./openapi-generator/swift4_lang.yaml
cli:
	openapi-generator generate -i tmp/compiled.yaml -g go -o tmp/cli -t ./openapi-generator/templates/cli -c ./openapi-generator/cli_lang.yaml
	cp tmp/cli/api_* clients/cli/cmd/
	cp tmp/cli/README.md clients/cli/
