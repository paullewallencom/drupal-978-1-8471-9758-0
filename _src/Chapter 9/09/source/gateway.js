// Variable to store our Flash objects.
var flashObjects = new Object;
var gatewayReady = false;

/**
 * Checks to make sure the document is ready
 * and then sets our gateway as ready.
 */

$(document).ready(function() {
   gatewayReady = true;  
});

/**
 * Checks to see if the gateway is ready.
 */

function isGatewayReady() {
   return gatewayReady;
}

/**
 * Adds a Flash object to the list
 *
 * @param - The id of the Flash object.
 */

function addFlashObject( id ) {
   flashObjects[id] = new Object;
   flashObjects[id].ready = false;
}

/**
 * Registers a flash player object.
 */
 
function registerFlashObject( id ) {   
   // Check if this object exists...
   if( !flashObjects[id] ) {
      addFlashObject( id );
   }

   // Set this object as ready.
   flashObjects[id].ready = true;
   
   // Check to see if this was the last...
   checkAllObjects();   
}

/**
 * Checks to see if all the players have registered.
 */
 
function allPlayersRegistered() {
   // Initialize our registered variable.
   var registered = true;
   
   // Iterate through all flash objects.
   for( id in flashObjects ) {
     // AND the ready flags together.
     registered = (registered && flashObjects[id].ready);
   }
   
   // Return if they all have registered.
   return registered;
}

/** 
 * Checks all Flash objects for registration
 * and calls their allSystemsGo functions on 
 * them if they are all ready.
 */

function checkAllObjects()
{
   // Check to see if they all registered.
   if( allPlayersRegistered() ) {
     // If so, then iterate through them and...
     for ( id in flashObjects ) {
        // Find the Flash Object.
        var flashObj = getFlashObject( id );
   
        // Call the allSystemsGo function.
        if( flashObj ) {    
            flashObj.allSystemsGo();
        }
      }
   }
}

/**
 *  Plays the media a player.
 *
 *  @param - The id of the Flash object.
 */
 
function playMedia( id ) 
{
   // Find the Flash Object.
   var flashObj = getFlashObject( id );
   
   // Play the flash object.
   if( flashObj ) {    
      flashObj.playMedia();
   }
}

/**
 *  Pauses the media a player.
 *
 *  @param - The id of the Flash object.
 */
 
function pauseMedia( id )
{
   // Find the Flash Object.
   var flashObj = getFlashObject( id );
   
   // Pause the flash object.
   if( flashObj ) {    
      flashObj.pauseMedia();
   }
}

/**
 *  Plays the control of a player.
 *
 *  @param - The id of the Flash object.
 */
 
function playControl( id ) 
{
   // Find the Flash Object.
   var flashObj = getFlashObject( id );
   
   // Play the flash object.
   if( flashObj ) {    
      flashObj.playControl();
   }
}

/**
 *  Pauses the control of a player.
 *
 *  @param - The id of the Flash object.
 */
 
function pauseControl( id )
{
   // Find the Flash Object.
   var flashObj = getFlashObject( id );
   
   // Pause the flash object.
   if( flashObj ) {    
      flashObj.pauseControl();
   }
}

/** 
 *  Returns a Flash Object given an ID
 *
 *  @param - The ID of the player.
 */

function getFlashObject( id )
{
   var flashObj = null;       
    
	// Check for Internet Explorer                          
   if(navigator.appName.indexOf("Microsoft") != -1) {
      flashObj = window[id];
   }
   else {

      // Index our ID within the document object
      if(document[id].length != undefined) {
         flashObj = document[id][1];
      }
      else {
         flashObj = document[id];
      }
   }
   
   // We want to alert them if the object was not found.
   if( !flashObj ) {
      alert( id + " not found!" );
   }
   
   return flashObj;
}
