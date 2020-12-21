/**
 * I am a new Model Object
 */
component singleton accessors="true"{

	// Properties
	

	/**
	 * Constructor
	 */
	UserService function init(){
		
		return this;
	}

	/**
	 * getAll
	 */
	function getAll(){
		variables.data = queryExecute(
			"SELECT firstname,lastname,username,street1,street2,city,state,zip,primarybid from users limit 100"
		);  
		return variables.data;
	}

	/**
	 * getUser
	 */
	function getUser(userid){
		variables.data = queryExecute(
			"SELECT id,firstname,lastname,username,street1,street2,city,state,zip,primarybid from users where id = :userid",{userid: userid }
		);  

		return variables.data;
	}


}