package clash.bloom 
{
	import flash.display.BitmapData;
	
	import clash.bloom.core.IComponent;
	import clash.bloom.core.Margin;
	import clash.bloom.core.ScaleBitmap;
	import clash.bloom.themes.ThemeBase;
	
	/**
	 * IconBox
	 * <p>You can add iconBox to Windows's title. And use it's margin method.</p>
	 * 
	 * @author sindney
	 */
	public class IconBox extends ScaleBitmap implements IComponent {
		
		private var _enabled:Boolean = true;
		protected var _margin:Margin;
		
		public function IconBox(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false) {
			super(bitmapData, pixelSnapping, smoothing);
			_margin = new Margin();
		}
		
		public function move(x:Number, y:Number):void {
			x = x;
			y = y;
		}
		
		public function size(w:Number, h:Number):void {
			width = w;
			height = h;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = value;
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
			return "[bloom.IconBox]";
		}
		
	}

}