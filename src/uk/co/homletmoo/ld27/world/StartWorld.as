package uk.co.homletmoo.ld27.world 
{
	import flash.display.BlendMode;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.Main;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class StartWorld extends World
	{
		private var bg:Image;
		private var glare:Image;
		
		public function StartWorld()
		{
			bg = new Image( Assets.START );
			bg.alpha = 0;
			bg.scale = Display.SCALE;
			
			glare = new Image( Assets.GLARE );
			glare.alpha = 0;
			glare.scale = Display.SCALE;
			glare.blend = BlendMode.ADD;
			glare.x = Display.WIDTH / 2.0 - glare.scaledWidth / 2.0;
			glare.y = Display.HEIGHT / 2.0 - glare.scaledHeight / 2.0 - Display.SCALE * 8;
			
			addGraphic( bg );
			addGraphic( glare );
		}
		
		override public function begin():void
		{
			FP.tween( bg, { alpha: 1.0 }, 0.5 );
			FP.tween( glare, { alpha: 0.6 }, 0.5 );
		}
		
		override public function update():void
		{
			glare.alpha = Math.random() * 0.2 + 0.5;
			
			if ( Input.pressed( Key.ANY ) )
			{
				Main.levelManager.nextLevel();
				Main.startMusic();
			}
			
			super.update();
		}
	}
}
