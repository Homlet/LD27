package uk.co.homletmoo.ld27.entity.powered 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Ease;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.entity.Indicator;
	import uk.co.homletmoo.ld27.entity.PoweredEntity;
	import uk.co.homletmoo.ld27.Helper;
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
		private var emitter:Emitter;
		
		public var angle:Number;
		public var angleRad:Number;
		
		
		public function Fan( x:int, y:int, circuit:int, rotation:int ) 
		{
			super( x, y );
			
			angle = rotation;
			angleRad = Helper.toRad( angle );
			
			indicator = new Indicator( 10 * Display.SCALE, 6 * Display.SCALE, circuit );
			indicator.originX = -2;
			indicator.originY = 2;
			indicator.x += indicator.originX * Display.SCALE;
			indicator.y += indicator.originY * Display.SCALE;
			indicator.angle = rotation;
			addGraphic( indicator );
			
			emitter = new Emitter( new BitmapData( Display.SCALE, Display.SCALE ), Display.SCALE, Display.SCALE );
			emitter.newType( "normal", [0] );
			emitter.setAlpha( "normal", 1.0, 0.0, Ease.expoOut );
			emitter.setMotion( "normal", rotation + 180, 56 * Display.SCALE, 2.0, 0, 8 * Display.SCALE, 1.0, Ease.expoOut );
			addGraphic( emitter );
			
			layer = Layer.OBJECTS;
			
			spriteMap = new Spritemap( Assets.FAN, 16, 27 );
			spriteMap.scale = Display.SCALE;
			spriteMap.add( STATE_OFF.toString(), [0] );
			spriteMap.add( STATE_ON.toString(), [1, 2, 3], 8 );
			spriteMap.originX = 8;
			spriteMap.originY = 8;
			spriteMap.x = spriteMap.originX * Display.SCALE;
			spriteMap.y = spriteMap.originY * Display.SCALE;
			spriteMap.angle = rotation;
			
			addGraphic( spriteMap );
			
			var hit:Hitbox;
			if ( Math.floor( angle / 90 ) % 2 == 0 )
			{
				hit = new Hitbox(
					 64 * Display.SCALE,
					 16 * Display.SCALE,
					-64 * Display.SCALE,
					 0
				);
				
				if ( angle / 180 >= 1 )
					hit.x = 16 * Display.SCALE;
				
				mask = hit;
			} else
			{
				hit = new Hitbox(
					 16 * Display.SCALE,
					 64 * Display.SCALE,
					 0,
					-64 * Display.SCALE
				);
				
				if ( angle / 90 <= 1 )
					hit.y = 16 * Display.SCALE;
				
				mask = hit;
			}
		}
		
		override public function update():void
		{
			if ( Math.random() > 0.6 && state == STATE_ON )
			{
				switch( angle )
				{
				case 0:
					emitter.emit(
						"normal",
						Math.random() * ( 16 * Display.SCALE ) * Math.sin( angleRad ),
						Math.random() * ( 16 * Display.SCALE ) * Math.cos( angleRad )
					);
					break;
					
				case 90:
					emitter.emit(
						"normal",
						Math.random() * ( 16 * Display.SCALE ) * Math.sin( angleRad ),
						( 16 * Display.SCALE ) +
						Math.random() * ( 16 * Display.SCALE ) * Math.cos( angleRad )
					);
					break;
					
				case 180:
					emitter.emit(
						"normal",
						( 16 * Display.SCALE ) +
						Math.random() * ( 16 * Display.SCALE ) * Math.sin( angleRad ),
						( 16 * Display.SCALE ) +
						Math.random() * ( 16 * Display.SCALE ) * Math.cos( angleRad )
					);
					break;
					
				case 270:
					emitter.emit(
						"normal",
						( 16 * Display.SCALE ) +
						Math.random() * ( 16 * Display.SCALE ) * Math.sin( angleRad ),
						Math.random() * ( 16 * Display.SCALE ) * Math.cos( angleRad )
					);
					break;
				}
			}
			
			super.update();
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
