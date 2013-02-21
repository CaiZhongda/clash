package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.events.BrushEvent;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * ToggleButton
	 * 
	 * @author sindney
	 */
	public class ToggleButton extends CheckBox {
		
		public function ToggleButton(p:DisplayObjectContainer = null, text:String = "", value:Boolean = false) {
			super(p, text, value);
			
			brush = ThemeBase.ToggleButton;
			_title.brush = ThemeBase.Text_ToggleButton;
			_title.addEventListener(BrushEvent.REDRAW, onTitleChanged);
			
			size(100, 20);
		}
		
		override protected function onTitleChanged(e:Event):void {
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var bmpBrush:BMPBrush;
			var colorBrush:ColorBrush;
			var scale:ScaleBitmap;
			
			_bg.graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				_bg.graphics.beginFill(colorBrush.colors[_value ? 0 : 1]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[_value ? 0 : 1];
				scale.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(scale.bitmapData);
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_title.move((_width - _title.width) * 0.5, (_height - _title.height) * 0.5);
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.ToggleButton]";
		}
		
	}

}