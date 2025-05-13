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

### PR titles

PR titles are important, as they are used to generate changelogs and version bumps for the generated client libraries. The format is `change_type(affected_library): description #STRINGS-TICKET`.

The `change_type` is one of the following:
* `feat`: A new feature. Also applies to extending the schema with new endpoints, properties, query parameters. For every schema change, a new version of every client library needs to be generated.
* `fix`: A bug fix. Also applies to fixing the schema (e.g. fixing a typo in a property name).
* `docs`: Documentation only changes. This includes changes to the OpenAPI spec (e.g. field descriptions), but not to the schema itself. This does not require a new version of the client libraries.
* `build`: Changes that affect the build system or external dependencies (example: a change in github actions).

`affected_library` could be for example `PHP`, `Java`, `Go`, `Python`, `Ruby`, `CLI`, or `JS`, but most commonly it's `API`, in case of any schema changes.

### Example

You added an endpoint in Phrase Strings. In this project you do the following:

1. Add newly added schema (if any) to `/schemas/` directory
2. Add new endpoints to `/paths/` directory and reference it in `paths.yaml`
3. `npm start` to re-build the clients
4. `npm run docs` to generate the documentation (and verify it in action using `npm run watch`)
5. Open a PR with an informative title (e.g. `feat(API): Add an API endpoint for cat pics`)

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

### Defining parameters

`POST`/`PUT` requests should define parameters within `requestBody` section, like the following:

```yaml
requestBody:
  required: true
  content:
    application/json:
      schema:
        type: object
        title: key/create/parameters
        properties:
          branch:
            description: specify the branch to use
            type: string
            example: my-feature-branch
          name:
            description: Key name
            type: string
            example: home.index.headline
```

`parameters` section should contain only those parameters which are part of the URL (typically `project_id` and/or `account_id`)

## Get help / support

Please contact [support@phrase.com](mailto:support@phrase.com?subject=[GitHub]%20openapi) and we can take more direct action toward finding a solution.
