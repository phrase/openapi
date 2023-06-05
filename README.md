# OpenAPI specification for Phrase

## Commands

* `npm install` installs the dependencies
* `npm start` builds API clients
* `npm run docs` generates API documentation in HTML
* `npm run watch` starts a local server which you can reach at http://localhost:8080
* `npm run lint` lints your changes

## Contribution

This project relies on [conventional commits](https://www.conventionalcommits.org) used by [release-please](https://github.com/googleapis/release-please) to generate proper changelogs and increment versions of the generated client libraries affected by the PR. Please use [appropriate prefixes](https://kapeli.com/cheat_sheets/Conventional_Commits.docset/Contents/Resources/Documents/index) when giving titles to your PRs as they decide whether there will be a version bump and changelog entry.

These changelogs and version bumps are generated as a separate pull requests (one for each client library) and currently need to be merged manually.

## Workflow

The following repositories are generated upon pushing to this one:

https://github.com/phrase/phrase-go

https://github.com/phrase/phrase-java

https://github.com/phrase/phrase-js

https://github.com/phrase/phrase-php

https://github.com/phrase/phrase-python

https://github.com/phrase/phrase-ruby

https://github.com/phrase/phrase-cli

### Deployment diagram

![Deployment diagram](docs/openapi%20workflow.svg)

## Specification

[http://spec.openapis.org/oas/v3.0.3](http://spec.openapis.org/oas/v3.0.3)

[https://swagger.io/specification/#specification](https://swagger.io/specification/#specification)

[https://swagger.io/docs/specification/about/](https://swagger.io/docs/specification/about/)

## Get help / support

Please contact [support@phrase.com](mailto:support@phrase.com?subject=[GitHub]%20openapi) and we can take more direct action toward finding a solution.
