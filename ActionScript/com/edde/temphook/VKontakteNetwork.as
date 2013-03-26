package com.edde.temphook
{
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
//	import mx.utils.Base64Decoder;
	
	import flash.system.System;
	
	/**
	 * ...
	 * @author Marat aka Dikiy Koshmarik
	 */
	public class VKontakteNetwork extends SocialNetwork 
	{
		private var secondRequestTimer:Timer = null;
		//private var isNewOrderApi:Boolean;
		public function VKontakteNetwork() 
		{
			super();
			type = SocialNetwork.VK;
			networkCurrency = "голос";
			bagTopicURL = "http://vk.com/"//page-33537437_43822506";
			gameURL = "http://vk.com/app3103563";
			groupURL = "http://vk.com/club42487638";
			paramUserPhoto = "photo";	
			//isNewOrderApi = false;
			addCallbacks();
		}
		
		override public function initNetwork(callback:MyFunctionClass):void {
			addCallbacks();
			//isNewOrderApi = true;
			callback.Callback();
		}
		
		public function addCallbacks():void {			
			ExternalInterface.addCallback("getUserBalanceCallback", userBalance);			
			ExternalInterface.addCallback("getFriendsCallback", injectUids);
			ExternalInterface.addCallback("getAppFriendsCallback", injectUids);
			ExternalInterface.addCallback("getProfilesCallback", injectFriends);
			ExternalInterface.addCallback("getAlbumsCallback", getAlbumsCallBack);
			ExternalInterface.addCallback("CreateAlbumCallback", createAlbumCallback);
			ExternalInterface.addCallback("getUploadServerCallback", getUploadServerCallback);			
			ExternalInterface.addCallback("photoSaveCallback", photoSaveCallback);
			ExternalInterface.addCallback("isMemberCallback", isMemberCallBack);
			ExternalInterface.addCallback("onSettingsChanged", onSettingsChanged);
			ExternalInterface.addCallback("onBalanceChanged", onBalanceChanged);
			ExternalInterface.addCallback("getUserSettingsCallback", getUserSettingsCallback);			
			//ExternalInterface.addCallback("onOrderSuccessCallback", orderSuccessCallback);
			//ExternalInterface.addCallback("onOrderCancelCallback", orderCallback);
			//ExternalInterface.addCallback("onOrderFailCallback", orderCallback);
			//ExternalInterface.addCallback("onOfferLeadCallback", offerLeadCallback);
			ExternalInterface.call("SocialWrapper.getAlbums");
		}		
		
		//override 
		public function getAlbumsCallBack(data:Object):void {
			trace("VK.getAlbums", data);
			if (data) {
				for (var i:int = 0; i < data.length; i++) {
					if (data[i].title == "Комарово") {
						aid = data[i].aid;
						break;
					}
				}
			}
		}
		
		private function userBalance(data:int):void	{
		}
		
		private function injectUids(data:Object):void {
			if (secondRequestTimer) {
				secondRequestTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, secondRequest);
				secondRequestTimer.reset();
				secondRequestTimer = null;
			}
			if (ddos) {
				
			} else {
				ddos = true;
			}
			if (data && data.length > 0) {
				ExternalInterface.call("SocialWrapper.getProfiles",  data.join(",") + "," + uid);
			} else {
				ExternalInterface.call("SocialWrapper.getProfiles",  uid);				
			}
		}
		
		private function photoSaveCallback(data:Object):void {
		}
		
		private function isMemberCallBack(data:Object):void {			
		}
		
		private function onSettingsChanged():void {			
			ExternalInterface.call("SocialWrapper.getUserSettings");
		}
		
		private function onBalanceChanged(data:int):void {
		}
		
		private function getUserSettingsCallback(data:Object):void {			
			if (int(data) & 256) {
			} else {
			}
		}
		
		override public function createAlbum(callback:MyFunctionClass):void {
			if (upload_server == null || upload_server == "") {
				if (aid != null) {
					ExternalInterface.call("SocialWrapper.getUploadServer", { aid: aid } );
				} else {
				}
			} else {
			}
		}
		
		override public function createAlbumFromBack():void {
			ExternalInterface.call("SocialWrapper.createAlbum", { title:"Комарово" , description:" Альбом игры " + "Комарово" } );
		}
		
		override public function createAlbumCallback(data:Object):void {
			aid = data.aid;
			ExternalInterface.call("SocialWrapper.getUploadServer", { aid: aid } );
		}
		
		override public function getUploadServerCallback(data:*):void {		
			upload_server = data.upload_url;
		}
		
		override public function sendScreenData(imageData:ByteArray):void {			
		}
		
		override internal function onUploadFile(e:Event):void {
		}
		
		override public function addFriends():void {
			ExternalInterface.call("SocialWrapper.addFriend");
		}

		private function secondRequest(e:TimerEvent):void {
			if (secondRequestTimer) {
				secondRequestTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, secondRequest);
				secondRequestTimer.reset();
				secondRequestTimer = null;
			}
			
			if (ddos) {
				getFriendsInfo();
			} else {
				getMutualFriends();
			}
		}
		
		override public function getMutualFriends():void {
			ddos = false;
			super.getMutualFriends();
			ExternalInterface.call("SocialWrapper.getFriends", uid);// , { uid:uid } );
			secondRequestTimer = new Timer(5000, 1);
			secondRequestTimer.addEventListener(TimerEvent.TIMER_COMPLETE, secondRequest, false, 0, true);
			secondRequestTimer.start();
		}
		
		override public function getFriendsInfo():void {
			ddos = true;
			super.getFriendsInfo();
			ExternalInterface.call("SocialWrapper.getAppUsers", uid);// , { uid:uid } );
			secondRequestTimer = new Timer(5000, 1);
			secondRequestTimer.addEventListener(TimerEvent.TIMER_COMPLETE, secondRequest, false, 0, true);
			secondRequestTimer.start();
		}
	}

}