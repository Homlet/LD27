package uk.co.homletmoo.ld27.world 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.utils.Draw;
	import uk.co.homletmoo.ld27.*;
	import uk.co.homletmoo.ld27.entity.*;
	import uk.co.homletmoo.ld27.entity.powered.*;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class LevelWorld extends World
	{
		private var clock:Clock;
		private var player:Player;
		
		private var poweredEntities:Vector.<PoweredEntity>;
		private var powered:Boolean = true;
		
		private var powerTimer:Number = 10.0;
		
		private var vignette:Entity;
		
		
		public function LevelWorld( level:Level, entities:XMLList ) 
		{
			var vignetteImg:Image = new Image( Assets.VIGNETTE );
			vignetteImg.scale = Display.SCALE;
			vignetteImg.scrollX = vignetteImg.scrollY = 0;
			vignette = new Entity( 0, 0, vignetteImg );
			vignette.layer = Layer.EFFECTS;
			vignette.visible = !powered;
			add( vignette );
			
			add( level );
			
			clock = new Clock();
			add( clock );
			
			poweredEntities = new Vector.<PoweredEntity>();
			
			player = new Player(
				entities.Player.@x * Display.SCALE,
				entities.Player.@y * Display.SCALE
			);
			add( player );
			
			var e:XML;
			for each ( e in entities.Door )
			{
				var door:Door = new Door(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE
				);
				
				poweredEntities.push( door );
				add( door );
			}
			
			for each ( e in entities.Trapdoor )
			{
				var trap:TrapDoor = new TrapDoor(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE
				);
				
				poweredEntities.push( trap );
				add( trap );
			}
			
			for each ( e in entities.Spikes )
			{
				var spike:Spikes = new Spikes(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE
				);
				
				poweredEntities.push( spike );
				add( spike );
			}
			
			setPowered();
		}
		
		override public function begin():void
		{
		}
		
		override public function update():void
		{
			powerTimer -= FP.elapsed;
			
			if ( powerTimer <= 0.0 )
			{
				powerTimer = 10.0;
				powered = !powered;
				
				setPowered();
			}
			
			super.update();
		}
		
		private function setPowered():void
		{
			Main.quake.start( 0.4, 0.3 );
			
			vignette.visible = !powered;
			
			var pe:PoweredEntity;
			for each ( pe in poweredEntities )
			{
				pe.setPowered( powered );
			}
		}
	}
}
