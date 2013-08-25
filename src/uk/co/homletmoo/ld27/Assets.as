package uk.co.homletmoo.ld27 
{
	import flash.display.Bitmap;
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
		[Embed (source = "res/HMV2.png")]
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
		
		[Embed (source = "res/exit.png")]
		public static const EXIT_RAW:Class;
		public static const EXIT:BitmapData = FP.getBitmap( EXIT_RAW );
		
		[Embed (source = "res/indicator.png")]
		public static const INDICATOR_RAW:Class;
		public static const INDICATOR:BitmapData = FP.getBitmap( INDICATOR_RAW );
		
		[Embed (source = "res/toggles.png")]
		public static const TOGGLE_RAW:Class;
		public static const TOGGLE:BitmapData = FP.getBitmap( TOGGLE_RAW );
		
		[Embed (source = "res/glare.png")]
		public static const GLARE_RAW:Class;
		public static const GLARE:BitmapData = FP.getBitmap( GLARE_RAW );
		
		[Embed (source = "res/start.png")]
		public static const START_RAW:Class;
		public static const START:BitmapData = FP.getBitmap( START_RAW );
		
		// Ogmo
		[Embed (source = "ogmo/level_001.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_001:Class;
		[Embed (source = "ogmo/level_002.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_002:Class;
		[Embed (source = "ogmo/level_003.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_003:Class;
		[Embed (source = "ogmo/level_004.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_004:Class;
		[Embed (source = "ogmo/level_005.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_005:Class;
		[Embed (source = "ogmo/level_006.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_006:Class;
		[Embed (source = "ogmo/level_007.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_007:Class;
		[Embed (source = "ogmo/level_008.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_008:Class;
		[Embed (source = "ogmo/level_009.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_009:Class;
		[Embed (source = "ogmo/level_010.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_010:Class;
		[Embed (source = "ogmo/level_011.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_011:Class;
		[Embed (source = "ogmo/level_012.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_012:Class;
		[Embed (source = "ogmo/level_013.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_013:Class;
		[Embed (source = "ogmo/level_014.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_014:Class;
		[Embed (source = "ogmo/level_015.oel", mimeType = "application/octet-stream" )]
		public static const OGMO_LEVEL_015:Class;
	}
}