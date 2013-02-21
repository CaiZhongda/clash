package clash.bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import clash.bloom.brushes.TextBrush;
	import clash.bloom.events.BrushEvent;
	import clash.bloom.themes.ThemeBase;
	
	/** 
	 * Dispatched when the format of textField has changed.
	 * @eventType bloom.events.BrushEvent
	 */
	[BrushEvent(name = "redraw", type = "bloom.events.BrushEvent")]
	
	/**
	 * TextBase
	 * 
	 * @author sindney
	 */
	public class TextBase extends TextField implements IComponent {
		
		protected var _brush:TextBrush;
		
		protected var _margin:Margin;
		
		protected var _enabled:Boolean = true;
		
		public function TextBase(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			if (p != null) p.addChild(this);
		}
		
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function size(w:Number, h:Number):void {
			width = w;
			height = h;
		}
		
		protected function onBrushChanged(e:BrushEvent):void {
			if (defaultTextFormat != _brush.textFormat) {
				defaultTextFormat = _brush.textFormat;
				setTextFormat(defaultTextFormat);
				dispatchEvent(new BrushEvent("redraw"));
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set brush(b:TextBrush):void {
			if (_brush != b) {
				if (_brush) _brush.removeEventListener(BrushEvent.REDRAW, onBrushChanged);
				_brush = b;
				if (_brush) {
					onBrushChanged(null);
					_brush.addEventListener(BrushEvent.REDRAW, onBrushChanged);
				}
			}
		}
		
		public function get brush():TextBrush {
			return _brush;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = tabEnabled = mouseEnabled = value;
				alpha = _enabled ? 1 : ThemeBase.ALPHA;
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function get margin():Margin {
			return _margin;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.core.TextBase]";
		}
		
	}

}