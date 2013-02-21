package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.core.Component;
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.themes.ThemeBase;
	
	[Event(name = "complete", type = "flash.events.Event")]
	
	/**
	 * ProgressBar
	 * 
	 * @author sindney
	 */
	public class ProgressBar extends Component {
		
		private var _bg:Sprite;
		private var _progress:Shape;
		
		private var _value:int;
		
		public function ProgressBar(p:DisplayObjectContainer = null, value:int = 0) {
			super(p);
			
			_bg = new Sprite();
			_progress = new Shape();
			addChild(_bg);
			addChild(_progress);
			
			_value = value;
			
			brush = ThemeBase.ProgressBar;
			
			size(100, 20);
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			_value = _value > 100 ? 100 : _value;
			_value = _value < 0 ? 0 : _value;
			
			var bmpBrush:BMPBrush;
			var colorBrush:ColorBrush;
			var scale:ScaleBitmap;
			
			_bg.graphics.clear();
			_progress.graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				_bg.graphics.beginFill(colorBrush.colors[0]);
				_progress.graphics.beginFill(colorBrush.colors[1]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[0];
				scale.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(scale.bitmapData);
				
				scale = bmpBrush.bitmap[1];
				scale.setSize((_width * _value) * 0.01, _height);
				_progress.graphics.beginBitmapFill(scale.bitmapData);
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_progress.graphics.drawRect(0, 0, (_width * _value) * 0.01, _height);
			_progress.graphics.endFill();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set value(value:int):void {
			if (_value != value) {
				_value = value;
				_changed = true;
				invalidate();
				if (_value >= 100) dispatchEvent(new Event("complete"));
			}
		}
		
		public function get value():int {
			return _value;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.ProgressBar]";
		}
	}

}