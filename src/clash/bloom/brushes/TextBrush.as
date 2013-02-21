package clash.bloom.brushes 
{
	import flash.text.TextFormat;
	
	import clash.bloom.events.BrushEvent;
	
	/** 
	 * Dispatched when redraw is needed.
	 * @eventType bloom.events.BrushEvent
	 */
	[BrushEvent(name = "redraw", type = "bloom.events.BrushEvent")]
	
	/**
	 * TextBrush
	 * 
	 * @author sindney
	 */
	public class TextBrush extends Brush {
		
		private var _textFormat:TextFormat;
		
		public function TextBrush(font:String = "Verdana", size:int = 12, color:uint = 0x000000, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false) {
			super();
			_textFormat = new TextFormat(font, size, color, bold, italic, underline);
		}
		
		/**
		 * Use this to make your changes up to date.
		 */
		override public function update():void {
			dispatchEvent(new BrushEvent("redraw"));
		}
		
		override public function clone():Brush {
			return new TextBrush(_textFormat.font, int(_textFormat.size), uint(_textFormat.color), Boolean(_textFormat.bold), Boolean(_textFormat.italic), Boolean(_textFormat.underline));
		}
		
		override public function destory():void {
			_textFormat = null;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get textFormat():TextFormat {
			return _textFormat;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.brushes.TextBrush]";
		}
	}

}