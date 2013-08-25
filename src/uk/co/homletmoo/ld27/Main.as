package uk.co.homletmoo.ld27
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Tweener;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld27.entity.LevelManager;
	import uk.co.homletmoo.ld27.world.LevelWorld;
	import uk.co.homletmoo.ld27.world.SplashWorld;
	import uk.co.homletmoo.ld27.world.StartWorld;
	
	[SWF (width = "800", height = "600", backgroundColor = "#000000")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine
	{
		public static var quake:Quake;
		
		public static var levelManager:LevelManager;
		
		public var isPaused:Boolean = false;
		public var isMuted:Boolean = false;
		
		public static var introComplete:Boolean = false;
		
		public static var pauseFader:DisplayObject;
		
		
		public function Main():void
		{
			super(
				Display.WIDTH,
				Display.HEIGHT,
				Display.FRAME_RATE,
				Display.USE_FIXED_TIME
			);
			
			quake = new Quake();
			
			FP.screen.color = 0xFF000000;
			FP.screen.originX = Display.WIDTH / 2.0;
			FP.screen.originY = Display.HEIGHT / 2.0;
			
			pauseFader = new Bitmap( new BitmapData( Display.WIDTH, Display.HEIGHT, true, 0x88000000 ) );
			addChild( pauseFader );
			
//			FP.console.enable();
			FP.console.toggleKey = Key.TAB;
		}
		
		override public function init():void
		{
			Sound.initialize();
			InputRegistry.register();
			
			levelManager = new LevelManager();
		
			FP.world = new SplashWorld();
		}
		
		override public function update():void
		{
			quake.update();
			levelManager.update();
			
			if ( !( FP.world is LevelWorld ) )
			{
				isMuted = false;
			} else  if ( Input.pressed( InputRegistry.MUTE ) )
			{
				if ( !isMuted )
				{
					if ( !isPaused )
						stopMusic();
					isMuted = true;
				} else
				{
					if ( !isPaused )
						resumeMusic();
					isMuted = false;
				}
			}
			
			if ( !( FP.world is LevelWorld ) )
			{
				isPaused = false;
				pauseFader.visible = false;
			} else if ( Input.pressed( InputRegistry.PAUSE ) )
			{
				if ( !isPaused )
				{
					Sound.JUMP.play( 0.4 );
					FP.world.active = false;
					
					if ( !isMuted )
						stopMusic();
					
					isPaused = true;
					pauseFader.visible = true;
				} else
				{
					Sound.JUMP.play( 0.4 );
					FP.world.active = true;
					
					if ( !isMuted )
						resumeMusic();
					
					isPaused = false;
					pauseFader.visible = false;
				}
			} else if ( isPaused )
			{
				FP.world.active = false;
			}
			
			super.update();
		}
		
		public static function startMusic():void
		{
			Sound.LOOP.stop();
			Sound.INTRO.play( 0.6 );
		}
		
		public static function stopMusic():void
		{
			if ( Sound.INTRO.playing )
			{
				Sound.INTRO.stop();
				introComplete = false;
			} else
			{
				Sound.LOOP.stop();
				introComplete = true;
			}
		}
		
		public static function resumeMusic():void
		{
			if ( introComplete )
				Sound.LOOP.resume();
			else
				Sound.INTRO.resume();
		}
	}
}
