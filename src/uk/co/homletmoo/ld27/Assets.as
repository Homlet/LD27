package uk.co.homletmoo.ld27 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Assets 
	{
		public static function scaleGraphic( img:*, sf:uint ):BitmapData
		{
			var bit:BitmapData = FP.getBitmap( img );
			
			var width:int  = ( bit.width * sf  ) || 1;
			var height:int = ( bit.height * sf ) || 1;
			
			var result:BitmapData = new BitmapData( width, height, true, 0 );
			var matrix:Matrix = new Matrix();
			matrix.scale( sf, sf );
			result.draw( bit, matrix );
			
			return result;
		}
		
		// Graphics
		[Embed (source = "res/HMV4.png")]
		public static const HM_LOGO_RAW:Class;
		public static const HM_LOGO:BitmapData = FP.getBitmap( HM_LOGO_RAW );
		
		[Embed (source = "res/flashpunk.png")]
		public static const FP_LOGO_RAW:Class;
		public static const FP_LOGO:BitmapData = FP.getBitmap( FP_LOGO_RAW );
		
		[Embed (source = "res/clock_face.png")]
		public static const CLOCK_FACE_RAW:Class;
		public static const CLOCK_FACE:BitmapData = FP.getBitmap( CLOCK_FACE_RAW );
		
		[Embed (source = "res/clock_hand.png")]
		public static const CLOCK_HAND_RAW:Class;
		public static const CLOCK_HAND:BitmapData = FP.getBitmap( CLOCK_HAND_RAW );
		
		[Embed (source = "res/base_tiles.png")]
		public static const BASE_TILES_RAW:Class;
		
		[Embed (source = "res/player.png")]
		public static const PLAYER_RAW:Class;
		public static const PLAYER:BitmapData = FP.getBitmap( PLAYER_RAW );
		
		[Embed (source = "res/door.png")]
		public static const DOOR_RAW:Class;
		public static const DOOR:BitmapData = FP.getBitmap( DOOR_RAW );
		
		[Embed (source = "res/trapdoor.png")]
		public static const TRAPDOOR_RAW:Class;
		public static const TRAPDOOR:BitmapData = FP.getBitmap( TRAPDOOR_RAW );
		
		[Embed (source = "res/fan.png")]
		public static const FAN_RAW:Class;
		public static const FAN:BitmapData = FP.getBitmap( FAN_RAW );
		
		[Embed (source = "res/spikes.png")]
		public static const SPIKES_RAW:Class;
		public static const SPIKES:BitmapData = FP.getBitmap( SPIKES_RAW );
		
		[Embed (source = "res/vignette.png")]
		public static const VIGNETTE_RAW:Class;
		public static const VIGNETTE:BitmapData = FP.getBitmap( VIGNETTE_RAW );
		
		// Ogmo
		[Embed (source = "ogmo/level_01.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_01:Class;
		[Embed (source = "ogmo/level_02.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_02:Class;
	}
}