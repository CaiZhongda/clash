package clash.bloom.core 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import clash.bloom.brushes.BMPBrush;
	import clash.bloom.brushes.Brush;
	import clash.bloom.events.BrushEvent;
	import clash.bloom.themes.ThemeBase;
	
	/** 
	 * Dispatched when this Component has resized.
	 * @eventType flash.events.Event
	 */
	[Event(name = "resize", type = "flash.events.Event")]
	
	/**
	 * Component
	 * 
	 * @author sindney
	 */
	public class Component extends Sprite implements IComponent {
		
		protected var _enabled:Boolean = true;
		protected var _changed:Boolean = false;
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var _brush:Brush;
		
		protected var _margin:Margin;
		
		public function Component(p:DisplayObjectContainer = null) {
			super();
			_margin = new Margin();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if (p != null) p.addChild(this);
		}
		
		/**
		 * Move this component.
		 */
		public function move(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		/**
		 * Resize this component.
		 */
		public function size(w:Number, h:Number):void {
			if (_width != w || _height != h) {
				_width = w;
				_height = h;
				_changed = true;
				invalidate();
				dispatchEvent(new Event("resize"));
			}
		}
		
		public function drawDirectly():void {
			_changed = true;
			draw(null);
		}
		
		protected function draw(e:Event):void {
			
		}
		
		protected function invalidate():void {
			if (stage) stage.invalidate();
		}
		
		protected function onBrushChanged(e:BrushEvent):void {
			_changed = true;
			invalidate();
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RENDER, draw);
			invalidate();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				_changed = true;
				invalidate();
				dispatchEvent(new Event("resize"));
			}
		}
		
		override public function get width():Number {
			return _width;
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				_changed = true;
				invalidate();
				dispatchEvent(new Event("resize"));
			}
		}
		
		override public function get height():Number {
			return _height;
		}
		
		public function set brush(b:Brush):void {
			if (_brush != b) {
				if (_brush) {
					if (_brush is BMPBrush)_brush.destory();
					_brush.removeEventListener(BrushEvent.REDRAW, onBrushChanged);
				}
				_brush = b;
				if (_brush is BMPBrush)_brush = b.clone();
				if (_brush) {
					_changed = true;
					invalidate();
					_brush.addEventListener(BrushEvent.REDRAW, onBrushChanged);
				}
			}
		}
		
		public function get brush():Brush {
			return _brush;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = mouseEnabled = mouseChildren = value;
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
			return "[bloom.core.Component]";
		}
		
	}

}