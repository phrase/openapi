run:
	swagger-cli validate openapi.yaml
	@echo ---
	swagger-cli bundle openapi.yaml > tmp/compiled.yaml
	openapi-generator generate -i ./tmp/compiled.yaml -g ruby -o clients/ruby
	@echo ---
	openapi-generator generate -i ./tmp/compiled.yaml -g go -o clients/go
	@echo ---
	@echo Clients library genrated, check clients directory.

doc:
	redoc-cli bundle ./openapi.yaml
	@echo ---
	@echo Docuemntation generated, open redoc-static.html

watch:
	redoc-cli serve ./openapi.yaml --watch

lint:
	swagger-cli validate openapi.yaml
