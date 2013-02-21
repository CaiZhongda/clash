package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.core.Component;
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.themes.ThemeBase;
	
	/** 
	 * Dispatched when the value has changed.
	 * @eventType flash.events.Event
	 */
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 * ToggleSwitcher
	 * 
	 * @author sindney
	 */
	public class ToggleSwitcher extends Component {
		
		private var _value:Boolean;
		private var _rect:Rectangle;
		private var _rect2:Rectangle;
		
		private var _slider:Sprite;
		private var _bg:Shape;
		
		public function ToggleSwitcher(p:DisplayObjectContainer = null, value:Boolean = false) {
			super(p);
			
			tabChildren = tabEnabled = false;
			
			_bg = new Shape();
			addChild(_bg);
			
			_slider = new Sprite();
			_slider.buttonMode = true;
			addChild(_slider);
			
			_rect = new Rectangle();
			_rect2 = new Rectangle();
			
			_value = value;
			
			brush = ThemeBase.ToggleSwitcher;
			
			size(60, 20);
			
			_slider.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			_rect.width = _width - _height;
			_rect2.width = _width;
			_rect2.height = _height;
			scrollRect = _rect2;
			
			var bmpBrush:BMPBrush;
			var colorBrush:ColorBrush;
			var scale:ScaleBitmap;
			
			graphics.clear();
			_bg.graphics.clear();
			_slider.graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				graphics.beginFill(colorBrush.colors[2]);
				_bg.graphics.beginFill(colorBrush.colors[1]);
				_slider.graphics.beginFill(colorBrush.colors[0]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[2];
				scale.setSize(_width, _height);
				graphics.beginBitmapFill(scale.bitmapData);
				
				scale = bmpBrush.bitmap[1];
				scale.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(scale.bitmapData);
				
				scale = bmpBrush.bitmap[0];
				scale.setSize(_height, _height);
				_slider.graphics.beginBitmapFill(scale.bitmapData);
			}
			
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
			
			_slider.graphics.drawRect(0, 0, _height, _height);
			_slider.graphics.endFill();
			
			_bg.x = _slider.x = _value ? 0 : _width - 20;
		}
		
		private function onMouseDown(e:MouseEvent):void {
			_slider.startDrag(false, _rect);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseMove(e:MouseEvent):void {
			_bg.x = _slider.x;
		}
		
		private function onMouseUp(e:MouseEvent):void {
			if (_value) {
				if (_slider.x != 0) value = false;
			} else {
				if (_slider.x != _width - 20) value = true;
			}
			_slider.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set value(b:Boolean):void {
			if (_value != b) {
				_value = b;
				_bg.x = _slider.x = _value ? 0 : _width - 20;
				dispatchEvent(new Event("change"));
			}
		}
		
		public function get value():Boolean {
			return _value;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.ToggleSwitcher]";
		}
		
	}

}