package clash.bloom 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.core.Component;
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * FormItem
	 * 
	 * @author sindney
	 */
	public class FormItem extends Component {
		
		protected var _data:Array = null;
		protected var _selected:Boolean = false;
		
		protected var _bg:Shape;
		
		public function FormItem(p:DisplayObjectContainer = null) {
			super(p);
			
			_bg = new Shape();
			addChild(_bg);
			
			brush = ThemeBase.FormItem;
			size(100, 20);
			
			buttonMode = true;
			tabEnabled = tabChildren = false;
			addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		/**
		 * Call this when data:Array is modified.
		 */
		public function dataChanged():void {
			_changed = true;
			invalidate();
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
				_bg.graphics.beginFill(colorBrush.colors[_selected ? 0 : 1]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[_selected ? 0 : 1];
				scale.setSize(_width, _height);
				_bg.graphics.beginBitmapFill(scale.bitmapData);
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
		}
		
		private function onMouseClick(e:MouseEvent):void {
			selected = !_selected;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set data(a:Array):void {
			if (_data != a) {
				_data = a;
				_changed = true;
				invalidate();
			}
		}
		
		public function get data():Array {
			return _data;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				_changed = true;
				invalidate();
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.FormItem]";
		}
	}

}