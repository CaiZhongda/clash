package clash.bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.events.BrushEvent;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * ButtonBase
	 * 
	 * @author sindney
	 */
	public class ButtonBase extends Component {
		
		public static const UP:int = 0;
		public static const OVER:int = 1;
		public static const DOWN:int = 2;
		
		protected var _state:int = 0;
		protected var _bg:Shape;
		
		public function ButtonBase(p:DisplayObjectContainer = null) {
			super(p);
			buttonMode = true;
			tabEnabled = false;
			
			_bg = new Shape();
			addChild(_bg);
			
			brush = ThemeBase.Button;
			
			size(100, 20);
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
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
				switch(_state) {
					case 0:
						_bg.graphics.beginFill(colorBrush.colors[0]);
						break;
					case 1:
						_bg.graphics.beginFill(colorBrush.colors[1]);
						break;
					case 2:
						_bg.graphics.beginFill(colorBrush.colors[2]);
						break;
				}
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				switch(_state) {
					case 0:
						scale = bmpBrush.bitmap[0];
						scale.setSize(_width, _height);
						_bg.graphics.beginBitmapFill(scale.bitmapData);
						break;
					case 1:
						scale = bmpBrush.bitmap[1];
						scale.setSize(_width, _height);
						_bg.graphics.beginBitmapFill(scale.bitmapData);
						break;
					case 2:
						scale = bmpBrush.bitmap[2];
						scale.setSize(_width, _height);
						_bg.graphics.beginBitmapFill(scale.bitmapData);
						break;
				}
			}
			
			_bg.graphics.drawRect(0, 0, _width, _height);
			_bg.graphics.endFill();
		}
		
		protected function onMouseOver(e:MouseEvent):void {
			if (_state != OVER) {
				_state = OVER;
				_changed = true;
				invalidate();
				addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		protected function onMouseDown(e:MouseEvent):void {
			if (_state != DOWN) {
				_state = DOWN;
				_changed = true;
				invalidate();
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void {
			_state = UP;
			_changed = true;
			invalidate();
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseOut(e:MouseEvent):void {
			if (_state != DOWN) onMouseUp(e);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function get state():int {
			return _state;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		public override function toString():String {
			return "[bloom.core.ButtonBase]";
		}
	}

}