[![Build Status](https://travis-ci.org/coldbox-modules/relax.svg?branch=development)](https://travis-ci.org/coldbox-modules/relax)

# WELCOME TO COLDBOX RELAX

>RELAX = RESTFul Tools For Lazy Experts!

What is Relax? ColdBox Relax is a set of RESTFul tools for lazy experts. We pride ourselves in helping you (the developer) work smarter and 
ColdBox Relax is a tool to help you document your projects faster. ColdBox Relax provides you with the necessary tools to 
automagically model, document and test your RESTFul services. One can think of ColdBox Relax as a way to describe RESTFul web services, 
test RESTFul web services, monitor RESTFul web services and document RESTFul web services–all while you relax!

## LICENSE

Apache License, Version 2.0.

## IMPORTANT LINKS

- Code: https://github.com/coldbox/relax
- Issues: https://ortussolutions.atlassian.net/projects/RELAX/issues
- Documentation: https://relax.ortusbooks.com

## SYSTEM REQUIREMENTS

- Lucee 5+
- ColdFusion 2016+

## INSTRUCTIONS

Use CommandBox to install:

`box install relax`

## Settings

You will need to update the your `ColdBox.cfc` with a `relax` structure under the `moduleSettings` struct with your preferred settings for Relax.  
 
```js
moduleSettings = {
	relax = {
		// The location of the relaxed APIs, defaults to models.resources
		APILocation = "modules.relax.models.resources",
		// Default API to load, name of the directory inside of resources
		defaultAPI = "myapi",
		// APIs to be excluded from display - may be a list or an array and items may include Regex
		exclude         = "",
		// History stack size, the number of history items to retain in the Relaxer test tool
		maxHistory = 10
	}
};
```

## Modeling

You can look at the samples inside of this module under the `models/resources` directory.  To start you can copy the `Relax.cfc` into your own project folder and then start spicing up the API via the RelaxDSL methods.


********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD

 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12
