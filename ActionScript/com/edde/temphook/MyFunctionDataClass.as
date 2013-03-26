package com.edde.temphook
{
	public class MyFunctionDataClass
	{
		public var callback:Function;

		public function MyFunctionDataClass() 
		{
		}

		public function Callback(data:Object):void
		{
			callback(data);
		}
	}
}