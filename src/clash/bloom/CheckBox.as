package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.core.Component;
	import clash.bloom.events.BrushEvent;
	import clash.bloom.themes.ThemeBase;
	
	/** 
	 * Dispatched when the value has changed.
	 * @eventType flash.events.Event
	 */
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 * CheckBox
	 * 
	 * @author sindney
	 */
	public class CheckBox extends Component {
		
		protected var _value:Boolean;
		protected var _title:Label;
		protected var _bg:Shape;
		
		public function CheckBox(p:DisplayObjectContainer = null, text:String = "", value:Boolean = false) {
			super(p);
			
			tabChildren = tabEnabled = false;
            buttonMode = true;
			
			_bg = new Shape();
			addChild(_bg);
			
			_title = new Label(this, text);
			_title.brush = ThemeBase.Text_CheckBox;
			_title.addEventListener(Event.CHANGE, onTitleChanged);
			
			_value = value;
			
			brush = ThemeBase.CheckBox;
			
			size(100, 20);
			
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		protected function onTitleChanged(e:Event):void {
			_title.move(20, (20 - _title.height) * 0.5);
		}
		
		override protected function draw(e:Event):void {
			if (_changed) {
				_changed = false;
			} else {
				return;
			}
			
			var bmpBrush:BMPBrush;
			var colorBrush:ColorBrush;
			
			_bg.graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				_bg.graphics.beginFill(colorBrush.colors[0]);
				_bg.graphics.drawRect(5, 5, 10, 10);
				_bg.graphics.endFill();
				if (_value) {
					_bg.graphics.beginFill(colorBrush.colors[1]);
					_bg.graphics.drawRect(7, 7, 6, 6);
					_bg.graphics.endFill();
				}
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				if (_value) {
					_bg.graphics.beginBitmapFill(bmpBrush.bitmap[1].bitmapData);
					_bg.graphics.drawRect(0, 0, 20, 20);
					_bg.graphics.endFill();
				} else {
					_bg.graphics.beginBitmapFill(bmpBrush.bitmap[0].bitmapData);
					_bg.graphics.drawRect(0, 0, 20, 20);
					_bg.graphics.endFill();
				}
			}
			
			_title.move(20, (20 - _title.height) * 0.5);
		}
		
		private function onMouseClick(e:MouseEvent):void {
			value = !_value;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get title():Label {
			return _title;
		}
		
		public function set value(b:Boolean):void {
			if (_value != b) {
				_value = b;
				_changed = true;
				invalidate();
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
			return "[bloom.CheckBox]";
		}
	}

}
