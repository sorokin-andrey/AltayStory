using UnityEngine;
using System.Collections;
#if UNITY_FLASH
using UnityEngine.Flash;
#endif


[NotConverted]
[NotRenamed] 
public class SocialNetwork {
	
	/*
	// Use this for initialization
	void Start () {
		#if UNITY_FLASH
			Application.ExternalCall("ExternalInterface.addCallback(\"getAlbumsCallback\", {0});","GetAlbumsCallBack");
			Application.ExternalCall("ExternalInterface.call(\"SocialWrapper.getAlbums\");");
		Debug.Log("InitNetwork");
			
			//ActionScript.Import("flash.external.ExternalInterface");
			//ActionScript.Statement("ExternalInterface.addCallback(\"getAlbumsCallback\", {0});",GetAlbumsCallBack.ToString());		
			//ActionScript.Statement("ExternalInterface.call(\"SocialWrapper.getAlbums\"");		
		#else
		#endif
	}
	
	// Update is called once per frame
	void Update () {
	
	}
	
	public void GetAlbumsCallBack(Object data) {
		Debug.Log(data);
	}
	//*/
	
	delegate void SimpleCallback();
	
	
	
	[NotRenamed]
	public SocialNetwork() {
		
	}
	
	[NotRenamed]
	public static SocialNetwork create(string aType) {
		SocialNetwork newObject = null;
#if UNITY_FLASH
ActionScript.Import("com.edde.temphook.VKontakteNetwork");
ActionScript.Import("com.edde.temphook.MyFunctionClass");
#endif
		switch (aType) 
		{
			case "VK": {
				newObject = new VKontakteNetwork();					
				break;
			}					
			/*
			case "OK": {
				newObject = new OdnoklassnikiNetwork();
				break;
			}					
			case "MM": {
				newObject = new MailRuNetwork();
				break;
			}
			//*/					
			default: {			
				break;
			}
		}
		//newObject.parent = aParent;
		
		return newObject;
	}
	
	[NotRenamed]
	public void saveWallPost(string type, string msg, Object id = null, string imgUrl = null) {
	}
	
	[NotRenamed]
	public void showRequestBox(string msg, Object id = null) {
		
	}
	
	[NotRenamed]
	public void buyOffer(string msg, double votes, string offer_id, string type, double money, MyFunctionClass callback) {
	}
	
	[NotRenamed]
	public void buyCoins(string msg, double votes, string action_id, string type, double money) {
	}
	
	
	[NotRenamed]
	public void loadFriendsPhotos(Object gamer, int i, Object ddtt) {
	}
	
	[NotRenamed]
	public void getOfferLead() {
		
	}
	
	[NotRenamed]
	public void showOfferLead(MyFunctionClass callback = null) {
		
	}
	
	[NotRenamed]
	public void createAlbum(MyFunctionClass callback) {
	}
	
	[NotRenamed]
	public void getAlbumsCallback(Object data) {			
	}
	
	[NotRenamed]
	public void createAlbumFromBack() {
	}
	
	[NotRenamed]
	public void createAlbumCallback(Object data) {
	}
	
	[NotRenamed]
	public void getUploadServerCallback(Object data) {		
	}
	
	[NotRenamed]
	public void sendScreenData(byte[] imageData) {
		//var ml:MultipartURLLoader = new MultipartURLLoader();
		//ml.addEventListener(Event.COMPLETE, onUploadFile);
		//ml.addFile(imageData, "file.jpg", "file1", "image/jpg");			
		//ml.load(upload_server);			
	}
	
	internal void onUploadFile(Event e) {
	}
	
	public void getTopUsersInfo(Object users) {
	}
	
	[NotRenamed]
	public void getMutualFriends() {
		
	}
	
	[NotRenamed]
	public void getFriendsInfo() {
		
	}
	
	[NotRenamed]
	public void addFriends() {
	}
}
