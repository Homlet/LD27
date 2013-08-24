package uk.co.homletmoo.ld27.entity 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Const;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.entity.powered.Door;
	import uk.co.homletmoo.ld27.entity.powered.TrapDoor;
	import uk.co.homletmoo.ld27.Layer;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Player extends Entity 
	{
		private static const A_STATIONARY:String = "s";
		private static const A_RUN_LEFT:String   = "l";
		private static const A_RUN_RIGHT:String  = "r";
		private static const A_JUMP:String       = "j";
		private static const A_FALL:String       = "f";
		
		private static const SPEED:Number = 300.0;
		private static const JUMP_SPEED:Number = 450.0;
		private static const ACCEL:Number = 500.0;
		
		private var startPos:Point;
		
		private var spriteMap:Spritemap;
		private var wallTimer:Number;
		private var onGround:Boolean;
		
		private var velocity:Point;
		private var acceleration:Point;
		
		
		public function Player( x:int, y:int ) 
		{
			super( x, y );
			
			startPos = new Point( x, y );
			
			spriteMap = new Spritemap( Assets.PLAYER, 9, 14 );
			spriteMap.scale = Display.SCALE;
			spriteMap.add( A_STATIONARY, [0, 1, 0], 0.9 );
			spriteMap.add( A_RUN_RIGHT, [2, 3, 4, 5], 6 );
			spriteMap.add( A_RUN_LEFT, [6, 7, 8, 9], 6 );
			spriteMap.play( A_STATIONARY );
			
			velocity = new Point();
			acceleration = new Point();
			
			layer = Layer.PLAYER;
			
			addGraphic( spriteMap );
			setHitbox( 5 * Display.SCALE, 12 * Display.SCALE, -2 * Display.SCALE, -2 * Display.SCALE );
		}
		
		override public function update():void
		{
			acceleration = new Point();
			
			onGround = collide( Layer.C_LEVEL, x, y + 1 ) != null;
			
			if ( collide( Layer.C_HAZARD, x, y ) != null )
			{
				return;
			}
			
			acceptInput();
			
			// Accelerate
			velocity.x += acceleration.x * FP.elapsed;
			velocity.y += acceleration.y * FP.elapsed;
			
			// Gravity
			velocity.y += Const.GRAVITY * FP.elapsed;
			
			// Limit velocity
			if ( Math.abs( velocity.x ) > SPEED )
				velocity.x = SPEED * ( velocity.x / Math.abs( velocity.x ) );
			
			if ( acceleration.x == 0 && acceleration.y == 0 )
				velocity.x = 0;
			
			{
				var e:Entity = collide( Layer.C_LEVEL, x, y );
				
				if ( e is Door 
				 && collideWith( e, x - 1, y ) )
					x -= SPEED * FP.elapsed;
				
				if ( e is TrapDoor
				 && collideWith( e, x, y - 1 ) )
					y -= SPEED * FP.elapsed;
			}
			
			// Move
			moveBy(
				velocity.x * FP.elapsed,
				velocity.y * FP.elapsed,
				Layer.C_LEVEL
			);
			
			setAnimation();
			
			super.update();
			
			FP.world.camera.x = x - Display.WIDTH / 2.0;
			FP.world.camera.y = y - Display.HEIGHT / 2.0;
		}
		
		override public function moveCollideX( e:Entity ):Boolean
		{
			velocity.x = 0;
			
			wallTimer = 0.2;
			
			return true;
		}
		
		override public function moveCollideY( e:Entity ):Boolean
		{
			velocity.y = 0;
			
			return true;
		}
		
		private function acceptInput():void
		{
			if ( Input.pressed( Key.W ) && onGround )
				velocity.y = -JUMP_SPEED;
				
			if ( Input.check( Key.A ) )
				acceleration.x -= ACCEL;
				
			if ( Input.check( Key.D ) )
				acceleration.x += ACCEL;
		}
		
		private function setAnimation():void
		{
			wallTimer -= FP.elapsed;
			
			if ( wallTimer > 0 )
			{
				spriteMap.play( A_STATIONARY );
				return;
			}
			
			if ( velocity.x != 0 )
				if ( velocity.x < 0 )
					spriteMap.play( A_RUN_LEFT );
				else
					spriteMap.play( A_RUN_RIGHT );
			else
				spriteMap.play( A_STATIONARY );
			
		}
	}
}
