run:
	make lint
	make bundle
	make ruby
	make go
	make typescript
	make python
	make swift
	make java
	make kotlin
	make php
	make csharp
	make cli
	@echo Clients library genrated, check clients directory.
lint:
	swagger-cli validate main.yaml
bundle:
	swagger-cli bundle -t yaml -w 300 main.yaml > tmp/compiled.yaml
watch: watch_sass watch_docs
watch_sass:
	sass --watch ./doc/main.scss ./doc/main.css
watch_docs:
	redoc-cli serve ./main.yaml --watch --options.noAutoAuth --options.expandSingleSchemaField --options.suppressWarnings -t doc/template.hbs -ssr --templateOptions.basePath ./doc
docs:
	sass -s compressed ./doc/main.scss ./doc/main.css
	redoc-cli bundle -t doc/template.hbs -o doc/index.html ./main.yaml --options.noAutoAuth --options.expandSingleSchemaField --options.suppressWarnings --templateOptions.basePath . --options.theme.colors.primary.main "#242424" --options.theme.colors.text.primary "#333" --options.theme.typography.fontFamily "Source Sans Pro,sans-serif" --options.theme.typography.fontSize "18px" --options.theme.typography.lineHeight "1.5" --options.theme.typography.fontWeightRegular "300" --options.theme.typography.headings.fontFamily "Source Sans Pro,sans-serif" --options.theme.typography.headings.lineHeight "1.3" --options.theme.typography.code.fontFamily "Menlo,monospace" --options.theme.typography.code.fontWeight "400"  --options.theme.logo.maxHeight 50px --options.theme.logo.maxWidth 134px --options.theme.logo.gutter "14px 14px 8px" --options.theme.rightPanel.backgroundColor '#242424' --options.theme.sidebar.backgroundColor "#FBFBFB" --options.theme.sidebar.textColor "#7C7C7C" --options.theme.sidebar.groupItems.textTransform "none" --options.theme.http.get "#51E05D" --options.theme.http.post "#0091EB" --options.theme.http.patch "#FFBB00" --options.theme.http.delete "#F44336"
ruby:
	openapi-generator generate -i tmp/compiled.yaml -g ruby -o clients/ruby -t ./openapi-generator/templates/ruby-client -c ./openapi-generator/ruby_lang.yaml
go:
	openapi-generator generate -i tmp/compiled.yaml -g go -o clients/go -t ./openapi-generator/templates/go -c ./openapi-generator/go_lang.yaml
typescript:
	openapi-generator generate -i tmp/compiled.yaml -g typescript-fetch -o clients/typescript -t ./openapi-generator/templates/typescript-fetch -c ./openapi-generator/typescript_lang.yaml
python:
	openapi-generator generate -i tmp/compiled.yaml -g python -o clients/python -t ./openapi-generator/templates/python -c ./openapi-generator/python_lang.yaml
swift:
	openapi-generator generate -i tmp/compiled.yaml -g swift5 -o clients/swift -c ./openapi-generator/swift5_lang.yaml
java:
	openapi-generator generate -i tmp/compiled.yaml -g java -o clients/java -t ./openapi-generator/templates/java -c ./openapi-generator/java_lang.yaml
kotlin:
	openapi-generator generate -i tmp/compiled.yaml -g kotlin -o clients/kotlin -t ./openapi-generator/templates/kotlin-client -c ./openapi-generator/kotlin_lang.yaml
php:
	openapi-generator generate -i tmp/compiled.yaml -g php -o clients/php -t ./openapi-generator/templates/php -c ./openapi-generator/php_lang.yaml
csharp:
	openapi-generator generate -i tmp/compiled.yaml -g csharp -o clients/csharp -c ./openapi-generator/csharp_lang.yaml
cli:
	openapi-generator generate -i tmp/compiled.yaml -g go -o tmp/cli -t ./openapi-generator/templates/cli -c ./openapi-generator/cli_lang.yaml -e handlebars
	cp tmp/cli/api_* clients/cli/cmd/
	cp tmp/cli/README.md clients/cli/
