package uk.co.homletmoo.ld27
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Tweener;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld27.world.SplashWorld;
	
	[SWF (width = "800", height = "600", backgroundColor = "#c0c0c0")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine
	{
		public static var quake:Quake;
		
		public function Main():void
		{
			super(
				Display.WIDTH,
				Display.HEIGHT,
				Display.FRAME_RATE,
				Display.USE_FIXED_TIME
			);
			
			quake = new Quake();
			
			FP.console.enable();
			FP.console.toggleKey = Key.TAB;
		}
		
		override public function init():void
		{
//			Sound.initialize();
//			InputRegistry.register();
			
			FP.world = new SplashWorld();
		}
		
		override public function update():void
		{
			quake.update();
			
			super.update();
		}
	}
}
