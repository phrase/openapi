run:
	openapi-generator generate -i ./openapi.yaml -g ruby -o clients/ruby
	@echo ---
	openapi-generator generate -i ./openapi.yaml -g go -o clients/go
	@echo ---
	@echo Clients library genrated, check clients directory.

generate:
	redoc-cli bundle ./openapi.yaml
	@echo ---
	@echo Docuemntation generated, open redoc-static.html

watch:
	redoc-cli serve ./openapi.yaml --watch
