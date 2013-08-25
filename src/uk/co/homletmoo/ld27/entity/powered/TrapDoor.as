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
	public class TrapDoor extends Entity implements PoweredEntity
	{
		private static const STATE_CLOSED:int = 0;
		private static const STATE_OPEN:int = 1;
		
		private var spriteMap:Spritemap;
		private var state:int;
		
		private var indicator:Indicator;
		
		
		public function TrapDoor( x:int, y:int, circuit:int, flipped:Boolean ) 
		{
			super( x - int( !flipped ) * ( 14 * Display.SCALE ), y );
			
			indicator = new Indicator(
				7 * Display.SCALE + int( flipped ) * ( 11 * Display.SCALE ),
				4 * Display.SCALE,
				circuit
			);
			addGraphic( indicator );
			
			layer = Layer.OBJECTS;
			
			spriteMap = new Spritemap( Assets.TRAPDOOR, 30, 16 );
			spriteMap.scale = Display.SCALE;
			
			if ( !flipped )
			{
				spriteMap.add( STATE_CLOSED.toString(), [0, 1], 4, false );
				spriteMap.add( STATE_OPEN.toString(), [2, 3], 4, false );
			} else
			{
				spriteMap.add( STATE_CLOSED.toString(), [4, 5], 4, false );
				spriteMap.add( STATE_OPEN.toString(), [6, 7], 4, false );
			}
			
			addGraphic( spriteMap );
			setHitbox(
				16 * Display.SCALE,
				3 * Display.SCALE,
				int( !flipped ) * -14 * Display.SCALE,
				0
			);
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