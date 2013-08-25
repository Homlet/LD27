package uk.co.homletmoo.ld27.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.Layer;
	import uk.co.homletmoo.ld27.Sound;
	import uk.co.homletmoo.ld27.world.LevelWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Toggle extends Entity
	{
		private static const UP:String = "up";
		private static const LIT:String = "lit";
		private static const DOWN:String = "down";
		
		public var circuit:int;
		public var powered:Boolean = false;
		
		private var isDown:Boolean = false;
		
		private var spriteMap:Spritemap;
		
		public function Toggle( x:int, y:int, circuit:int ) 
		{
			super( x, y + 13 * Display.SCALE );
			
			layer = Layer.OBJECTS;
			type = Layer.C_TOGGLE;
			
			spriteMap = new Spritemap( Assets.TOGGLE, 16, 3 );
			spriteMap.scale = Display.SCALE;
			
			if ( circuit == LevelWorld.PURPLE )
			{
				spriteMap.add( UP, [0] );
				spriteMap.add( LIT, [1] );
				spriteMap.add( DOWN,  [2] );
			} else if ( circuit == LevelWorld.GREEN )
			{
				spriteMap.add( UP, [3] );
				spriteMap.add( LIT, [4] );
				spriteMap.add( DOWN,  [5] );
			}
			spriteMap.play( UP );
			
			this.circuit = circuit;
			
			addGraphic( spriteMap );
			setHitbox(
				12 *  Display.SCALE,
				 2 *  Display.SCALE,
				 2 * -Display.SCALE,
				     -Display.SCALE
			);
		}
		
		override public function update():void
		{
			if ( isDown && collide( Layer.C_PLAYER, x, y ) == null )
			{
				isDown = false;
				
				Sound.B_UP.play( 0.25 );
				up();
			}
		}
		
		public function down():void
		{
			if ( !isDown )
			{
				isDown = true;
				
				Sound.B_DOWN.play( 0.5 );
				spriteMap.play( DOWN );
			}
		}
		
		public function up():void
		{
			powered = !powered;
			
			spriteMap.play( (powered) ? LIT : UP );
		}
	}
}