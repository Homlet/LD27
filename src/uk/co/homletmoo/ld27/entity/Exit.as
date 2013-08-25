package uk.co.homletmoo.ld27.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.Layer;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Exit extends Entity
	{
		private var spriteMap:Spritemap;
		
		public function Exit( x:int, y:int ) 
		{
			super( x, y );
			
			layer = Layer.OBJECTS;
			type = Layer.C_EXIT;
			
			spriteMap = new Spritemap( Assets.EXIT, 16, 16 );
			spriteMap.scale = Display.SCALE;
			spriteMap.add( "run", [0, 1, 2, 1], 4 );
			spriteMap.play( "run" );
			
			addGraphic( spriteMap );
			setHitbox(
				  6 * Display.SCALE,
				  2 * Display.SCALE,
				 -5 * Display.SCALE,
				-14 * Display.SCALE
			);
		}
	}
}
