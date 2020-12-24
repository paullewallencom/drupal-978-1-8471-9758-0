﻿package {	// Import all dependencies.	import flash.media.Video;	import flash.net.NetStream;	import flash.net.NetConnection;	import flash.net.ObjectEncoding;	import flash.display.MovieClip;	import flash.events.*;		// Declare our class 	public class VideoPlayer extends MediaPlayer	{		// Constructor function.  		// Called when someone creates a new VideoPlayer		public function VideoPlayer()		{			// Make sure we call the MediaPlayer constructor			super();						// Let us know that we created this player.			trace( "VideoPlayer created!" );						// Connect to our NetConnection.			connect();						// Setup the video stream.			setupVideoStream();						// Initialize to not loaded.			loaded = false;									// Add a listener when the player is added to the stage.			addEventListener( Event.ADDED_TO_STAGE, onAdded );      }				// Called when the video player has been added to the stage.		private function onAdded( event:Event ) 		{			// Create our video object the size of our stage.			video = new Video( stage.width, stage.height );						// Attach our net stream to the video object.			video.attachNetStream( stream );						// Add the video to the VideoPlayer.			addChildAt( video, 0 );		}				// Create a new NetConnection		private function connect()		{						connection = new NetConnection();			connection.addEventListener(NetStatusEvent.NET_STATUS,onStatus);			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);			connection.objectEncoding = ObjectEncoding.AMF0;			connection.connect(null); 				}				// Setup a new video stream.		private function setupVideoStream()		{			   		stream = new NetStream(connection);   		stream.addEventListener(NetStatusEvent.NET_STATUS,onStatus);   		stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onError);   		stream.client = this;				}		// Stub function for the client association.		public function onMetaData(info:Object) {}		// Our video status handler.		private function onStatus(event:NetStatusEvent) 		{			// If the video is playing.			if( event.info.code == "NetStream.Play.Start" )			{				// Pause the stream if it is not loaded.				if( !loaded ) {					loaded = true;					stream.pause();										}			}		}		// Called when a video error occurs.		private function onError(event:Object):void 		{			trace("VideoPlayer Error: " + event);		}				// Play a video file		override public function playFile()		{			// Call the MediaPlayer playFile function.			super.playFile();						// Resume the stream.			stream.resume();		}				// Pause a video file		override public function pause()		{			// Call the MediaPlayer pause function.			super.pause();						// Pause the stream.			stream.pause();					}				// Load a video file.		override public function load( file:String )		{						// Call the MediaPlayer load function.			super.load( file );						// Reset the loaded flag.			loaded = false;						// stop the current stream.			stream.close();					// Start playing the new stream.			stream.play(file);			}					// Add all of our video variables.		private var video:Video;		private var stream:NetStream;		private var connection:NetConnection;				// Variable to keep track of loaded state.		private var loaded:Boolean;   }}