package uk.co.homletmoo.ld27.entity 
{
	import flash.utils.ByteArray;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.Sound;
	import uk.co.homletmoo.ld27.world.LevelWorld;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class LevelManager 
	{		
		private var levelsXML:Vector.<XML>;
		private var currentLevelIndex:int;
		
		public function LevelManager() 
		{
			levelsXML = new Vector.<XML>();
			
			levelsXML.push(
				getLevelAsXML( Assets.OGMO_LEVEL_001 ),
				getLevelAsXML( Assets.OGMO_LEVEL_002 ),
				getLevelAsXML( Assets.OGMO_LEVEL_003 ),
				getLevelAsXML( Assets.OGMO_LEVEL_004 ),
				getLevelAsXML( Assets.OGMO_LEVEL_005 ),
				getLevelAsXML( Assets.OGMO_LEVEL_006 ),
				getLevelAsXML( Assets.OGMO_LEVEL_007 ),
				getLevelAsXML( Assets.OGMO_LEVEL_008 ),
				getLevelAsXML( Assets.OGMO_LEVEL_009 ),
				getLevelAsXML( Assets.OGMO_LEVEL_010 ),
				getLevelAsXML( Assets.OGMO_LEVEL_011 ),
				getLevelAsXML( Assets.OGMO_LEVEL_012 ),
				getLevelAsXML( Assets.OGMO_LEVEL_013 ),
				getLevelAsXML( Assets.OGMO_LEVEL_014 ),
				getLevelAsXML( Assets.OGMO_LEVEL_015 )
			);
		}
		
		public function exit():void
		{
			Sound.EXIT.play( 0.2 );
			
			FP.tween(
				FP.screen,
				{
					scaleX: 10.0,
					x: -Display.WIDTH * 5.0,
					scaleY: 10.0,
					y: -Display.HEIGHT * 5.0 + 150,
					angle: 50.0
				},
				0.8,
				{ ease: Ease.circOut, complete: nextLevel }
			);
		}
		
		public function nextLevel():void
		{
			FP.screen.scaleX = 1.0;
			FP.screen.scaleY = 1.0;
			FP.screen.angle = 0.0;
			
			var xml:XML = levelsXML[currentLevelIndex++];
			
			var tiles:XMLList = xml.Tiles.tile;
			var grid:String = xml.Collision.*;
			var entities:XMLList = xml.Entities;
			
			FP.world = new LevelWorld(
				new Level( xml.@width, xml.@height, tiles, grid ),
				entities
			);
		}
		
		public function update():void
		{
		}
		
		private function getLevelAsXML( xml:Class ):XML
		{
			var rawData:ByteArray = new xml;
			var stringData:String = rawData.readUTFBytes( rawData.length );
			return new XML( stringData );
		}
	}
}
