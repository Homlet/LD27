package uk.co.homletmoo.ld27.entity 
{
	import net.flashpunk.graphics.Spritemap;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.world.LevelWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Indicator extends Spritemap
	{
		private static const OFF:String = "off";
		private static const ON:String = "on";
		
		public function Indicator( x:int, y:int, circuit:int ) 
		{
			super( Assets.INDICATOR, 5, 5 );
			
			this.x = x;
			this.y = y;
			
			this.scale = Display.SCALE;
			
			add( OFF, [0] );
			
			switch( circuit )
			{
			case LevelWorld.YELLOW:
				add( ON, [1] );
				break;
				
			case LevelWorld.PURPLE:
				add( ON, [2] );
				break;
				
			case LevelWorld.GREEN:
				add( ON, [3] );
				break;
			}
		}
		
		public function setPowered( powered:Boolean ):void
		{			
			play( (powered) ? ON : OFF );
		}
	}
}