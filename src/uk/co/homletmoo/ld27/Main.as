package uk.co.homletmoo.ld27
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Tweener;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld27.entity.LevelManager;
	
	[SWF (width = "800", height = "600", backgroundColor = "#000000")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine
	{
		public static var quake:Quake;
		
		public static var levelManager:LevelManager;
		
		
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
			
			FP.console.enable();
			FP.console.toggleKey = Key.TAB;
		}
		
		override public function init():void
		{
//			Sound.initialize();
//			InputRegistry.register();

			levelManager = new LevelManager();
		}
		
		override public function update():void
		{
			quake.update();
			levelManager.update();
			
			super.update();
		}
	}
}
