# Mementifier : The State Maker!

Welcome to the `mementifier` module.  This module will transform your business objects into native ColdFusion (CFML) data structures with :rocket: speed.  It will inject itself into ORM objects and/or business objects alike and give them a nice `getMemento()` function to transform their properties and relationships (state) into a consumable structure or array of structures.  It can even detect ORM entities and you don't even have to write the default includes manually, it will auto-detect all properties.  No more building transformations by hand! No more inconsistencies! No more repeating yourself!

> Memento pattern is used to restore state of an object to a previous state or to produce the state of the object.

You can combine this module with `cffractal` (https://forgebox.io/view/cffractal) and build consistent and fast :rocket: object graph transformations.

## Module Settings

Just open your `config/Coldbox.cfc` and add the following settings into the `moduleSettings` struct under the `mementifier` key:

```js
// module settings - stored in modules.name.settings
moduleSettings = {
	mementifier = {
		// Turn on to use the ISO8601 date/time formatting on all processed date/time properites, else use the masks
		iso8601Format = false,
		// The default date mask to use for date properties
		dateMask      = "yyyy-MM-dd",
		// The default time mask to use for date properties
		timeMask      = "HH:mm:ss",
		// Enable orm auto default includes: If true and an object doesn't have any `memento` struct defined
		// this module will create it with all properties and relationships it can find for the target entity
		// leveraging the cborm module.
		ormAutoIncludes = true,
		// The default value for relationships/getters which return null
		nullDefaultValue = '',
        // Don't check for getters before invoking them
        trustedGetters = false
	}
}
```

## Usage

The memementifier will listen to WireBox object creations and ORM events in order to inject itself into target objects.  The target object must contain a `this.memento` structure in order for the `mementifier` to inject a `getMemento()` method into the target.  This method will allow you to transform the entity and its relationships into native struct/array/native formats.

### `this.memento` Marker

Each entity must be marked with a `this.memento` struct with the following (optional) available keys:

```js
this.memento = {
	// An array of the properties/relationships to include by default
	defaultIncludes = [],
	// An array of properties/relationships to exclude by default
	defaultExcludes = [],
	// An array of properties/relationships to NEVER include
	neverInclude = [],
	// A struct of defaults for properties/relationships if they are null
	defaults = {},
	// A struct of mapping functions for properties/relationships that can transform them
    mappers = {},
    // Don't check for getters before invoking them
    trustedGetters = $mementifierSettings.trustedGetters,
    // Enable orm auto default includes
    ormAutoIncludes = $mementifierSettings.ormAutoIncludes,
}
```

#### Default Includes

This array is a collection of the properties and/or relationships to add to the resulting memento of the object by default.  The `mementifier` will call the public `getter` method for the property to retrieve its value. If the returning value is `null` then the value will be an `empty` string.  If you are using CF ORM and the `ormAutoIncludes` setting is **true** (by default), then this array can be auto-populated for you, no need to list all the properties.

```js
defaultIncludes = [
	"firstName",
	"lastName",
	// Relationships
	"role.roleName",
	"role.roleID",
	"permissions",
	"children"
]
```

##### Automatic Include Properties

You can also create a single item of `[ "*" ]` which will tell the mementifier to introspect the object for all `properties` and use those instead for the default includes.

```java
defaultIncludes = [ "*" ]
```

> Also note the `ormAutoIncludes` setting, which if you are using a ColdFusion ORM object, we will automatically add all properties to the default includes.

##### Custom Includes

You can also define here properties that are NOT part of the object graph, but determined/constructed at runtime.  Let's say your `User` object needs to have an `avatarLink` in it's memento.  Then you can add a `avatarLink` to the array and create the appropriate `getAvatarLink()` method.  Then the `mementifier` will call your getter and add it to the resulting memento.

```js
defaultIncludes = [
	"firstName",
	"lastName",
	"avatarLink"
]

/**
* Get the avatar link for this user.
*/
string function getAvatarLink( numeric size=40 ){
	return variables.avatar.generateLink( getEmail(), arguments.size );
}
```

##### Nested Includes

The `DefaultIncldues` array can also include **nested** relationships.  So if a `User` has a `Role` relationship and you want to include only the `roleName` property, you can do `role.roleName`.  Every nesting is demarcated with a period (`.`) and you will navigate to the relationship.

```js
defaultIncludes = [
	"firstName",
	"lastName",
	"role.roleName",
	"role.roleID",
	"permissions"
]
```

Please note that all nested relationships will ONLY bring those properties from the relationship. Not the entire relationship.

#### Default Excludes

This array is a declaration of all properties/relationships to exclude from the memento state process.

```js
defaultExcludes = [
	"APIToken",
	"userID",
	"permissions"
]
```

##### Nested Excludes

The `DefaultExcludes` array can also declare **nested** relationships.  So if a `User` has a `Role` relationship and you want to exclude the `roleID` property, you can do `role.roleId`.  Every nesting is demarcated with a period (`.`) and you will navigate to the relationship and define what portions of the nested relationship can be excluded out.

```js
defaultExcludes = [
	"role.roleID",
	"permissions"
]
```

#### Never Include

This array is used as a last line of defense.  Even if the `getMemento()` call receives an include that is listed in this array, it will still not add it to the resulting memento.  This is great if you are using dynamic include and exclude lists.  **You can also use nested relationships here as well.**

```js
neverInclude = [
	"password"
]
```

#### Defaults

This structure will hold the default values to use for properties and/or relationships if at runtime they have a `null` value.  The `key` of the structure is the name of the property and/or relationship.  Please note that if you have a collection of relationships (array), the default value is an empty array by default.  This mostly applies if you want complete control of the default value.

```js
defaults = {
	"role" : {},
	"office" : {}
}
```

#### Mappers

This structure is a way to do transformations on actual properties and/or relationships after they have been added to the memento.  This can be post-processing functions that can be applied after retrieval. The `key` of the structure is the name of the property and/or relationship.  The `value` is a closure that receives the item and the rest of the memento and it must return back the item mapped according to your function.

```js
mappers = {
	"lname" = function( item, memento ){ return item.ucase(); },
	"specialDate" = function( item, memento ){ return dateTimeFormat( item, "full" ); }
}
```

You can use mappers to include a key not found in your memento, but rather one that combines values from other values.

```js
mappers = {
    "fullname" = function( _, memento ) { return memento.fname & " " & memento.lname; }
}
```

### `getMemento()` Method

Now that you have learned how to define what will be created in your memento, let's discover how to actually get the memento.  The injected method to the business objects has the following signaure:

```js
struct function getMemento(
	includes="",
	excludes="",
	struct mappers={},
	struct defaults={},
    boolean ignoreDefaults=false,
    boolean trustedGetters
)
```

> You can find the API Docs Here: https://apidocs.ortussolutions.com/coldbox-modules/mementifier/1.0.0/index.html

As you can see, the memento method has also a way to add dynamic `includes`, `excludes`, `mappers` and `defaults`.  This will allow you to add upon the defaults dynamically.

#### Ignoring Defaults

We have also added a way to ignore the default include and exclude lists via the `ignoreDefaults` flag.  If you turn that flag to `true` then **ONLY** the passed in `includes` and `excludes` will be used in the memento.  However, please note that the `neverInclude` array will **always** be used.

#### Trusted Getters

You can turn on trusted getters during call time by passing `true` to the `trustedGetters` argument.

#### Overriding `getMemento()`

You might be in a situation where you still want to add custom magic to your memento and you will want to override the injected `getMemento()` method.  No problem!  If you create your own `getMemento()` method, then the `mementifier` will inject the method as `$getMemento()`  so you can do your overrides:

```js
struct function getMemento(
	includes="",
	excludes="",
	struct mappers={},
	struct defaults={},
	boolean ignoreDefaults=false,
	boolean trustedGetters
){
	// Call mementifier
	var memento	= this.$getMemento( argumentCollection=arguments );

	// Add custom data
	if( hasEntryType() ){
		memento[ "typeSlug" ] = getEntryType().getTypeSlug();
		memento[ "typeName" ] = getEntryType().getTypeName();
	}

	return memento;
}
```

## Results Mapper

This feature was created to assist in support of the cffractal results map format.  It will process an array of objects and create a returning structure with the following specification:

* `results` - An array containing all the unique identifiers from the array of objects processed
* `resultsMap` - A struct keyed by the unique identifier containing the memento of each of those objects.

Example:

```js
// becomes
var data = {
    "results" = [
        "F29958B1-5A2B-4785-BE0A11297D0B5373",
        "42A6EB0A-1196-4A76-8B9BE67422A54B26"
    ],
    "resultsMap" = {
        "F29958B1-5A2B-4785-BE0A11297D0B5373" = {
            "id" = "F29958B1-5A2B-4785-BE0A11297D0B5373",
            "name" = "foo"
        },
        "42A6EB0A-1196-4A76-8B9BE67422A54B26" = {
            "id" = "42A6EB0A-1196-4A76-8B9BE67422A54B26",
            "name" = "bar"
        }
    }
};
```

Just inject the results mapper using this WireBox ID: `ResultsMapper@mementifier` and call the `process()` method with your collection, the unique identifier key name (defaults to `id`) and the other arguments that `getMemento()` can use. Here is the signature of the method:

```js
/**
 * Construct a memento representation using a results map. This process will iterate over the collection and create a
 * results array with all the identifiers and a struct keyed by identifier of the mememnto data.
 *
 * @collection The target collection
 * @id The identifier key, defaults to `id` for simplicity.
 * @includes The properties array or list to build the memento with alongside the default includes
 * @excludes The properties array or list to exclude from the memento alongside the default excludes
 * @mappers A struct of key-function pairs that will map properties to closures/lambadas to process the item value.  The closure will transform the item value.
 * @defaults A struct of key-value pairs that denotes the default values for properties if they are null, defaults for everything are a blank string.
 * @ignoreDefaults If set to true, default includes and excludes will be ignored and only the incoming `includes` and `excludes` list will be used.
 *
 * @return struct of { results = [], resultsMap = {} }
 */
function process(
	required array collection,
	id="id",
	includes="",
	excludes="",
	struct mappers={},
	struct defaults={},
    boolean ignoreDefaults=false,
    boolean trustedGetters
){}
```

## Running The Test Suites

In order to collaborate on this project you will need to do a few things in order to get the test harness ready for execution.  The `test-harness` folder is where the ColdBox test app exists that consumes the module for testing.  The `test-harness/tests/specs` is where all the specs for testing are located.

### Database

Create a database called `mementifier` in any RDBMS you like. We have mostly used MySQL for the tests.

### Environment

Copy the `.env.template` as `.env` and modify it accordingly so it can connect to your database.

### Dependencies

Go into the root of `test-harness` and run a CommandBox shell: `box`.  Once in the shell install the dependencies `install`.

### Start a Server

Start a server, we have configured for you several CFML engines for you to test against, pick one from the list below:

- `server start serverConfigFile=server-adobe@11.json`
- `server start serverConfigFile=server-adobe@2016.json`
- `server start serverConfigFile=server-adobe@2018.json`
- `server start serverConfigFile=server-lucee@5.json`

Then you can hit the test site app at http://localhost:60299.  This will create the database for you using the ColdFusion ORM.

### Running Tests

You can then run the tests at http://localhost:60299/tests/runner.cfm

********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.ortussolutions.com
********************************************************************************
#### HONOR GOES TO GOD ABOVE ALL
Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD
 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12