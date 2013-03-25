using UnityEngine;
using System.Collections;

#if UNITY_FLASH
using UnityEngine.Flash;
#endif

public enum MouseActionWithObjects { NoAction = 0, MoveObject = 1, RotateObject = 2, DeleteObject = 3, MoveToStoreObject = 4 }

public class MainDispatcher : MonoBehaviour {

	public static MouseActionWithObjects actionType = MouseActionWithObjects.NoAction;

	public static SocialNetwork currentSocialNetwork;
	public static MainDispatcher instance = null;

	void Awake() {
		if (instance == null) {
#if UNITY_FLASH
ActionScript.Import("com.edde.temphook.SocialNetwork");
			instance = this;
			currentSocialNetwork = SocialNetwork.create("VK");
#endif
			instance = this;
			currentSocialNetwork = SocialNetwork.create("VK");
			#if UNITY_FLASH
			#elif UNITY_EDITOR
			MyDateTime.CheckMinValue();
			#else
			MyDateTime.CheckMinValue();
			#endif
		}
	}
	
	void Start () {
		if (instance == null) {
			instance = this;
		}
	}

	public static void SendMessageToSocial(string type, MyFunctionDataClass callback) {
		if (type == "get_friends") {
			currentSocialNetwork.getMutualFriends(callback);
		}
	}

	public static void ReturnMessageFromSocial(UnityEngine.Object data) {
		Debug.Log("return + " + data);
	}
}