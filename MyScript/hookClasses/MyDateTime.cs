using UnityEngine;
using System.Collections;
using System;
#if UNITY_FLASH
using UnityEngine.Flash;
#endif

[NotConverted]
[NotRenamed] 
public class MyDateTime {//: Object {
	public double timestamp;
	#if UNITY_FLASH
	#elif UNITY_EDITOR
	private static long minValue = 0;
	#else
	private static long minValue = 0;
	#endif
	
	[NotRenamed] 
	MyDateTime() {
		timestamp = 0;
		//#if UNITY_FLASH
		//ActionScript.Import("com.edde.temphook.MyDateTimeA");
		//#endif
	}
	
	public static void CheckMinValue() {
		#if UNITY_FLASH
		#elif UNITY_EDITOR
		if (minValue == 0) {
			DateTime dt = new DateTime(2010, 1, 1);
			minValue = dt.Ticks;
		}
		#else
		if (minValue == 0) {
			DateTime dt = new DateTime(2010, 1, 1);
			minValue = dt.Ticks;
		}
		#endif
	}
	
	[NotRenamed] 
	public static double Now() {
		double result = 1;
		#if UNITY_FLASH
		//return 1;
		//float temp;
		//ActionScript.Statement("navigateToURL(new URLRequest({0}), '_self');",url);
 		//result = System.Convert.ToInt32(
		//result = Mathf.RoundToInt(temp);

		//result = ActionScript.Expression<int>("MyDateTimeA.Now()");
		#elif UNITY_EDITOR
		DateTime dt = DateTime.Now;
		result = (dt.Ticks-minValue) / 10000;//Mathf.RoundToInt((dt.Ticks-minValue) / 10000);
		#else
		
		DateTime dt = DateTime.Now;
		result = (dt.Ticks-minValue) / 10000;//Mathf.RoundToInt((dt.Ticks-minValue) / 10000);
		#endif
		//Debug.Log("time"+((dt.Ticks-minValue) / 10000000).ToString());
		return result;
	}
	/*
	public void SetNow(){
		DateTime dt = DateTime.Now;
		timestamp = 0;//dt.Ticks;// TotalMilliseconds();
	}
	//*/
	[NotRenamed] 
	public int CompareTo(MyDateTime aDateTime) {
		////#if UNITY_FLASH
		if (timestamp < aDateTime.timestamp) {
			return -1;
		} else if (timestamp == aDateTime.timestamp) {
			return 0;
		} else {
			return 1;
		}
		//#else
		
		//#endif
	}
}
