package clash.bloom.brushes 
{
	import clash.bloom.events.BrushEvent;
	
	/** 
	 * Dispatched when redraw is needed.
	 * @eventType bloom.events.BrushEvent
	 */
	[BrushEvent(name = "redraw", type = "bloom.events.BrushEvent")]
	
	/**
	 * ColorBrush
	 * 
	 * @author sindney
	 */
	public class ColorBrush extends Brush {
		
		public var colors:Vector.<uint>;
		
		public function ColorBrush(colors:Vector.<uint> = null) {
			super();
			this.colors = colors;
		}
		
		/**
		 * Use this to make your changes up to date.
		 */
		override public function update():void {
			dispatchEvent(new BrushEvent("redraw"));
		}
		
		override public function clone():Brush {
			var data:Vector.<uint> = new Vector.<uint>(colors.length, true);
			var i:int, j:int = colors.length;
			for (i = 0; i < j; i++) {
				data[i] = colors[i];
			}
			return new ColorBrush(data);
		}
		
		override public function destory():void {
			colors = null;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.brushes.ColorBrush]";
		}
	}

}