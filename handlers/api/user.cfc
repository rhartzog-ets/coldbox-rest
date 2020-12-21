/**
 * I am a new handler
 */
component{

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only 	= "";
	this.prehandler_except 	= "";
	this.posthandler_only 	= "";
	this.posthandler_except = "";
	this.aroundHandler_only = "";
	this.aroundHandler_except = "";
	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	IMPLICIT FUNCTIONS: Uncomment to use

	function preHandler( event, rc, prc, action, eventArguments ){
	}
	function postHandler( event, rc, prc, action, eventArguments ){
	}
	function aroundHandler( event, rc, prc, targetAction, eventArguments ){
		// executed targeted action
		arguments.targetAction( event );
	}
	function onMissingAction( event, rc, prc, missingAction, eventArguments ){
	}
	function onError( event, rc, prc, faultAction, exception, eventArguments ){
	}
	function onInvalidHTTPMethod( event, rc, prc, faultAction, eventArguments ){
	}
	*/



	property name="userService" inject="UserService";

	/**
	 * indexß
	 */
	function index( event, rc, prc ){
		prc.qUsers = userService.getAll();
		event.getResponse().setData(prc.qUsers);
	}

	/**
	 * view
	 */
	function view( event, rc, prc ){
		var qUser = userService.getUser( rc.userID );
		if( qUser.recordCount ) {
			event.renderData( type="JSON", data=qUser );
		} else {
			event.renderData( type="JSON", data={}, statusCode=404, statusMessage="User not found");
		}
	}

	/**
	 * save
	 */
	function save( event, rc, prc ){
		event.setView( "api/user/save" );
	}

	/**
	 * remove
	 */
	function remove( event, rc, prc ){
		event.setView( "api/user/remove" );
	}

}
