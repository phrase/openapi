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
watch_bundle:
	make lint
	swagger-cli bundle -t json -w 300 main.yaml > doc/compiled.json
watch_scss:
	./node_modules/.bin/sass --watch ./doc/main.scss:./doc/main.css ./doc/rapidoc.scss:./doc/rapidoc.css
watch_ts:
	./node_modules/.bin/tsc --watch ./doc/main.ts --outFile ./doc/main.js
serve:
	./node_modules/.bin/http-server doc
docs:
	make lint
	swagger-cli bundle -t json -w 300 main.yaml > doc/compiled.json
	./node_modules/.bin/sass -s compressed ./doc/main.scss:./doc/main.css ./doc/rapidoc.scss:./doc/rapidoc.css
	./node_modules/.bin/tsc ./doc/main.ts --outFile ./doc/main.js
	./node_modules/.bin/terser ./doc/main.js --compress --mangle -o ./doc/main.js
ruby:
	openapi-generator generate -i tmp/compiled.yaml -g ruby -o clients/ruby -t ./openapi-generator/templates/ruby-client -c ./openapi-generator/ruby_lang.yaml
go:
	openapi-generator generate -i tmp/compiled.yaml -g go -o clients/go -t ./openapi-generator/templates/go -c ./openapi-generator/go_lang.yaml
	go get golang.org/x/tools/cmd/goimports
	goimports -w clients/go
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
	go get golang.org/x/tools/cmd/goimports
	goimports -w clients/cli
