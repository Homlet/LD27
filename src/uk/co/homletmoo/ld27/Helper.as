package uk.co.homletmoo.ld27 
{
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Helper 
	{
		public static function toRad( degrees:Number ):Number
		{
			return degrees / 360 * Math.PI * 2;
		}
		
		public static function zeroPad( n:int, width:int ):String
		{
			var str:String = "" + n;
			
			while ( str.length < width )
				str = "0" + str;
			
			return str;
		}
	}
}