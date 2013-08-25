package uk.co.homletmoo.ld27.entity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import uk.co.homletmoo.ld27.Assets;
	import uk.co.homletmoo.ld27.Display;
	import uk.co.homletmoo.ld27.Helper;
	import uk.co.homletmoo.ld27.Layer;
	import uk.co.homletmoo.ld27.Time;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Clock extends Entity
	{
		private static const STATE_UNPOWERED:int = 0;
		private static const STATE_POWERED:int = 1;
		
		private var handImg:Image;
		private var faceMap:Spritemap;
		
		private var timeText:Text;
		
		private var state:int;
		
		public function Clock() 
		{
			super( Display.WIDTH - 100, 80 );
			
			layer = Layer.GUI;
			
			state = STATE_POWERED;
			
			handImg = new Image( Assets.CLOCK_HAND );
			handImg.originX = handImg.width / 2.0;
			handImg.originY = handImg.height - 0.5;
			handImg.scale = Display.SCALE;
			handImg.scrollX = handImg.scrollY = 0;
			
			faceMap = new Spritemap( Assets.CLOCK_FACE, 22, 20 );
			faceMap.originX = 8.5;
			faceMap.originY = 11.5;
			faceMap.scale = Display.SCALE;
			faceMap.scrollX = faceMap.scrollY = 0;
			faceMap.add( STATE_UNPOWERED.toString(), [0] );
			faceMap.add( STATE_POWERED.toString(), [1] );
			faceMap.play( state.toString() );
			
			timeText = new Text( "5:55", 0, 0 );
			timeText.scale = Display.SCALE;
			timeText.color = 0xFFFFFFFF;
			timeText.scrollX = timeText.scrollY = 0;
			timeText.size = 8;
			timeText.smooth = false;
			timeText.x = -timeText.scaledWidth + 6 * Display.SCALE;
			timeText.y = -timeText.scaledHeight / 2.0;
			timeText.text = getTimestamp();
			
			addGraphic( faceMap );
			addGraphic( handImg );
			addGraphic( timeText );
		}
		
		override public function update():void
		{
			handImg.angle += FP.elapsed * -6.0;
			
			state = ( Math.floor( handImg.angle / 60 ) % 2 ) ? STATE_POWERED : STATE_UNPOWERED;
			faceMap.play( state.toString() );
			
			timeText.text = getTimestamp();
			timeText.x = -timeText.scaledWidth + 6 * Display.SCALE;
			
			super.update();
		}
		
		private function getTimestamp():String
		{
			var minutes:int = Math.floor( Time.TIME / 60.0 );
			var seconds:int = Time.TIME % 60;
			return minutes.toString() + ":" + Helper.zeroPad( seconds, 2 );
		}
	}
}