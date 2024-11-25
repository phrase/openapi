# Changelog

## [3.7.1](https://github.com/phrase/openapi/compare/go-v3.7.0...go-v3.7.1) (2024-11-20)


### Bug Fixes

* **API:** Comment creation schema fix #STRINGS-866 ([#718](https://github.com/phrase/openapi/issues/718)) ([e201d13](https://github.com/phrase/openapi/commit/e201d1360c89698dd8d3642cc28f89dd0e50a1fb))

## [3.7.0](https://github.com/phrase/openapi/compare/go-v3.6.0...go-v3.7.0) (2024-11-15)


### Features

* **API:** Add Pagination header to POST search endpoints [[#457](https://github.com/phrase/openapi/issues/457)] ([#706](https://github.com/phrase/openapi/issues/706)) ([9a79fa3](https://github.com/phrase/openapi/commit/9a79fa31bb3b9d58272fa2f4e82d72d0d44a93a0))
* **API:** autotranslate param in key creation [STRINGS-786] ([#713](https://github.com/phrase/openapi/issues/713)) ([581d0ff](https://github.com/phrase/openapi/commit/581d0ff5f1d06757e5ddd9603b78fc8d435d68ee))

## [3.6.0](https://github.com/phrase/openapi/compare/go-v3.5.0...go-v3.6.0) (2024-10-02)


### Features

* Add translation key prefixes for upload and download ([#687](https://github.com/phrase/openapi/issues/687)) ([9c9c959](https://github.com/phrase/openapi/commit/9c9c959830631bcac8beaf1de30ab31755ac1ee5))


### Bug Fixes

* **API:** Format list is not paginated and authenticated #STRINGS-458 ([#690](https://github.com/phrase/openapi/issues/690)) ([25e90f4](https://github.com/phrase/openapi/commit/25e90f46513e70cf328be80c36ae785cead05851))

## [3.5.0](https://github.com/phrase/openapi/compare/go-v3.4.1...go-v3.5.0) (2024-09-09)


### Features

* Add update_translations_on_source_match ([#670](https://github.com/phrase/openapi/issues/670)) ([11003ac](https://github.com/phrase/openapi/commit/11003ace7353bf99893482ca4aa32214abf3e581))

## [3.4.1](https://github.com/phrase/openapi/compare/go-v3.4.0...go-v3.4.1) (2024-07-30)


### Bug Fixes

* **go:** Fix query param serialization of nested objects [TSI-2594] ([#661](https://github.com/phrase/openapi/issues/661)) ([8400969](https://github.com/phrase/openapi/commit/8400969940fa49dbdbff770de6ba0d78e152c2e5))

## [3.4.0](https://github.com/phrase/openapi/compare/go-v3.3.0...go-v3.4.0) (2024-07-02)


### Features

* add repo sync events show endpoint ([#641](https://github.com/phrase/openapi/issues/641)) ([e1d9cfb](https://github.com/phrase/openapi/commit/e1d9cfb23e079fea2d9e5475dff9a4137f1f0154))

## [3.3.0](https://github.com/phrase/openapi/compare/go-v3.2.1...go-v3.3.0) (2024-06-25)


### Features

* **API:** Async downloads [TSI-2515] ([#642](https://github.com/phrase/openapi/issues/642)) ([6fcab5d](https://github.com/phrase/openapi/commit/6fcab5d4719f64e8e5dd49c327dc9348b384de4c))

## [3.2.1](https://github.com/phrase/openapi/compare/go-v3.2.0...go-v3.2.1) (2024-06-18)


### Bug Fixes

* add app_min_version and app_max_version param to releases ([#633](https://github.com/phrase/openapi/issues/633)) ([b384301](https://github.com/phrase/openapi/commit/b3843012460ace4c1d34c4373e5158595466adcb))

## [3.2.0](https://github.com/phrase/openapi/compare/go-v3.1.1...go-v3.2.0) (2024-06-12)


### Features

* **API:** Add OTA Release Triggers API [TSI-2485] ([#622](https://github.com/phrase/openapi/issues/622)) ([8cb91dc](https://github.com/phrase/openapi/commit/8cb91dcce2c19ca700cf9d0713fa74f28ad59434))

## [3.1.1](https://github.com/phrase/openapi/compare/go-v3.1.0...go-v3.1.1) (2024-05-31)


### Bug Fixes

* **CLI:** use id instead of repo_sync_id as param ([#618](https://github.com/phrase/openapi/issues/618)) ([7a1a0d9](https://github.com/phrase/openapi/commit/7a1a0d9115262dc7fa3065ee7cc76bec7a381ddb))
* **PHP:** Fix deserializing custom metadata values in key response ([#607](https://github.com/phrase/openapi/issues/607)) ([b6eeeba](https://github.com/phrase/openapi/commit/b6eeeba223e3eabec268a8f3d372afcb6abd09dd))

## [3.1.0](https://github.com/phrase/openapi/compare/go-v3.0.1...go-v3.1.0) (2024-04-29)


### Features

* **API:** Add 'update_translation_keys' for Uploads [TSI-2292] ([#578](https://github.com/phrase/openapi/issues/578)) ([4492ec0](https://github.com/phrase/openapi/commit/4492ec0a7c62f9de9ab1c1125071615bddcc26ce))

## [3.0.1](https://github.com/phrase/openapi/compare/go-v3.0.0...go-v3.0.1) (2024-04-23)


### Bug Fixes

* **go:** remove unused dependencies ([#598](https://github.com/phrase/openapi/issues/598)) ([413abb4](https://github.com/phrase/openapi/commit/413abb49253d063d116988a16d17b5dce005d967))

## [3.0.0](https://github.com/phrase/openapi/compare/go-v2.27.0...go-v3.0.0) (2024-04-23)


### ⚠ BREAKING CHANGES

* add missing required params ([#571](https://github.com/phrase/openapi/issues/571))

### Code Refactoring

* add missing required params ([#571](https://github.com/phrase/openapi/issues/571)) ([d810e9e](https://github.com/phrase/openapi/commit/d810e9ebc767e14ba9e56106de8c5774d9d6d178))

## [2.27.0](https://github.com/phrase/openapi/compare/go-v2.26.0...go-v2.27.0) (2024-04-22)


### Features

* Add linked-parent to translation details ([#570](https://github.com/phrase/openapi/issues/570)) ([2c6f432](https://github.com/phrase/openapi/commit/2c6f43253e24b670b71ac810c85dce0759c29403))

## [2.26.0](https://github.com/phrase/openapi/compare/go-v2.25.1...go-v2.26.0) (2024-04-17)


### Features

* **API:** Add Repo Sync [TSI-1923] ([#569](https://github.com/phrase/openapi/issues/569)) ([0bd1756](https://github.com/phrase/openapi/commit/0bd17562018cb045ff41cc1ff5008b9419a0ed12))

## [2.25.1](https://github.com/phrase/openapi/compare/go-v2.25.0...go-v2.25.1) (2024-04-04)


### Bug Fixes

* (API) Add mandatory params to linked keys endpoints ([#564](https://github.com/phrase/openapi/issues/564)) ([08d9846](https://github.com/phrase/openapi/commit/08d9846bc224d349e2ade9abf28d733afb1e8be3))

## [2.25.0](https://github.com/phrase/openapi/compare/go-v2.24.0...go-v2.25.0) (2024-04-02)


### Features

* **API:** add Linked Keys endpoints ([#555](https://github.com/phrase/openapi/issues/555)) ([4935dac](https://github.com/phrase/openapi/commit/4935dac58c787eaade2f1f65ce649f466b5e3a60))

## [2.24.0](https://github.com/phrase/openapi/compare/go-v2.23.2...go-v2.24.0) (2024-02-07)


### Features

* add query param for properties ([#542](https://github.com/phrase/openapi/issues/542)) ([b4e12d0](https://github.com/phrase/openapi/commit/b4e12d04fd2916351f9201e1e6de504143ecc9aa))

## [2.23.2](https://github.com/phrase/openapi/compare/go-v2.23.1...go-v2.23.2) (2024-02-05)


### Bug Fixes

* **API:** allow nullable value for job's due_date ([#534](https://github.com/phrase/openapi/issues/534)) ([38b51b5](https://github.com/phrase/openapi/commit/38b51b51095394f8ce769873140038abba628514))

## [2.23.1](https://github.com/phrase/openapi/compare/go-v2.23.0...go-v2.23.1) (2024-02-01)


### Bug Fixes

* **API:** Adjust documentation of QPS endpoint ([#525](https://github.com/phrase/openapi/issues/525)) ([4b4f1ac](https://github.com/phrase/openapi/commit/4b4f1acf28fbd13b3d16c37162cdccfa05c38ffa))

## [2.23.0](https://github.com/phrase/openapi/compare/go-v2.22.1...go-v2.23.0) (2024-01-17)


### Features

* **api:** Add QPS endpoint and documentation ([#521](https://github.com/phrase/openapi/issues/521)) ([d22c558](https://github.com/phrase/openapi/commit/d22c558adfbb7fcd13759e388c038744914e42fa))

## [2.22.1](https://github.com/phrase/openapi/compare/go-v2.22.0...go-v2.22.1) (2024-01-02)


### Bug Fixes

* **CLI:** retrigger release for GO ([fca7edb](https://github.com/phrase/openapi/commit/fca7edb2bfecaeb2ed92c5f50acb8d820ef94cb0))
* **GO:** fix type mismatch error ([fca7edb](https://github.com/phrase/openapi/commit/fca7edb2bfecaeb2ed92c5f50acb8d820ef94cb0))
* **GO:** fix type mismatch for nested args ([#515](https://github.com/phrase/openapi/issues/515)) ([fca7edb](https://github.com/phrase/openapi/commit/fca7edb2bfecaeb2ed92c5f50acb8d820ef94cb0))

## [2.22.0](https://github.com/phrase/openapi/compare/go-v2.21.1...go-v2.22.0) (2024-01-02)


### Features

* **GO:** retrigger release for GO ([4fcf237](https://github.com/phrase/openapi/commit/4fcf237a4583190863b2b33b9710ef8a1540e1fd))
* Retrigger release for CLI & GO ([#505](https://github.com/phrase/openapi/issues/505)) ([4fcf237](https://github.com/phrase/openapi/commit/4fcf237a4583190863b2b33b9710ef8a1540e1fd))


### Bug Fixes

* **API:** Create Custom Metadata endpoint fix [TSI-2222] ([#499](https://github.com/phrase/openapi/issues/499)) ([ce2ed94](https://github.com/phrase/openapi/commit/ce2ed9488e111fb5d9bc3810a78c47d23553c8b7))
* **CLI:** retrigger release for CLI ([4fcf237](https://github.com/phrase/openapi/commit/4fcf237a4583190863b2b33b9710ef8a1540e1fd))
* **GO,CLI:** Reverts retrigger Go & CLI release ([d6574c1](https://github.com/phrase/openapi/commit/d6574c12e0fa93596935706a6b4a2aaa3c7691ef))

## [2.21.1](https://github.com/phrase/openapi/compare/go-v2.21.0...go-v2.21.1) (2023-12-20)


### Bug Fixes

* **GO:** Fix format_option serialization when creating upload ([#498](https://github.com/phrase/openapi/issues/498)) ([7c04f1e](https://github.com/phrase/openapi/commit/7c04f1e1f9fd280f56e15520626166ab3b5b6db5))

## [2.21.0](https://github.com/phrase/openapi/compare/go-v2.20.0...go-v2.21.0) (2023-12-13)


### Features

* **API:** add Custom Metadata endpoints ([#474](https://github.com/phrase/openapi/issues/474)) ([d407d8b](https://github.com/phrase/openapi/commit/d407d8be5ccddec1afde14a12804a7a616f77d7a))

## [2.20.0](https://github.com/phrase/openapi/compare/go-v2.19.0...go-v2.20.0) (2023-12-13)


### Features

* **API:** Add custom_metadata_filters param to locale download endpoint [TSI-2174] ([#478](https://github.com/phrase/openapi/issues/478)) ([3623478](https://github.com/phrase/openapi/commit/3623478fc1518b457ab018b5630a693081637d6e))
* **API:** Add url field to uploads ([#481](https://github.com/phrase/openapi/issues/481)) ([7332a84](https://github.com/phrase/openapi/commit/7332a84f9958346f2fb28dee4b0353519ef466d5))

## [2.19.0](https://github.com/phrase/openapi/compare/go-v2.18.0...go-v2.19.0) (2023-11-28)


### Features

* Add reports locales endpoint to API [TSS-2439] ([#465](https://github.com/phrase/openapi/issues/465)) ([e03aa9f](https://github.com/phrase/openapi/commit/e03aa9f49f031517b36db715fe70e8e0b65a438b))

## [2.18.0](https://github.com/phrase/openapi/compare/go-v2.17.0...go-v2.18.0) (2023-11-03)


### Features

* [TSI-2083] enable format_options argument for java-client   ([#426](https://github.com/phrase/openapi/issues/426)) ([faa8cb3](https://github.com/phrase/openapi/commit/faa8cb353ba9f1030b9f7cfd46b894b4d6d26e70))

## [2.17.0](https://github.com/phrase/openapi/compare/go-v2.16.0...go-v2.17.0) (2023-10-30)


### Features

* Update openapi-generator to v7 ([#418](https://github.com/phrase/openapi/issues/418)) ([524626f](https://github.com/phrase/openapi/commit/524626f5e914bfef6025d0e1c2cbc7a728d08f56))

## [2.16.0](https://github.com/phrase/openapi/compare/go-v2.15.0...go-v2.16.0) (2023-10-23)


### Features

* **API:** Add order param to comment list endpoints ([#441](https://github.com/phrase/openapi/issues/441)) ([441c9c4](https://github.com/phrase/openapi/commit/441c9c46169f8c5ac4e71ade09a95dab136314ef))

## [2.15.0](https://github.com/phrase/openapi/compare/go-v2.14.0...go-v2.15.0) (2023-10-13)


### Features

* **API:** Implement figma attachments endpoints ([#415](https://github.com/phrase/openapi/issues/415)) ([970e612](https://github.com/phrase/openapi/commit/970e612fda620ca882a221ef541036b8d200b675))

## [2.14.0](https://github.com/phrase/openapi/compare/go-v2.13.0...go-v2.14.0) (2023-09-12)


### Features

* Optionally tag only affected keys on upload [TSI-2041] ([#412](https://github.com/phrase/openapi/issues/412)) ([e8f958e](https://github.com/phrase/openapi/commit/e8f958e91469c2542f44ab68469c933688958383))
* **TSI-1946:** Add reviewed_at to translations ([#396](https://github.com/phrase/openapi/issues/396)) ([3e663d9](https://github.com/phrase/openapi/commit/3e663d971a99a816f0165dd6653a9a1e8a87c95e))

## [2.13.0](https://github.com/phrase/openapi/compare/go-v2.12.0...go-v2.13.0) (2023-08-28)


### Features

* **API:** Document new query parameters ([#393](https://github.com/phrase/openapi/issues/393)) ([770515a](https://github.com/phrase/openapi/commit/770515a9628122955bb3919405babf9392684eb9))


### Bug Fixes

* **go:** Update goreleaser config ([#394](https://github.com/phrase/openapi/issues/394)) ([580c1ed](https://github.com/phrase/openapi/commit/580c1ed00304e5ea0dd87a3131499cbd26c095bd))

## [2.12.0](https://github.com/phrase/openapi/compare/go-v2.11.0...go-v2.12.0) (2023-08-24)


### Features

* **API:** Introduce comment replies endpoints ([#383](https://github.com/phrase/openapi/issues/383)) ([71351ac](https://github.com/phrase/openapi/commit/71351ac285f4f49976092e176c77b09f3485eb65))

## [2.11.0](https://github.com/phrase/openapi/compare/go-v2.10.3...go-v2.11.0) (2023-08-22)


### Features

* **TSE-950:** Document comment_reactions endpoints ([#380](https://github.com/phrase/openapi/issues/380)) ([f230244](https://github.com/phrase/openapi/commit/f230244e6e9c069b18edc4c35dd5e290fd14793b))

## [2.10.3](https://github.com/phrase/openapi/compare/go-v2.10.2...go-v2.10.3) (2023-07-31)


### Bug Fixes

* **schemas:** Fix gitlab_sync type mismatch ([#373](https://github.com/phrase/openapi/issues/373)) ([1cb1f65](https://github.com/phrase/openapi/commit/1cb1f650598c68afee6e2cd7c3c4ede1484aba35))

## [2.10.2](https://github.com/phrase/openapi/compare/go-v2.10.1...go-v2.10.2) (2023-07-28)


### Bug Fixes

* Fix gitlab_sync history status type mismatch ([#363](https://github.com/phrase/openapi/issues/363)) ([ebcaa4e](https://github.com/phrase/openapi/commit/ebcaa4e5dfcb2f73559a56c78b0f2512ca798375))
