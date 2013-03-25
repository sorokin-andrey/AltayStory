using UnityEngine;
using System.Collections;
using System;
using UnityEngine.Flash;

[NotConverted]
[NotRenamed] 
public class MyFunctionClass {//: Object {
	#if UNITY_FLASH
	//#elif UNITY_EDITOR
	//delegate void SimpleCallback();
	//public SimpleCallback simpleCallback;
	#else
	delegate void SimpleCallback();
	private SimpleCallback simpleCallback;
	#endif
	
	[NotRenamed] 
	MyFunctionClass() {
	}
	
	[NotRenamed] 
	public void Callback() {
		#if UNITY_FLASH
		
		#elif UNITY_EDITOR
		
		if (simpleCallback != null) {
			simpleCallback();
		}
		
		#else
		if (simpleCallback != null) {
			simpleCallback();
		}
		#endif
	}
}
