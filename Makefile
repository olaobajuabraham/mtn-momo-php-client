openapi-generator-version:=7.9.0
openapi-generator-url:=https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/$(openapi-generator-version)/openapi-generator-cli-$(openapi-generator-version).jar
openapi-generator-jar:=bin/tools/openapi-generator-cli.jar
openapi-generator-cli:=java -jar $(openapi-generator-jar)

services:= collection disbursement

generator:=php
output:=client

# Generate Client via openapi-generator
client: $(openapi-generator-jar)
	./bin/build/client

# Download the generator
$(openapi-generator-jar):
	wget --quiet -o /dev/null $(openapi-generator-url) -O $(openapi-generator-jar)

# Extract templates (copy them for modifications)
templates: $(openapi-generator-jar)
	$(openapi-generator-cli) author template -g $(generator) -o target/templates

clean: 
	rm -rf dist/

zip:
	zip -r pkg.zip ./dist/ -x "git_push.sh"

zip-ls:
	unzip -la pkg.zip >> codebase.txt