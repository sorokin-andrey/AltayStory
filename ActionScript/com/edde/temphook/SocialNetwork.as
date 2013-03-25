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

		internal var ddos:Boolean = false;
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
		private var callbackDict:Dictionary = new Dictionary();

		public function SocialNetwork() {
		}
		
		public static function create(aType:String):SocialNetwork {
			var newObject:SocialNetwork;
			switch (aType) 
			{
				case VK: {
					newObject =  new VKontakteNetwork();					
					break;
				}					
				case OK: {
					//newObject = new OdnoklassnikiNetwork();
					break;
				}					
				case MM: {
					//newObject = new MailRuNetwork();
					break;
				}					
				default:
			}
			return newObject;
		}
		
		public function initNetwork(callback:MyFunctionClass):void {
			
		}

		
		public function injectFriends(data:Object):void {
			var callback:MyFunctionDataClass = callbackDict["get_friends"] as MyFunctionDataClass;
			if (callback) {
				callback.Callback(data);
			}
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
		


		public function getMutualFriends(callback:MyFunctionDataClass):void {
			callbackDict["get_friends"] = callback;
			//ddos = false;
		}
		
		public function getFriendsInfo():void {
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
	}	
}