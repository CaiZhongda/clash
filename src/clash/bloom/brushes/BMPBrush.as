package clash.bloom.brushes 
{
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.events.BrushEvent;
	
	/** 
	 * Dispatched when redraw is needed.
	 * @eventType bloom.events.BrushEvent
	 */
	[BrushEvent(name = "redraw", type = "bloom.events.BrushEvent")]
	
	/**
	 * BMPBrush
	 * <p>ScaleBitmap Brush.</p>
	 * 
	 * @author sindney, impaler
	 */
	public class BMPBrush extends Brush {
		
		public var bitmap:Vector.<ScaleBitmap>;
		
		public function BMPBrush(bitmap:Vector.<ScaleBitmap> = null) {
			super();
			this.bitmap = bitmap;
		}
		
		/**
		 * Use this to make your changes up to date.
		 */
		override public function update():void {
			dispatchEvent(new BrushEvent("redraw"));
		}
		
		override public function clone():Brush {
			var data:Vector.<ScaleBitmap> = new Vector.<ScaleBitmap>(bitmap.length, true);
			var i:int, j:int = bitmap.length;
			for (i = 0; i < j; i++) {
				data[i] = bitmap[i].clone();
			}
			return new BMPBrush(data);
		}
		
		override public function destory():void {
			var data:ScaleBitmap;
			for each(data in bitmap) {
				data.bitmapData.dispose();
				data = null;
			}
			bitmap = null;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.brushes.BMPBrush]";
		}
		
	}

}