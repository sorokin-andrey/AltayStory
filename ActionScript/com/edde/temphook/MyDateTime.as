package com.edde.temphook
{
	public class MyDateTime
	{
		public var timestamp:Number;

		public function MyDateTime() 
		{
			timestamp = 0;
		}

		public static function Now():Number
		{
			var result:Number = (new Date()).getTime();
			return result;
		}

		public function CompareTo(aDateTime:MyDateTime):int
		{
			if (timestamp < aDateTime.timestamp) {
				return -1;
			} else if (timestamp == aDateTime.timestamp) {
				return 0;
			} else {
				return 1;
			}			
		}
	}
}