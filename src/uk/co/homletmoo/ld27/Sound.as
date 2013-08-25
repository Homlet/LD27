package uk.co.homletmoo.ld27 
{
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Sound 
	{
		[Embed (source = "res/exit.mp3")] public static const EXIT_RAW:Class;
		public static var EXIT:Sfx;
		
		[Embed (source = "res/hurt.mp3")] public static const HURT_RAW:Class;
		public static var HURT:Sfx;
		
		[Embed (source = "res/jump.mp3")] public static const JUMP_RAW:Class;
		public static var JUMP:Sfx;
		
		[Embed (source = "res/power_off.mp3")] public static const P_OFF_RAW:Class;
		public static var P_OFF:Sfx;
		
		[Embed (source = "res/power_on.mp3")] public static const P_ON_RAW:Class;
		public static var P_ON:Sfx;
		
		[Embed (source = "res/switch.mp3")] public static const SWITCH_RAW:Class;
		public static var SWITCH:Sfx;
		
		[Embed (source = "res/button_down.mp3")] public static const B_DOWN_RAW:Class;
		public static var B_DOWN:Sfx;
		
		[Embed (source = "res/button_up.mp3")] public static const B_UP_RAW:Class;
		public static var B_UP:Sfx;
		
		[Embed (source = "music/intro.mp3")] public static const INTRO_RAW:Class;
		[Embed (source = "music/loop.mp3")] public static const LOOP_RAW:Class;
		public static var INTRO:Sfx;
		public static var LOOP:Sfx;
		
		
		public static function initialize():void
		{
			EXIT = new Sfx( EXIT_RAW );
			HURT = new Sfx( HURT_RAW );
			JUMP = new Sfx( JUMP_RAW );
			P_OFF = new Sfx( P_OFF_RAW );
			P_ON = new Sfx( P_ON_RAW );
			SWITCH = new Sfx( SWITCH_RAW );
			B_DOWN = new Sfx( B_DOWN_RAW );
			B_UP = new Sfx( B_UP_RAW );
			INTRO = new Sfx( INTRO_RAW, musicLoop );
			LOOP = new Sfx( LOOP_RAW );
		}
		
		private static function musicLoop():void
		{
			LOOP.loop( 0.6 );
		}
	}

}