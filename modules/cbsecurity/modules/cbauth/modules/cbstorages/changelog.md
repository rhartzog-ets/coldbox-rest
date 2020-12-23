# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

----

## [2.2.0]

### Added

* New module layouts and helpers
* Github auto release notes publishing
* More formatting goodness
* New Changelogs
* [BOX-77] Add CGI scope wrapper to cbStorages

----

## [2.1.0]

* `improvement` : Remove `numeric` typing on `expiry` for CookieStorage: The numeric typing on the expires argument will still allow a date object to pass through ( strangely ), but prevents the pass through of the textual arguments allowed by CFCookie: https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-c/cfcookie.html
* `improvement` : Added formatting and linting scripts
* `bug` : Fixed `toMaster` script so it could pull master incase of divergence

----

## [2.0.1]

* `bug` : [CCM-54](https://ortussolutions.atlassian.net/browse/CCM-54) - Left over bug on session storage looking at app storage

----

## [2.0.0]

* `feature` : All storages now implement a common interface : `IStorage`
* `feature` : New interface brings new storageWide methods: `setMulti(), getOrSet(), getMulti(), deleteMulti(), getSize(), getkeys(), isEmpty()`
* `feature,compat` : ColdBox 4/5 approach to settings instead of in the root, in the `moduleSettings`
* `improvement,compat` : All tag based default values where named `default` but renamed to `defaultValue` to have consistency.
* `improvement` : Dropped Lucee4.5 and ACF11 support
* `improvement` : Script migrations
* `feature` : Added support for httpOnly and secure cookies in the cookie storage.
* `improvement` : Added option to specify path when deleting a cookie. Without this option, the cookie is never deleted when specifying a path when creating a cookie. https://github.com/coldbox-modules/cbstorages/pull/7 (@donbellamy)
* `improvement` : TestBox 3 upgrade
* `improvement` : Mark all storages as `serializable=false` to avoid serialization issues
* `compat` : Removed `ClusterStorage` as this was a lucee only feature that actually never released.
* `compat` : The following methods have been renamed: `setVar() => set()`, `getVar() => get()`, and `deleteVar() => delete()`

----

## [1.5.0]

* Update new template approach
* Renamed repo
* Change `getSessionKey` to public method: https://github.com/coldbox-modules/cbox-storages/pull/6

----

## [1.4.0]

* Updated to leverage workbench module template
* Remove useless entry points thanks to @tropicalista
* Make default cache for `CacheStorage` to be the `template` cache instead of `default`

----

## [1.3.0]

* Updated API docs with a syntax typo
* New `RequestStorage` thanks to Dan Murphy
* Updated travis process for self-publishing

----

## [1.2.0]

* Update build process
* Updated dependencies
* Added new storage: `CacheStorage` to allow you to simulate session/client on a distributed cache via CacheBox.

----

## [1.1.0]

* Travis integration
* DocBox updates
* Build process updates

----

## [1.0.0]

* Create first module version
