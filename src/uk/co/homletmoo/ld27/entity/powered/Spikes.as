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
	public class Spikes extends Entity implements PoweredEntity
	{
		private static const STATE_IN:int = 0;
		private static const STATE_OUT:int = 1;
		
		private var spriteMap:Spritemap;
		private var state:int;
		
		private var indicator:Indicator;
		
		
		public function Spikes( x:int, y:int, circuit:int ) 
		{
			super( x, y );
			
			indicator = new Indicator( 4 * Display.SCALE, 21 * Display.SCALE, circuit );
			addGraphic( indicator );
			
			layer = Layer.OBJECTS;
			
			spriteMap = new Spritemap( Assets.SPIKES, 16, 27 );
			spriteMap.scale = Display.SCALE;
			spriteMap.add( STATE_IN.toString(), [0, 1], 4, false );
			spriteMap.add( STATE_OUT.toString(), [2, 3], 4, false );
			
			addGraphic( spriteMap );
			setHitbox( 16 * Display.SCALE, 10 * Display.SCALE, 0, -6 * Display.SCALE );
		}
		
		public function setPowered( powered:Boolean ):void
		{
			state = (powered) ? STATE_OUT : STATE_IN;
			type = (powered) ? Layer.C_HAZARD : null;
			
			indicator.setPowered( powered );
			
			spriteMap.play( state.toString() );
		}
	}
}