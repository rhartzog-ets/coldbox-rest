# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

----

## [2.2.1] => 2020-NOV-06

### Fixed

* Reverted missing `nestedIncludes.len()` for ignore defaults on nested hierarchies.
 
----

## [2.2.0] => 2020-NOV-05

### Added

* Allow defaults to be `null` thanks to @elpete
* Updated changelog to new keepachangelog.com standards
* Added new release recipe according to new module template
* Added new formating rules
* Added github auto publishing on releases

----

## [2.1.0] => 2020-MAR-10

* `Feature` : Enabled mappers to be called after memento was finalized in order to allow you to build composite properties and non-existent properties on the memento
* `Feature` : New setting `trustedGetters` to allow you to leverage virtual `getters()` especially on frameworks like Quick. This setting can also be used in the `getMemento()` calls directly or setup in an entity definition.

----

## [2.0.0] => 2020-JAN-22

### Features

* Enabled wildcard default includes (*) to retrieve inherited object properties instead of doing wacky things for inherited defaults to work.
* New setting to chose a default value to expose when getters return `null`: `nullDefaultValue`
* ORM Auto includes now ONLY includes properties to avoid bi-directional recursive exceptions.  This is also a compatiblity, where before EVERYTHING was included.  Now, only properties are included.

### Improvements

* Updated to cborm2 for testing harness
* Updated to TestBox 3

### Compatibility

* Removed ACF 11 Support
* ORM Auto includes only marshalls properties instead of everything.

----

## [1.9.0]

* More Adobe ColdFusion incompatibilities

----

## [1.8.0]

* Added the `ResultsMapper` model which will create results map a-la cffractal.  Just inject and call via the `process()` method.

----

## [1.7.1]

* ACF11 Compats

----

## [1.7.0]

* Allow for `defaultIncludes = [ "*" ]` to introspect the properties of the object automatically instead of writing all properties manually.

----

## [1.6.0]

* Allow for arrays of complex objects that don't have mementos
* ACF11 Incompats due to member functions

----

## [1.5.0]

* Only process memento based objects from WireBox.

----

## [1.4.1]

* Wrong date formatting pattern for Java SimpleDateFormat

----

## [1.4.0]

* New setting: `ormAutoIncludes` which defaults to `true`.  If enabled, and an ORM entity does not have any includes defined, we will automatically include all ORM properties including relationships.

----

## [1.3.0]

* ACF Incompatibilities
* Ensure result item

----

## [1.1.1]

* Fixes on non-existent properties

----

## [1.1.0]

* Major performance boosts
* Lucee issues with degradation over time

----

## [1.0.1]

* Fix on WireBox target detection

----

## [1.0.0]

* First iteration of this module