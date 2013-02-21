package clash.bloom.containers 
{	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.Brush;
	import clash.bloom.brushes.ColorBrush;
	import clash.bloom.core.Component;
	import clash.bloom.core.IComponent;
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * Conatiner
	 * 
	 * @author sindney
	 */
	public class Container extends Component {
		
		public function Container(p:DisplayObjectContainer = null) {
			super(p);
			brush = ThemeBase.Container;
			size(100, 100);
		}
		
		/**
		 * Update child's layout.
		 */
		public function update():void {
			
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
			
			graphics.clear();
			
			if (brush is ColorBrush) {
				colorBrush = brush as ColorBrush;
				graphics.beginFill(colorBrush.colors[0]);
			} else if (brush is BMPBrush) {
				bmpBrush = brush as BMPBrush;
				scale = bmpBrush.bitmap[0];
				scale.setSize(_width, _height);
				graphics.beginBitmapFill(scale.bitmapData);
			}
			
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();
			
			update();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = tabChildren = mouseEnabled = mouseChildren = value;
				
				// make changes in it's childs.
				var i:int;
				var child:DisplayObject;
				for (i = 0; i < numChildren; i++) {
					child = getChildAt(i);
					if (child is IComponent) (child as IComponent).enabled = value;
				}
			}
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.conatiners.Container]";
		}
		
	}

}