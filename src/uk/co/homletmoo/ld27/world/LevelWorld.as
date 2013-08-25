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
		public static const YELLOW:int = 0;
		public static const PURPLE:int = 1;
		public static const GREEN:int = 2;
		
		private var clock:Clock;
		private var player:Player;
		
		private var yellowCircuit:Vector.<PoweredEntity>;
		private var yellowPowered:Boolean = true;
		
		private var purpleCircuit:Vector.<PoweredEntity>;
		private var purplePowered:Boolean = false;
		private var purplePoweredOld:Boolean = false;
		
		private var greenCircuit:Vector.<PoweredEntity>;
		private var greenPowered:Boolean = false;
		private var greenPoweredOld:Boolean = false;
		
		private var toggles:Vector.<Toggle>;
		
		private var powerTimer:Number = 10.0;
		
		private var vignette:Entity;
		
		
		public function LevelWorld( level:Level, entities:XMLList ) 
		{
			var vignetteImg:Image = new Image( Assets.VIGNETTE );
			vignetteImg.scale = Display.SCALE;
			vignetteImg.scrollX = vignetteImg.scrollY = 0;
			vignette = new Entity( 0, 0, vignetteImg );
			vignette.layer = Layer.EFFECTS;
			vignette.visible = !yellowPowered;
			add( vignette );
			
			add( level );
			
			clock = new Clock();
			add( clock );
			
			yellowCircuit = new Vector.<PoweredEntity>();
			purpleCircuit = new Vector.<PoweredEntity>();
			greenCircuit = new Vector.<PoweredEntity>();
			
			toggles = new Vector.<Toggle>();
			
			player = new Player(
				entities.Player.@x * Display.SCALE,
				entities.Player.@y * Display.SCALE
			);
			add( player );
			
			FP.world.camera.x = player.x - Display.WIDTH / 2.0;
			FP.world.camera.y = player.y - Display.HEIGHT / 2.0;
			
			var e:XML;
			for each ( e in entities.Door )
			{
				var door:Door = new Door(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE,
					getCircuitId( e.@circuit )
				);
				
				addToCircuit( e.@circuit, door );
				add( door );
			}
			
			for each ( e in entities.Trapdoor )
			{
				var trap:TrapDoor = new TrapDoor(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE,
					getCircuitId( e.@circuit )
				);
				
				addToCircuit( e.@circuit, trap );
				add( trap );
			}
			
			for each ( e in entities.Spikes )
			{
				var spike:Spikes = new Spikes(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE,
					getCircuitId( e.@circuit )
				);
				
				addToCircuit( e.@circuit, spike );
				add( spike );
			}
			
			for each ( e in entities.Fan )
			{
				var fan:Fan = new Fan(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE,
					getCircuitId( e.@circuit )
				);
				
				addToCircuit( e.@circuit, fan );
				add( fan );
			}
			
			for each ( e in entities.Toggle )
			{
				var toggle:Toggle = new Toggle(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE,
					getCircuitId( e.@circuit )
				);
				
				toggles.push( toggle );
				add( toggle );
			}
			
			for each ( e in entities.Exit )
			{
				var exit:Exit = new Exit(
					e.@x * Display.SCALE,
					e.@y * Display.SCALE
				);
				
				add( exit );
			}
			
			setPowered();
		}
		
		override public function update():void
		{
			powerTimer -= FP.elapsed;
			
			if ( powerTimer <= 0.0 )
			{
				powerTimer = 10.0;
				yellowPowered = !yellowPowered;
				
				setPowered();
			}
			
			super.update();
			
			var t:Toggle;
			for each ( t in toggles )
			{
				switch( t.circuit )
				{
				case PURPLE:
					purplePoweredOld = purplePowered;
					purplePowered = t.powered;
					if ( purplePowered != purplePoweredOld )
						setPowered();
					break;
					
				case GREEN:
					greenPoweredOld = greenPowered;
					greenPowered = t.powered;
					if ( greenPowered != greenPoweredOld )
						setPowered();
					break;
				}
			}
		}
		
		private function addToCircuit( s:String, pe:PoweredEntity ):void
		{
			switch ( s )
			{
			case "YELLOW":
				yellowCircuit.push( pe );
				break;
				
			case "PURPLE":
				purpleCircuit.push( pe );
				break;
				
			case "GREEN":
				greenCircuit.push( pe );
				break;
			}
		}
		
		private function getCircuitId( s:String ):int
		{
			switch ( s )
			{
			case "YELLOW":
				return YELLOW;
				
			case "PURPLE":
				return PURPLE;
				
			case "GREEN":
				return GREEN;
			}
			
			return -1;
		}
		
		private function setPowered():void
		{
			Main.quake.start( 0.4, 0.3 );
			
			vignette.visible = !yellowPowered;
			
			var pe:PoweredEntity;
			for each ( pe in yellowCircuit )
			{
				pe.setPowered( yellowPowered );
			}
			for each ( pe in purpleCircuit )
			{
				pe.setPowered( purplePowered );
			}
			for each ( pe in greenCircuit )
			{
				pe.setPowered( greenPowered );
			}
		}
	}
}
