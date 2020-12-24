﻿// Declare our variablesvar baseURL:String = "http://localhost/drupal6";var gateway:String = baseURL + "/services/amfphp"var sessionId:String = "";var nodeId:Number = root.loaderInfo.parameters.node;// Declare our Drupal connectionvar drupal:NetConnection = new NetConnection();drupal.objectEncoding = ObjectEncoding.AMF3;// Connect to the Drupal gatewaydrupal.connect( gateway );// Set up our responder with the callbacks.var responder:Responder = new Responder( onConnect, onError);// Connect to Drupaldrupal.call("system.connect", responder);// Loads a Drupal node.function loadNode( nid:Number ){	// Set up our responder with the callbacks.	var nodeResponse:Responder = new Responder( onNodeLoad, onError);	// Call Drupal to get the node.	drupal.call( "node.get", nodeResponse, sessionId, nid );}// Called when Drupal returns with our node.function onNodeLoad( node:Object ){	// Print out the node title.	title.text = node.title;}// Called when Drupal returns with a successful connection.function onConnect( result:Object ){	// Set our sessionId variable.	sessionId = result.sessid;			trace("We are connected!!!");	trace("Session Id: " + sessionId);			// Load our node.	loadNode( nodeId );	}// Called when an error occurs connecting to Drupal.function onError( error:Object ){	for each (var item in error) {		trace(item);   }}