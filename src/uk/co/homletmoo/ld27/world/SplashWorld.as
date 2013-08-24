package uk.co.homletmoo.ld27.world 
{
	import com.greensock.TweenLite;
	import com.greensock.TimelineLite;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.World;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class SplashWorld extends World
	{
		private var hmLogo:Image;
		private var fpLogo:Spritemap;
		
		public function SplashWorld()
		{
			hmLogo = new Image( Assets.HM_LOGO );
			hmLogo.scale = Display.SCALE * 2;
			hmLogo.x = ( FP.width / 2 ) - ( hmLogo.scaledWidth / 2 );
			hmLogo.y = ( FP.height / 2 ) - ( hmLogo.scaledHeight / 2 );
			hmLogo.alpha = 0;
			
			fpLogo = new Spritemap( Assets.FP_LOGO, 100, 100 );
			fpLogo.scale = Display.SCALE;
			fpLogo.y = FP.height - fpLogo.scaledHeight;
			fpLogo.add( "run", [0, 1, 2, 3, 4], 8, true );
			fpLogo.play( "run" );
			fpLogo.alpha = 0;
			
			addGraphic( hmLogo );
			addGraphic( fpLogo );
		}
		
		override public function begin():void
		{
			registerTweens();
		}
		
		override public function update():void
		{
			super.update();
		}
		
		private function registerTweens():void
		{
			var t:TimelineLite = new TimelineLite();
			
			t.to( hmLogo, 1.0, { alpha: 1.0 } );
			t.to( hmLogo, 1.0, { alpha: 0.0, delay: 1.5 } );
			
			t.to( fpLogo, 1.0, { alpha: 1.0 } );
			t.to( fpLogo, 1.0, { alpha: 0.0, delay: 1.5 } );
		}
	}
}
