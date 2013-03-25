using UnityEngine;
using System.Collections;
using System;
using UnityEngine.Flash;

[NotConverted]
[NotRenamed] 
public class MyFunctionDataClass {//: Object {
	#if UNITY_FLASH
	//#elif UNITY_EDITOR
	//delegate void SimpleCallback();
	//public SimpleCallback simpleCallback;
	#else
	public delegate void SimpleCallback(UnityEngine.Object data);
	public SimpleCallback simpleCallback;
	#endif
	
	[NotRenamed] 
	MyFunctionDataClass() {
	}
	
	[NotRenamed] 
	public void Callback(UnityEngine.Object data) {
		#if UNITY_FLASH
		
		#elif UNITY_EDITOR
		
		if (simpleCallback != null) {
			simpleCallback(data);
		}
		
		#else
		if (simpleCallback != null) {
			simpleCallback(data);
		}
		#endif
	}
}
