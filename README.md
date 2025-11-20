# OpenAPI specification for Phrase Strings

## Commands

* `npm install` installs the dependencies
* `npm start` builds API clients
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

1. Add newly added schema (if any) to `/schemas/` directory and to `schemas.yaml`
2. Add new endpoints to `/paths/` directory and reference it in `paths.yaml`
3. `npm start` to re-build the clients
4. Open a PR with an informative title (e.g. `feat(API): Add an API endpoint for cat pics`)
5. Merge automated documentation PR [(details)](#documentation-sync)

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

```mermaid
@startuml "openapi workflow"
skinparam backgroundColor #fefefe

collections "* API changes\n* bug fixes" as changes #PaleGreen
folder "phrase/openapi" as openapi #AliceBlue
control "build" as actions

artifact docs
frame "https://developers.phrase.com/" as developers

folder "phrase/phrase-go" as go #AliceBlue
folder "phrase/phrase-cli" as cli #AliceBlue
folder "phrase/phrase-php" as php #AliceBlue
folder "phrase/phrase-java" as java #AliceBlue
folder "phrase/phrase-python" as python #AliceBlue
folder "phrase/phrase-ruby" as ruby #AliceBlue
folder "phrase/phrase-js" as js #AliceBlue


control "build" as go_actions
control "build" as build_cli
control "build" as build_java
control "build" as build_js
control "build" as build_ruby
control "build" as build_python

artifact go_library
artifact "Docker CLI images" as docker_images
folder homebrew
collections "Github package registry" as github_package_registry
artifact "registry.npmjs.org" as npm
artifact "PyPI"

changes --> openapi : push
openapi --> actions
actions --> docs
docs --> developers : publish
actions --> go : push
actions --> php : push
actions --> java : push
actions --> python : push
actions --> cli : push
actions --> ruby : push
actions --> js : push

go --> go_actions
go_actions --> go_library : publish

cli --> build_cli
build_cli ..> go_library : use
build_cli --> homebrew : bump formula
build_cli --> docker_images : push
build_cli ..> cli : upload to release

java --> build_java
build_java ..> java : upload to release
build_java --> github_package_registry : publish

python --> build_python
build_python ..> python : upload to release
build_python --> PyPI : publish

js --> build_js
build_js --> npm : publish

ruby --> build_ruby
build_ruby --> github_package_registry : publish
build_ruby ..> ruby : release gem

@enduml
```

## Documentation Sync

Changes pushed to the main branch automatically trigger an internal workflow that updates the API documentation based on the latest OpenAPI schema.

This includes:

1. Pulling the most recent schema from this repository,
2. Regenerating the documentation site,
3. Deploying the updated docs.

The last step in bringing your changes live is to merge in the automatically generated PR to `developer-hub`. This requires `write` permissions, so look to see who has merged previous PRs for who to ping to get something merged.

This setup ensures that the public API documentation always reflects the current OpenAPI spec.

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
