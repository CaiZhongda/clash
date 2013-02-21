package clash.bloom.containers 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import clash.bloom.core.IChild;
	
	/**
	 * FlowContainer
	 * 
	 * @author sindney
	 */
	public class FlowContainer extends Container {
		
		public static const VERTICALLY:int = 0;
		public static const HORIZONTALLY:int = 1;
		
		protected var _direction:int;
		
		protected var _target:DisplayObjectContainer;
		
		public function FlowContainer(p:DisplayObjectContainer = null) {
			super(p);
			_direction = HORIZONTALLY;
			_target = this;
		}
		
		override public function update():void {
			var last:Number = 0;
			
			var object:DisplayObject;
			var component:IChild;
			var i:int, j:int = _target.numChildren;
			for (i = 0; i < j; i++) {
				object = _target.getChildAt(i);
				if (object is IChild) {
					component = object as IChild;
					if (_direction == HORIZONTALLY) {
						component.x = last + component.margin.left;
						component.y = component.margin.top;
						last = component.x + component.width + component.margin.right;
					} else if (_direction == VERTICALLY) {
						component.x = component.margin.left;
						component.y = last + component.margin.top;
						last = component.y + component.height + component.margin.bottom;
					}
				}
			}
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set direction(value:int):void {
			if (_direction != value) {
				_direction = value;
				update();
			}
		}
		
		public function get direction():int {
			return _direction;
		}
		
		/**
		 * Default Target is FlowContainer itself.
		 */
		public function set target(value:DisplayObjectContainer):void {
			if (_target != value) {
				_target = value;
				update();
			}
		}
		
		public function get target():DisplayObjectContainer {
			return _target;
		}
		
		///////////////////////////////////
		// toString
		///////////////////////////////////
		
		override public function toString():String {
			return "[bloom.containers.FlowContainer]";
		}
		
	}

}