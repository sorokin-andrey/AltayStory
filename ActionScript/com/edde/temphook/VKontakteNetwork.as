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
		private var isNewOrderApi:Boolean;
		public function VKontakteNetwork() 
		{
			//trace("System", System.vmVersion, System.useCodePage)
			super();
			type = SocialNetwork.VK;
			///Manager.on_add_friend_show = true;
			networkCurrency = "голос";
			bagTopicURL = "http://vk.com/"//page-33537437_43822506";
			gameURL = "http://vk.com/app3103563";
			groupURL = "http://vk.com/club42487638"//club33537437";
			paramUserPhoto = "photo";	
			isNewOrderApi = false;
			addCallbacks();
//			Manager.dispatcher.addEventListener(FarmEvent.REMOVE_RELOAD_BANK_ACCOUNT_VOTES_LISTENER, removeReloadBankAccountVotesListener, false, 0, true);
		}
		
		override public function initNetwork(callback:MyFunctionClass):void {
			addCallbacks();
			//trace("initNetwork", Manager.stage, Manager.stage.loaderInfo.parameters["isNewOrderApi"]);
			//if (Manager.stage.loaderInfo.parameters["isNewOrderApi"] == "true") {
				isNewOrderApi = true;
			//}
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
			//MyTrace("VK.getAlbums");
			trace("VK.getAlbums", data);
			if (data) {
				for (var i:int = 0; i < data.length; i++) {
					if (data[i].title == "Комарово"/*Manager.appName*/) {
						aid = data[i].aid;
						break;
					}
				}
			}
		}
		
		private function userBalance(data:int):void	{
			//var eve:FarmEvent = new FarmEvent(FarmEvent.CHECK_BALANCE);
			//eve.exp = data / 100;
			//Manager.dispatcher.dispatchEvent(eve);
		}
		
		private function injectUids(data:Object):void {
			//var out:String = "0";
			//for (var i:int = 0; i < data.length; i++) {				
				//out += ",";
				//out += data[i];
			//}			
			//ExternalInterface.call("SocialWrapper.getProfiles", out + "," + uid);
			if (secondRequestTimer) {
				secondRequestTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, secondRequest);
				secondRequestTimer.reset();
				secondRequestTimer = null;
			}
			if (ddos) {
				//Manager.preloaderGoto(95);
				
			} else {
				//Manager.preloaderGoto(92);
				ddos = true;
			}
			if (data && data.length > 0) {
				ExternalInterface.call("SocialWrapper.getProfiles",  data.join(",") + "," + uid);
			} else {
				ExternalInterface.call("SocialWrapper.getProfiles",  uid);				
			}
		}
		
		private function photoSaveCallback(data:Object):void {
//			var eve:FarmEvent = new FarmEvent(FarmEvent.SHOW_ONCE_DIALOG);
//			eve.text = "Скриншот успешно сохранен в альбоме игры";
//			Manager.dispatcher.dispatchEvent(eve);
		}
		
		private function isMemberCallBack(data:Object):void {			
//			eve = new FarmEvent(FarmEvent.SET_MEMBER_INFO);
//			eve.num = int(data);
//			Manager.dispatcher.dispatchEvent(eve);
		}
		
		private function onSettingsChanged():void {			
			ExternalInterface.call("SocialWrapper.getUserSettings");
		}
		
		private function onBalanceChanged(data:int):void {
//			eve = new FarmEvent(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES);
//			eve.num = data;
//			Manager.dispatcher.dispatchEvent(eve);
		}
		
		private function getUserSettingsCallback(data:Object):void {			
			if (int(data) & 256) {
//				eve = new FarmEvent(FarmEvent.SHOW_LEFT_LINE_GAME);
//				Manager.dispatcher.dispatchEvent(eve);
			} else {
//				eve = new FarmEvent(FarmEvent.HIDE_LEFT_LINE_GAME);
//				Manager.dispatcher.dispatchEvent(eve);
			}
		}
		
		override public function createAlbum(callback:MyFunctionClass):void {
			if (upload_server == null || upload_server == "") {
				if (aid != null) {
					ExternalInterface.call("SocialWrapper.getUploadServer", { aid: aid } );
				} else {
//					eve = new FarmEvent(FarmEvent.SHOW_TWICE_DIALOG);
//					eve.text = "Создать альбом игры?";
//					eve.callback = createAlbumFromBack;
//					Manager.dispatcher.dispatchEvent(eve);
				}
			} else {
//				eve = new FarmEvent(FarmEvent.SHOW_TWICE_DIALOG);
//				eve.text = "Сохранить снимок экрана в альбоме игры?";
//				eve.callback = callback;
//				Manager.dispatcher.dispatchEvent(eve);
			}
		}
		
		override public function createAlbumFromBack():void {
			ExternalInterface.call("SocialWrapper.createAlbum", { title:"Комарово"/*Manager.appName*/ , description:" Альбом игры " + "Комарово"/*Manager.appName*/ } );
		}
		
		override public function createAlbumCallback(data:Object):void {
			aid = data.aid;
			ExternalInterface.call("SocialWrapper.getUploadServer", { aid: aid } );
		}
		
		override public function getUploadServerCallback(data:*):void {		
			upload_server = data.upload_url;
			//eve = new FarmEvent(FarmEvent.CREATE_SNAPSHOT);
			//Manager.dispatcher.dispatchEvent(eve);
		}
		
		override public function sendScreenData(imageData:ByteArray):void {			
			//var ml:MultipartURLLoader = new MultipartURLLoader();
			//ml.addEventListener(Event.COMPLETE, onUploadFile);
			//ml.addFile(imageData, "file.jpg", "file1", "image/jpg");			
			//ml.load(upload_server);			
		}
		
		override internal function onUploadFile(e:Event):void {
			//var data:Object = MyJSON.decode(e.currentTarget.loader.data);
			//ExternalInterface.call("SocialWrapper.photoSave", { aid:aid, server:data.server, photos_list:data.photos_list, hash: data.hash } );
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
		/*
		override public function registerLoading(parameters:Object):void {
			//MyTrace("VK.registerLoading");
			//var pp:String = null;
			if (parameters.viewer_id != undefined) {
				uid = parameters.viewer_id; //"554411"//wrapper.application.parameters.viewer_id;			
				sig = parameters.auth_key;
			} else {//FarmDev latifundia 2454275
			//	Manager.uid = "6666666" //"109814483"//"182263";//
				uid = "176009237";//"21392716"//"356335"//"28846118";// "122011878";// "176009237";//  "12214903"//"182263";//"13072958"//"17257800"
			}
			//Manager.isDebug = (uid == "28846118" || uid == "176009237" || uid == "122011878" || !Manager.buildType)// || uid == "8724214")// || uid == "18715530")/// || uid == "138955813")// || uid == "36669606")// || uid == "167744892" || uid == "138955813")
			
			ExternalInterface.call("function(){SocialWrapper.uid="+uid+";}");
			super.registerLoading(parameters);
		}
		override public function onCheckRegister(data:Object):void {
			super.onCheckRegister(data);
			//MyTrace("VK.onCheckRegister", uid, aid, Manager.traceObject(data));
			//ExternalInterface.call("function(){SocialWrapper.uid="+uid+";}");
			if (data.registered == "1") {
				//delegate.startGame();
			} else if (data.registered == "0"){								
				//delegate.startGame(true);
				//Manager.dispatcher.addEventListener(FarmEvent.I_CHOSE_SEX, iChose);

				//Manager.on_add_friend_show = true;
				//Manager.from_registration = true;
				ExternalInterface.call("SocialWrapper.getProfiles", uid);
				//Manager.dispatcher.addEventListener(FarmEvent.INJECT_FRIENDS_DATA, onLoadProfile);				

				//showChoseSex();
				//startGame(true);
				//onLoadProfile(null)
			} else {
				
			}
		}
		
		private function onLoadProfile(e:FarmEvent):void {
			//Manager.preloaderGoto(99);
			//MyTrace("VK.onLoadProfile", Manager.traceObject(e.data));
			//Manager.dispatcher.removeEventListener(FarmEvent.INJECT_FRIENDS_DATA, onLoadProfile);
			user_name       = e.data[0].first_name + " " + e.data[0].last_name;
			//sex = setBinSex(e.data[0].sex);
			//Manager.bin_sex = e.data[0].sex;
			//Manager.removePreloader();
			//delegate.startGame(true);
		}
		
		private var wall_photos_id = {
			"callFriends": 		"",//"87894229_273822496",
			"askHelpFriends": 	"28846118_289253466",//"28846118_287716323",//"87894229_279700945",
			"noFriend": 		"28846118_289253465",//"28846118_287716322",//"87894229_283578670",
			"tellFriend":		"",//"87894229_273822500",
			"tellFriendTerritory": 		"28846118_289253469",//"28846118_287716324",//"87894229_278109517",
			"inviteFriend": "",//"87894229_273822497",
			"questComplete": "28846118_289253470",//"28846118_287906552",//"87894229_278109515",
			"newLevel": "28846118_289253467",//"28846118_287716319",//"87894229_278109516",
			"collectionChange":"28846118_289253472",//"28846118_289217841",//"356335_284775463",
			"newAchievement_1345021837":"28846118_288615628",
			"newAchievement_1345022446":"28846118_288615629",
			"newAchievement_1345023064":"28846118_288615630",
			"newAchievement_1345024535":"28846118_288615632",
			"newAchievement_1345024811":"28846118_288615633",
			"newAchievement_1345025096":"28846118_288615636",
			"newAchievement_1345026292":"28846118_288615637",
			"newAchievement_1345027510":"28846118_288615638",
			"newAchievement_1345029351":"28846118_288615640",
			"newAchievement_1345029807":"28846118_288615642",
			"newAchievement_1345030033":"28846118_288615643",
			"newAchievement_1345030312":"28846118_288615644",
			"newAchievement_1345030827":"28846118_288615645",
			"newAchievement_1345034164":"28846118_288615647",
			"newAchievement_1345034395":"28846118_288615649",
			"newAchievement_1345536422":"28846118_288615650",
			"newAchievement_1345536625":"28846118_288615652",
			"treasureChange":"28846118_291385554",//"28846118_289253472",
			"":""
		};
		
		override public function saveWallPost(type:String, msg:String, id:Object = null, imgUrl:String = null) {
			if (id == null) id = uid;
			ExternalInterface.call("SocialWrapper.wallSavePost", { msg: msg, photo_id: wall_photos_id[type], wall_id: id } );
		}
		
		override public function showRequestBox(msg:String, id:Object = null) {
			if (id == null) id = uid;
			ExternalInterface.call("SocialWrapper.showRequestBox", { message: msg, uid: id } );
		}

		///Offer
		private var offerVotes:Number;
		private var offerId:String;
		//private var offerMsg:String;
		private var offerCallbackRemote:MyFunctionClass;
		
		override public function buyOffer(msg:String, votes:Number, offer_id:String, type:String, money:Number, callback:MyFunctionClass) {
			//msg = (money).toString() + (type == "gold" ? " золотых монет" : " серебрянных монет")
			if (isNewOrderApi) {
				var offId:String = "offer_" + offer_id + "_" + int(votes).toString();
				//MyTrace("buyOffer", isNewOrderApi,offId);
				offerCallbackRemote = callback;
				ExternalInterface.call("SocialWrapper.showOfferOrderBox", {offerid:offId, votes:votes});
			} else {
				offerVotes = votes;
				offerId = offer_id;
				offerCallbackRemote = callback;
				ExternalInterface.call("SocialWrapper.getUserBalance");
				//Manager.dispatcher.addEventListener(FarmEvent.CHECK_BALANCE, checkOfferBalance, false, 0, true);
				//Manager.dispatcher.removeEventListener(FarmEvent.CHECK_BALANCE, checkBalance);			
			}
		}
		/*
		private function checkOfferBalance(e:FarmEvent):void {
			//Manager.dispatcher.removeEventListener(FarmEvent.CHECK_BALANCE, checkOfferBalance);			
			var balance:Number = e.exp - offerVotes;			
			if (balance < 0) {
				//eve = new FarmEvent(FarmEvent.SHOW_BALANCE_DIALOG);
				//eve.cost = Math.abs(balance);
				//Manager.dispatcher.dispatchEvent(eve);
				//Manager.dispatcher.addEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankOfferAccountVotes, false, 0, true);
				//Manager.dispatcher.removeEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankAccountVotes);
			} else {			
				//avalonLoaderLoadURL( { url_path:Manager.urlPathForServerRequest(Manager.UrlPathBankOffer), offer_id:offerId }, offerCallbackRemote);
			}
		}
		
		private function reloadBankOfferAccountVotes(e:FarmEvent):void {
			Manager.dispatcher.removeEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankOfferAccountVotes);
			var balance:Number = e.num - offerVotes;
			if (balance >= 0) {
				avalonLoaderLoadURL( { url_path:Manager.urlPathForServerRequest(Manager.UrlPathBankOffer), offer_id:offerId }, offerCallbackRemote);
			}
		}
		//* /
		private function orderSuccessCallback(data:int):void {
			if (offerCallbackRemote) {
				offerCallbackRemote(null);
				offerCallbackRemote = null;
			}
			//Manager.reloadInfo();
		}
		
		private function orderCallback():void {
			if (offerCallbackRemote) {
				offerCallbackRemote = null;
			}
			//Manager.reloadInfo();
		}
		
		//private function onSendOfferPayment(e:Object):void {
			//UpMenu.action.visible = false;
			//eve = new FarmEvent(FarmEvent.SHOW_ONCE_DIALOG);			
			//eve.text = "Поздравляем! Покупка осуществлена!";
			//Manager.dispatcher.dispatchEvent(eve);			
			//closeOffer(null);
		//}
		
		
		///Bank
		private var bankVotes:Number;
		private var bankActionId:String;
		private var bankMsg:String;
		
		override public function buyCoins(msg:String, votes:Number, action_id:String, type:String, money:Number) {
			//msg = (money).toString() + (type == "gold" ? " золотых монет" : " серебрянных монет")
			
			if (isNewOrderApi) {
				var bankid:String = type + "_" + int(votes).toString();
				MyTrace("buyOffer", isNewOrderApi,bankid);
				ExternalInterface.call("SocialWrapper.showBankOrderBox", {bankid:bankid, votes:votes});
			} else {
				bankActionId = action_id;
				bankMsg = msg;
				bankVotes = votes;
				MyTrace("Bank", bankActionId, bankMsg, bankVotes)
				
				ExternalInterface.call("SocialWrapper.getUserBalance");
				Manager.dispatcher.addEventListener(FarmEvent.CHECK_BALANCE, checkBalance, false, 0, true);
				Manager.dispatcher.removeEventListener(FarmEvent.CHECK_BALANCE, checkOfferBalance);			
			}
		}
		
		private function checkBalance(e:FarmEvent):void {
			Manager.dispatcher.removeEventListener(FarmEvent.CHECK_BALANCE, checkBalance);			
			var balance:Number = e.exp - bankVotes;
			//MyTrace("BAlance Bank = " + balance);
			if (balance < 0) {
				MyTrace("MINUS");
				eve = new FarmEvent(FarmEvent.SHOW_BALANCE_DIALOG);
				eve.cost = Math.abs(balance);
				Manager.dispatcher.dispatchEvent(eve);
				Manager.dispatcher.addEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankAccountVotes, false, 0, true);
				Manager.dispatcher.removeEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankOfferAccountVotes);
			} else {
				MyTrace("PLUS");
				avalonLoaderLoadURL( { url_path:Manager.urlPathForServerRequest(Manager.UrlPathBankConvert), promo_id:bankActionId }, onSendPayment);
			}			
		}
		
		private function reloadBankAccountVotes(e:FarmEvent):void {
			Manager.dispatcher.removeEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankAccountVotes);
			var balance:Number = e.num - bankVotes;
			//MyTrace("BAlance Bank = " + balance);
			if (balance >= 0) {
				avalonLoaderLoadURL( { url_path:Manager.urlPathForServerRequest(Manager.UrlPathBankConvert), promo_id:bankActionId }, onSendPayment);
			}
		}
		
		private function onSendPayment(data:Object):void {
			if (data.status == "success") {
				eve = new FarmEvent(FarmEvent.SHOW_ONCE_DIALOG);			
				eve.text = "Поздравляем вам было начислено " + bankMsg;
				Manager.dispatcher.dispatchEvent(eve);
			}
			eve = new FarmEvent(FarmEvent.SET_BANK_BONUS_INFO);
			Manager.dispatcher.dispatchEvent(eve);
		}

		private function removeReloadBankAccountVotesListener(e:FarmEvent):void {
			Manager.dispatcher.removeEventListener(FarmEvent.CHECK_BALANCE, checkBalance);			
			Manager.dispatcher.removeEventListener(FarmEvent.CHECK_BALANCE, checkOfferBalance);			
			Manager.dispatcher.removeEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankAccountVotes);			
			Manager.dispatcher.removeEventListener(FarmEvent.RELOAD_BANK_ACCOUNT_VOTES, reloadBankOfferAccountVotes);
		}
		
		private function offerLeadCallback(data:Object = null):void {
			MyTrace("offerLeadCallback", Manager.traceObject(data));
			Manager.offerLeadData = data;
			ExternalInterface.call("");
			if (data && data.length > 1 && data[0] != 0) {
				var flag:Boolean = false;
				var offerId:String = null;
				for (var i:int = 0; i < data[1].length; i++) {
					switch (data[1][i].id) {
						case "565": ///MTS
						{
							flag = true;
							break;
						}
						case "980": ///Philips
						{
							flag = true;
							break;
						}
						case "489": ///Skittles
						{
							flag = true;
							break;
						}
					}
					if (flag) {
						offerId =  data[1][i].id;
						Manager.offerLeadId = offerId;
						eve = new FarmEvent(FarmEvent.SHOW_OFFER_LEAD_ICON);
						eve.icon_url = data[1][i].img;
						///Manager.dispatcher.dispatchEvent(eve);
						break;
					}
				}
			} else if (Manager.isDevelop && Manager.defaultOfferLeadIcon){
				//Manager.offerLeadId = "565";
				eve = new FarmEvent(FarmEvent.SHOW_OFFER_LEAD_ICON);
				eve.icon_url = Manager.defaultOfferLeadIcon;// "http://cs301604.userapi.com/u00100/b_41c87ef6.jpg";
				Manager.dispatcher.dispatchEvent(eve);
				
			}
		}
		
		override public function getOfferLead():void {
			ExternalInterface.call("SocialWrapper.getOfferLead");
		}
		
		override public function showOfferLead(callback:Function = null):void {
			offerCallbackRemote = callback;
			ExternalInterface.call("SocialWrapper.showOfferLead", {offerid:Manager.offerLeadId});
		}
		
		/*		
		override public function loadFriendsPhotos(gamer:Object, i:int, ddtt:Object, temp:FriendsNodeUI):void {
			for (var m:int = 0; m < Manager.friends.length; m++) {
				if (gamer.uid == "169570414") {
					MyTrace("NEW ID FOUND i = " + i);
				}
				if (Manager.friends[m].uid == gamer.uid) {
					if (gamer.uid == "169570414") {
						MyTrace("IN IF CLOSE m = " + m);
					}
					ddtt.first_name       = Manager.friends[m].first_name;
					ddtt.last_name        = Manager.friends[m].last_name;
					ddtt.uid              = Manager.friends[m].uid;
					ddtt.photo 			= Manager.friends[m].photo;
					temp.nameText.text 	  = Manager.friends[m].first_name;
					temp.uid			  = Manager.friends[m].uid;
					
					if ( Manager.friends[m].photo != "http://vk.com/images/camera_c.gif" &&  Manager.friends[m].photo != "http://vk.com/images/deactivated_c.gif") {
						Images.loadOne(Manager.friends[m].photo, temp.img, null, null, 0, 0, true);
					} else {
						Images.loadOne("http://cs304908.userapi.com/u87894229/149309602/x_f1a3e655.jpg", temp.img, null, null, 0, 0, true);
					}
					break;
				}
			}
		}
		//*/
	}

}