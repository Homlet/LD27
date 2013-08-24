package uk.co.homletmoo.ld27.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.entity.powered.Door;
	import uk.co.homletmoo.ld27.entity.powered.TrapDoor;
	import uk.co.homletmoo.ld27.Layer;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Level extends Entity
	{
		public static const TILE_SIZE:int = 16 * Display.SCALE;
		
		private static function loadTilemapFromXML( data:XMLList, width:int, height:int ):Tilemap
		{
			var tiles:Tilemap = new Tilemap(
				Assets.scaleGraphic( Assets.BASE_TILES_RAW, Display.SCALE ),
				width * Display.SCALE, height * Display.SCALE,
				TILE_SIZE, TILE_SIZE
			);
			
			var e:XML;
			for each ( e in data )
			{
				var x:int = e.@x;
				var y:int = e.@y;
				var id:int = e.@id;
				
				tiles.setTile( x, y, id );
			}
			
			return tiles;
		}
		
		private static function loadGridFromString( data:String, width:int, height:int ):Grid
		{
			var grid:Grid = new Grid(
				width * Display.SCALE, height * Display.SCALE,
				TILE_SIZE, TILE_SIZE
			);
			
			grid.loadFromString( data, "", "\n" );
			
			return grid;
		}
		
		
		private var tilemap:Tilemap;
		private var grid:Grid;
		
		public function Level( width:int, height:int, tilemap:XMLList, grid:String )
		{
			super();
			
			layer = Layer.LEVEL;
			type = Layer.C_LEVEL;
			
			this.tilemap = loadTilemapFromXML( tilemap, width, height );
			this.grid = loadGridFromString( grid, width, height );
			
			addGraphic( this.tilemap );
			mask = this.grid;
		}
	}
}
