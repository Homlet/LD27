package uk.co.homletmoo.ld27.entity.powered 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.entity.Indicator;
	import uk.co.homletmoo.ld27.entity.PoweredEntity;
	import uk.co.homletmoo.ld27.Layer;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Door extends Entity implements PoweredEntity
	{
		private static const STATE_CLOSED:int = 0;
		private static const STATE_OPEN:int = 1;
		
		private var spriteMap:Spritemap;
		private var state:int;
		
		private var indicator:Indicator;
		
		
		public function Door( x:int, y:int, circuit:int ) 
		{
			super( x, y - 14 * Display.SCALE );
			
			indicator = new Indicator( 3 * Display.SCALE, 4 * Display.SCALE, circuit );
			addGraphic( indicator );
			
			layer = Layer.OBJECTS;
			
			spriteMap = new Spritemap( Assets.DOOR, 10, 30 );
			spriteMap.scale = Display.SCALE;
			spriteMap.add( STATE_CLOSED.toString(), [0, 1], 4, false );
			spriteMap.add( STATE_OPEN.toString(), [2, 3], 4, false );
			
			addGraphic( spriteMap );
			setHitbox( 3 * Display.SCALE, 16 * Display.SCALE, 0, -14 * Display.SCALE );
		}
		
		public function setPowered( powered:Boolean ):void
		{
			state = (powered) ? STATE_OPEN : STATE_CLOSED;
			type = (powered) ? null : Layer.C_LEVEL;
			
			indicator.setPowered( powered );
			
			spriteMap.play( state.toString() );
		}
	}
}
