package com.edde.temphook
{
	public class MyFunctionClass
	{
		public var callback:Function;

		public function MyFunctionClass() 
		{
		}

		public function Callback():void
		{
			callback();
		}
	}
}