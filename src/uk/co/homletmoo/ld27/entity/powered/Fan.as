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
	public class Fan extends Entity implements PoweredEntity
	{
		private static const STATE_OFF:int = 0;
		private static const STATE_ON:int = 1;
		
		private var spriteMap:Spritemap;
		private var state:int;
		
		private var indicator:Indicator;
		
		
		public function Fan( x:int, y:int, circuit:int ) 
		{
			super( x, y );
			
			indicator = new Indicator( 10 * Display.SCALE, 6 * Display.SCALE, circuit );
			addGraphic( indicator );
			
			layer = Layer.OBJECTS;
			
			spriteMap = new Spritemap( Assets.FAN, 16, 27 );
			spriteMap.scale = Display.SCALE;
			spriteMap.add( STATE_OFF.toString(), [0] );
			spriteMap.add( STATE_ON.toString(), [1, 2, 3], 8 );
			
			addGraphic( spriteMap );
			setHitbox( 64 * Display.SCALE, 16 * Display.SCALE, 64 * Display.SCALE, 0 );
		}
		
		public function setPowered( powered:Boolean ):void
		{
			state = (powered) ? STATE_ON : STATE_OFF;
			type = (powered) ? Layer.C_FAN : null;
			
			indicator.setPowered( powered );
			
			spriteMap.play( state.toString() );
		}
	}
}
