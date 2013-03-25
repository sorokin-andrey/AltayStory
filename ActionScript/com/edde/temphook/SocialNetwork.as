package com.edde.temphook
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.net.URLVariables;
	import flash.external.ExternalInterface;
	/*
	import com.adobe.utils.NumberFormatter;	
	import mx.utils.Base64Encoder;
	import events.FarmEvent;
	import utils.AvallonHttpLoader;
	import utils.AvallonLoader;
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	import utils.ErrorChecker;
	import ui.UpMenu
	//*/
	/**
	 * ...
	 * @author Marat aka Dikiy Koshmarik
	 */
	public class SocialNetwork 
	{
		public static const VK:String = "VK";
		public static const OK:String = "OK";
		public static const OKF:String = "OKF";
		public static const MM:String = "MM";
		public static const CSCSocket:String = "Socket";
		public static const CSCHttp:String = "Http";

		//internal var eve:FarmEvent;
		internal var ddos:Boolean = false;
		//internal var parent:DisplayObject;
		//public var delegate:ISocialNetwork;
		internal var type:String;

		internal var serverSocket:String = "/4/4xdata";		
		internal var serverHttp:String = "/app/over_http.php?";	
		internal var server:String = null;
		public var clientServerConnectionType:String = CSCSocket;
		internal var upload_server:String;
		public var uid:String;		
		internal var aid:String = null;
		internal var sig:String;
		internal var my_auth_hashkey:String;
		public var sex:String;
		internal var user_name:String = "";
		public var networkCurrency:String;
		public var bagTopicURL:String;
		public var gameURL:String;
		public var groupURL:String;
		public var paramUserPhoto:String;
		
		//public var tracker:AnalyticsTracker = null;
		private var requestTimesArray:Object = { };

		public function SocialNetwork() {
		}
		
		public static function create(aType:String):SocialNetwork {
			var newObject:SocialNetwork;
			var trackerId:String = "UA-28838256-4";
			switch (aType) 
			{
				case VK: {
					newObject =  new VKontakteNetwork();					
					trackerId = "UA-28838256-6";
					break;
				}					
				case OK: {
					//newObject = new OdnoklassnikiNetwork();
					trackerId = "UA-28838256-7";
					break;
				}					
				case MM: {
					//newObject = new MailRuNetwork();
					trackerId = "UA-28838256-8";
					break;
				}					
				default:
			}
			/*
			if (Manager.isUserIsTester() || Manager.origin == "http://195.210.47.64") {
				trackerId = "UA-28838256-4";
			}
			newObject.tracker = new GATracker(aParent, trackerId, "AS3", false );
			newObject.parent = aParent;
			if (newObject.tracker) {
				newObject.tracker.setDetectFlash(true)
				//newObject.tracker.set
				newObject.tracker.trackPageview("/map");
			}
			//*/
			return newObject;
		}
		
		public function initNetwork(callback:MyFunctionClass):void {
			
		}

		
		public function injectFriends(data:Object):void {			
			//var eve:FarmEvent = new FarmEvent(FarmEvent.INJECT_FRIENDS_DATA);
			//eve.data = data;			
			//Manager.dispatcher.dispatchEvent(eve);
		}
		
		public function getTopUsersInfo(users:Array):void {
			var out:String = "";
			for (var i:int = 0; i < users.length; i++) {
				out += users[i];
				if (i < users.length - 1) {
					out += ",";
				}
			}
			ExternalInterface.call("SocialWrapper.getProfiles", out);
		}
		
		///Functions without caller
		//private function onLoadProfiles(data:Object):void {
			//var eve:FarmEvent = new FarmEvent(FarmEvent.INJECT_FRIENDS_DATA);
			//eve.data = data;
			//Manager.dispatcher.dispatchEvent(eve);
		//}
		//
		//private function injectAllFriends(data:Object):void {
			//var eve:FarmEvent = new FarmEvent(FarmEvent.INJECT_FRIENDS_DATA);
			//eve.data = data;
			//Manager.dispatcher.dispatchEvent(eve);
		//}
		
		///Overloaded functions
		public function createAlbum(callback:MyFunctionClass):void {
		}
		
		public function getAlbumsCallback(data:Object):void {			
		}
		
		public function createAlbumFromBack():void {
		}
		
		public function createAlbumCallback(data:Object):void {
		}
		
		public function getUploadServerCallback(data:*):void {		
		}
		
		public function sendScreenData(imageData:ByteArray):void {			
		}
		
		internal function onUploadFile(e:Event):void {
		}
		
		public function getMutualFriends():void {
			//Manager.preloaderGoto(91);
			//ErrorChecker.startCheck("getMutualFriends");
			//if (!Manager.buildType) {
				//var eve:FarmEvent = new FarmEvent(FarmEvent.INJECT_FRIENDS_DATA);
				//Manager.dispatcher.dispatchEvent(eve);				
			//}
			//ddos = false;
		}
		
		public function getFriendsInfo():void {
			//Manager.preloaderGoto(94);
			//ErrorChecker.startCheck("getFriendsInfo");
			//if (!Manager.buildType) {
				//var eve:FarmEvent = new FarmEvent(FarmEvent.INJECT_FRIENDS_DATA);
				//Manager.dispatcher.dispatchEvent(eve);				
			//}
			//ddos = true;
		}
		
		public function addFriends():void {
		}
		
		public function saveWallPost(type:String, msg:String, id:Object = null, imgUrl:String = null):void {
			
		}
		
		public function showRequestBox(msg:String, id:Object = null):void {
			
		}
		
		public function buyOffer(msg:String, votes:Number, offer_id:String, type:String, money:Number, callback:MyFunctionClass):void {
		}
		
		public function buyCoins(msg:String, votes:Number, action_id:String, type:String, money:Number):void {
		}
		
		
		public function loadFriendsPhotos(gamer:Object, i:int, ddtt:Object):void {
		}
		
		public function getOfferLead():void {
			
		}
		
		public function showOfferLead(callback:MyFunctionClass = null):void {
			
		}
		
		public function setClientServerConnectionType(type:String):void {
			//clientServerConnectionType = type;
		}
		
		///URLLoader prepare
		/*
		public function avalonLoaderLoadURL(params:Object, callback:Function, method:String = "POST", time_answer:Number = 0, postParams:URLVariables = null):void {
			if (clientServerConnectionType == CSCSocket) {
				server = serverSocket;
			} else {
				server = Manager.origin + serverHttp;//
				//for (var i:int = 0; i < 10; i++) {
				//	server += String.fromCharCode(48 + Math.random() * 5);
				//}
			}
			//ConsoleTrace("avalon 1", uid);
			params.request_id = (Math.floor(Math.random() * 100000) + 1).toString();
			//ConsoleTrace("avalon 2", params.request_id);
			params.my_auth_hashkey = (my_auth_hashkey)?my_auth_hashkey:"not_set";
			//ConsoleTrace("avalon 3", params.my_auth_hashkey);
			params.auth_key = sig;
			//ConsoleTrace("avalon 4", sig);
			if (Manager.isCompressSocketData) {
				params.compress = Manager.isCompressSocketData;
			}
			//ConsoleTrace("avalon 5");
			params.random = (Math.random() * 500).toString();
			//ConsoleTrace("avalon 6", params.random);
			var url:String = "uid=" + uid;
			for (var k:String in params) {
				if (params[k] == null) continue;
				if (params[k] == "") {
					url += "&" + k;
				} else {
					url += "&" +  k + "=" + params[k];
				}
			}
			//ConsoleTrace("avalon 7");
			MyTrace("Loader", url)
			if (clientServerConnectionType == CSCSocket) {
				AvallonLoader.loadUrl(server+url, postParams, callback, method, time_answer, params.request_id, params.compress == 1);
			} else {
				var httpUrl:String = "";
				if (Manager.isEncryptionEnabled) {
					var bd:Base64Encoder = new Base64Encoder();
					bd.encode(url);
					var encUrl:String = bd.toString();
					var salt:String = "";
					for (var i:int = 0; i < 10; i++) {
						salt += String.fromCharCode(97 + Math.random() * 20);
					}
					httpUrl = server + "sxparams=" + salt + encUrl;// bd.toString();
				} else {
					httpUrl = server + url;
				}

				AvallonHttpLoader.loadUrl(httpUrl, postParams, callback, method, time_answer, params.request_id, params.compress == 1);
			}
			//ConsoleTrace("avalon 8");
		}
		
		public function socialDependedParam(type:String):Object {
			return this[type];			
		}
		//*/
	}	
}