run:
	make lint
	make bundle
	make ruby
	make go
	make typescript
	make python
	make java
	make php
	make cli
	@echo Client libraries generated, check clients directory.
lint:
	npx swagger-cli validate main.yaml
	# make bundle
	# npx openapi-generator-cli validate -i tmp/compiled.yaml
bundle:
	npx swagger-cli bundle -t yaml -w 300 main.yaml > tmp/compiled.yaml
watch_bundle:
	make lint
	npx swagger-cli bundle -t json -w 300 main.yaml > doc/compiled.json
watch_scss:
	npx sass --watch ./doc/main.scss:./doc/main.css ./doc/rapidoc.scss:./doc/rapidoc.css
watch_ts:
	npx tsc --watch ./doc/main.ts --outFile ./doc/main.js
serve:
	.npx http-server doc
docs: lint bundle
	npx sass -s compressed ./doc/main.scss:./doc/main.css ./doc/rapidoc.scss:./doc/rapidoc.css
	npx tsc ./doc/main.ts --outFile ./doc/main.js
	npx terser ./doc/main.js --compress --mangle -o ./doc/main.js
ruby:
	openapi-generator-cli generate -i tmp/compiled.yaml -g ruby -o clients/ruby -t ./openapi-generator/templates/ruby-client -c ./openapi-generator/ruby_lang.yaml
go:
	openapi-generator-cli generate -i tmp/compiled.yaml -g go -o clients/go -t ./openapi-generator/templates/go -c ./openapi-generator/go_lang.yaml
	go install golang.org/x/tools/cmd/goimports@latest
	goimports -w clients/go
	cd clients/go && go mod tidy
typescript:
	openapi-generator-cli generate -i tmp/compiled.yaml -g typescript-fetch -o clients/typescript -t ./openapi-generator/templates/typescript-fetch -c ./openapi-generator/typescript_lang.yaml
python:
	openapi-generator-cli generate -i tmp/compiled.yaml -g python -o clients/python -t ./openapi-generator/templates/python -c ./openapi-generator/python_lang.yaml
java:
	openapi-generator-cli generate -i tmp/compiled.yaml -g java -o clients/java -t ./openapi-generator/templates/java -c ./openapi-generator/java_lang.yaml
php:
	openapi-generator-cli generate -i tmp/compiled.yaml -g php -o clients/php -t ./openapi-generator/templates/php -c ./openapi-generator/php_lang.yaml
cli:
	openapi-generator-cli generate -i tmp/compiled.yaml -g go -o tmp/cli -t ./openapi-generator/templates/cli -c ./openapi-generator/cli_lang.yaml -e handlebars
	cp tmp/cli/api_* clients/cli/cmd/
	cp tmp/cli/README.md clients/cli/
	go install golang.org/x/tools/cmd/goimports@latest
	goimports -w clients/cli
	cd clients/cli && go mod tidy
