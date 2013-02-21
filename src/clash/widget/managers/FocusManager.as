package clash.widget.managers
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;

	public class FocusManager extends EventDispatcher
	{
		public function FocusManager()
		{
			
		}
		
		private static var instance:FocusManager;
		public static function getInstance():FocusManager{
			if(instance == null){
				instance = new FocusManager();
			}
			return instance;
		}
		
		
		private var _stage:Stage;
		public function set stage(value:Stage):void{
			_stage = value;
			_stage.addEventListener(FocusEvent.FOCUS_IN,focusInHandler);
			focusStage();
		}
		
		public function get stage():Stage{
			return _stage;	
		}
		
		public function focusStage():void{
			if(_stage){
				_stage.focus = _stage;
			}	
		}
		
		private function focusInHandler(event:FocusEvent):void{
			setFocus(event.target as InteractiveObject);
		}
		
		private var focusObj:InteractiveObject;
		private function setFocus(obj:InteractiveObject):void{
			if(obj == null)return;
			if(obj == stage){
				if(stage.focus != stage){
					stage.focus = stage;	
				}
				return;
			}
			if(focusObj){
				removeListener();
			}
			focusObj = obj;
			addListener();
		}
		
		public function getFocus():InteractiveObject{
			return focusObj;
		}
		
		private function addListener():void{
			if(focusObj){
				focusObj.addEventListener(Event.REMOVED_FROM_STAGE,removeHandler);
			}
		}
		
		private function removeListener():void{
			if(focusObj){
				focusObj.removeEventListener(Event.REMOVED_FROM_STAGE,removeHandler);
			}
		}
		
		private function clearFocus():void{
			removeListener();
			focusObj = null;
		}
		
		private function removeHandler(event:Event):void{
			clearFocus();
			stage.focus = stage;
		}
	}
}