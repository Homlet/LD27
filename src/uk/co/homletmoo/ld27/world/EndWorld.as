package uk.co.homletmoo.ld27.world 
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tweener;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.entity.LevelManager;
	import uk.co.homletmoo.ld27.Main;
	import uk.co.homletmoo.ld27.Time;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class EndWorld extends World
	{
		private var bg:Image;
		private var text:Text;
		
		public function EndWorld() 
		{
			FP.screen.x = 0;
			FP.screen.y = 0;
			
			bg = new Image( Assets.END );
			bg.alpha = 0.0;
			bg.scale = Display.SCALE;
			
			var minutes:int = Math.floor( Time.TIME / 60.0 );
			var seconds:int = Time.TIME % 60;
			
			text = new Text(
				"You completed the course in\n" +
				minutes + " minutes\n" +
				seconds + " seconds",
				0,
				0
			);
			text.scale = Display.SCALE;
			text.color = 0xFFFFFFFF;
			text.scrollX = text.scrollY = 0;
			text.size = 8;
			text.smooth = false;
			text.x = Display.WIDTH / 2.0 - int( text.scaledWidth / 4.0 );
			text.y = Display.HEIGHT / 2.0 - int( text.scaledHeight / 2.0 );
			text.alpha = 0.0;
			
			addGraphic( bg );
			addGraphic( text );	
		}
		
		override public function begin():void
		{
			Main.stopMusic();
			
			FP.tween( bg, { alpha: 1.0 }, 0.5 );
			FP.tween( text, { alpha: 0.5 }, 0.5 );
		}
		
		override public function update():void
		{
			if ( Input.pressed( Key.ANY ) )
			{
				Time.reset();
				Main.levelManager.reset();
				
				Main.levelManager.nextLevel();
				Main.startMusic();
			}
			
			super.update();
		}
		
	}

}