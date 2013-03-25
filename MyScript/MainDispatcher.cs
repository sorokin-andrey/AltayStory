using UnityEngine;
using System.Collections;

#if UNITY_FLASH
using UnityEngine.Flash;
#endif

public enum MouseActionWithObjects { NoAction = 0, MoveObject = 1, RotateObject = 2, DeleteObject = 3, MoveToStoreObject = 4 }

public class MainDispatcher : MonoBehaviour {

	public static MouseActionWithObjects actionType = MouseActionWithObjects.NoAction;

	//Move object
	float spring = 1000.0f;
	float damper = 1.0f;
	float drag = 1.0f;
	float angularDrag = 1000f;
	float distance = 0.002f;
	bool attachToCenterOfMass = false;
	private SpringJoint springJoint;
	public static Vector3 defaultVector3 = Vector3.zero;//Vector3(0,0,0);
	public static SocialNetwork currentSocialNetwork;
	//private static Random random = new Random();
	
	void Awake() {
		if (instance == null) {
#if UNITY_FLASH
ActionScript.Import("com.edde.temphook.SocialNetwork");
#endif
			instance = this;
			currentSocialNetwork = SocialNetwork.create("VK");
			#if UNITY_FLASH
			#elif UNITY_EDITOR
			MyDateTime.CheckMinValue();
			#else
			MyDateTime.CheckMinValue();
			#endif
			actionStorage = gameObject.AddComponent<ActionStorage>();
			actionStorage.SendToServer();
		}
	}
	
	void Start () {
		if (instance == null) {
			instance = this;
		}
	}
}