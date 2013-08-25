package uk.co.homletmoo.ld27.entity 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Tween;
	import net.flashpunk.Tweener;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Const;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.entity.powered.Door;
	import uk.co.homletmoo.ld27.entity.powered.Fan;
	import uk.co.homletmoo.ld27.entity.powered.TrapDoor;
	import uk.co.homletmoo.ld27.Layer;
	import uk.co.homletmoo.ld27.Main;
	import uk.co.homletmoo.ld27.world.LevelWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Player extends Entity 
	{
		private static const A_STATIONARY:String = "s";
		private static const A_RUN_LEFT:String   = "l";
		private static const A_RUN_RIGHT:String  = "r";
		private static const A_JUMP_RIGHT:String = "jr";
		private static const A_FALL_RIGHT:String = "fr";
		private static const A_JUMP_LEFT:String  = "jl";
		private static const A_FALL_LEFT:String  = "fl";
		
		private static const SPEED:Number = 300.0;
		private static const JUMP_SPEED:Number = 300.0;
		private static const ACCEL:Number = 500.0;
		
		private var startPos:Point;
		
		private var spriteMap:Spritemap;
		private var wallTimer:Number;
		private var onGround:Boolean;
		private var jumping:Boolean;
		private var jumpTimer:Number;
		private var ledgeTimer:Number;
		private var lastDirection:int = 1;
		
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
			spriteMap.add( A_JUMP_RIGHT, [10] );
			spriteMap.add( A_FALL_RIGHT, [11] );
			spriteMap.add( A_JUMP_LEFT, [12] );
			spriteMap.add( A_FALL_LEFT, [13] );
			spriteMap.play( A_STATIONARY );
			
			velocity = new Point();
			acceleration = new Point();
			
			layer = Layer.PLAYER;
			type = Layer.C_PLAYER
			
			addGraphic( spriteMap );
			setHitbox( 5 * Display.SCALE, 12 * Display.SCALE, -2 * Display.SCALE, -2 * Display.SCALE );
		}
		
		override public function update():void
		{
			acceleration = new Point();
			
			onGround = collide( Layer.C_LEVEL, x, y + 1 ) != null;
			
			if ( collide( Layer.C_HAZARD, x, y ) != null )
			{
				active = false;
				reset();
				return;
			}
			
			if ( onGround )
			{
				jumping = false;
				jumpTimer = 0.8;
			}
			
			acceptInput();
			
			if ( onGround )
				ledgeTimer = 0.3;
			else
			{
				if ( velocity.y < 0 )
					ledgeTimer = 0;
				else
					ledgeTimer -= FP.elapsed;
			}
			
			if ( jumping )
			{
				jumpTimer -= FP.elapsed;
				
				if ( jumpTimer <= 0 )
					jumping = false;
			}
			
			// Collide with things
			{
				var e:Entity = collide( Layer.C_LEVEL, x, y );
				
				if ( e is Door 
				 && collideWith( e, x - 1, y ) )
					x -= SPEED * FP.elapsed;
				
				if ( e is TrapDoor
				 && collideWith( e, x, y - 1 ) )
					y -= SPEED * FP.elapsed;
			}
			
			{
				e = collide( Layer.C_FAN, x, y );
				
				if ( e is Fan )
				{
					var reach:Number = ( 64 * Display.SCALE );
					var proximity:Number = reach - ( e.x - x );
					
					acceleration.x += -ACCEL * 5 * proximity / reach;
				}
			}
			
			{
				e = collide( Layer.C_TOGGLE, x, y );
				
				if ( e is Toggle )
				{
					(e as Toggle).down();
				}
			}
			
			{
				e = collide( Layer.C_EXIT, x, y );
				
				if ( e is Exit )
				{
					FP.world.active = false;
					
					Main.levelManager.exit();
					return;
				}
			}
			
			// Accelerate
			velocity.x += acceleration.x * FP.elapsed;
			velocity.y += acceleration.y * FP.elapsed;
			
			// Limit velocity
			if ( Math.abs( velocity.x ) > SPEED )
				velocity.x = SPEED * ( velocity.x / Math.abs( velocity.x ) );
			
			if ( acceleration.x == 0 && acceleration.y == 0 )
				velocity.x = 0;
			
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
		
		private function reset():void
		{
			Main.quake.start( 0.7, 0.4 );
			
			x = startPos.x;
			y = startPos.y;
			
			FP.tween(
				FP.world.camera,
				{
					x: startPos.x - Display.WIDTH / 2.0,
					y: startPos.y - Display.HEIGHT / 2.0
				},
				0.5,
				{ complete: toggleActive }
			);
		}
		
		private function toggleActive():void
		{
			active = !active;
		}
		
		private function acceptInput():void
		{
			if ( Input.pressed( Key.W ) && ledgeTimer > 0 )
			{
				jumping = true;
				velocity.y = -JUMP_SPEED;
			}
			
			// Gravity
			if ( Input.check( Key.W ) && jumping )
				velocity.y += Const.GRAVITY * FP.elapsed / 2.0;
			else
				velocity.y += Const.GRAVITY * FP.elapsed;
			
			if ( Input.check( Key.A ) )
			{
				lastDirection = -1;
				acceleration.x -= ACCEL;
			}
				
			if ( Input.check( Key.D ) )
			{
				lastDirection = 1;
				acceleration.x += ACCEL;
			}
		}
		
		private function setAnimation():void
		{
			wallTimer -= FP.elapsed;
			
			if ( !onGround )
				if ( velocity.y < 0 )
					if ( lastDirection == 1 )
						spriteMap.play( A_JUMP_RIGHT );
					else
						spriteMap.play( A_JUMP_LEFT );
				else
					if ( lastDirection == 1 )
						spriteMap.play( A_FALL_RIGHT );
					else
						spriteMap.play( A_FALL_LEFT );
			else
			{				
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
}
