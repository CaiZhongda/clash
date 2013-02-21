package clash.widget.ui.controls {
	import clash.widget.ui.controls.core.UIComponent;
	import clash.widget.ui.skins.ButtonSkin;
	import clash.widget.ui.skins.Skin;
	import clash.widget.ui.style.BitmapDataPool;
	import clash.widget.ui.style.StyleManager;
	import clash.widget.utils.TextUtil;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.*;
	import flash.text.*;
	import flash.utils.Timer;

	public class Button extends UIComponent {
		private var formatChanged:Boolean=false;
		private var enabledChanged:Boolean=false;
		private var sizeChange:Boolean=false;
		private var skinChanged:Boolean=false;
		protected var labelText:TextField;
		public var enabledColor:uint=0xcccccc;
		public var leftPadding:Number=0;
		public var topPadding:Number=0;
		private var tempListener:Array;
		private var _lock:Bitmap;
		protected var timer:Timer;
		private var _iconLeft:int;
		private var _iconTop:int;
		private var _canClickFast:Boolean = true;//是否可以狂点，设置成false则1秒钟只能点击一次

		public function Button() {
			init();
		}

		private function init():void {
			tempListener = new Array();
			height=30;
			width=100;
			buttonMode=true;
			useHandCursor=true;
			var buttonSkin:Skin=StyleManager.buttonSkin;
			if (buttonSkin) {
				bgSkin=buttonSkin;
			}
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.DOUBLE_CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void{
			if(mouseEnabled && !_canClickFast){
				mouseEnabled=mouseChildren=false;
				if(!timer){
					timer = new Timer(1000, 1);
				}
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeComplete);
				timer.start();
			}
		}
		private function onTimeComplete(event:TimerEvent):void{
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimeComplete);
			mouseEnabled=mouseChildren=true;
		}

		private var _enabled:Boolean=true;

		public function set enabled(value:Boolean):void {
			if (value != _enabled) {
				_enabled=value;
				enabledChanged=true;
				invalidateDisplayList();
			}
		}

		public function get enabled():Boolean {
			return _enabled;
		}

		private var _textSize:int=12;

		public function set textSize(value:int):void {
			if (_textSize != value) {
				_textSize=value;
				formatChanged=true;
				invalidateDisplayList();
			}
		}

		public function get textSize():int {
			return _textSize;
		}

		private var _textFont:String="宋体";

		public function set textFont(value:String):void {
			if (_textFont != value) {
				_textFont=value;
				formatChanged=true;
				invalidateDisplayList();
			}
		}

		public function get textFont():String {
			return _textFont;
		}

		private var _textBold:Boolean=false;

		public function set textBold(value:Boolean):void {
			if (_textBold != value) {
				_textBold=value;
				formatChanged=true;
				invalidateDisplayList();
			}
		}

		public function get textBold():Boolean {
			return _textBold;
		}

		private var _textColor:uint=0xF6F5CD;

		public function set textColor(value:uint):void {
			if (_textColor != value) {
				_textColor=value;
				formatChanged=true;
				invalidateDisplayList();
			}
		}

		public function get textColor():uint {
			return _textColor;
		}
		public function set iconLeft(value:int):void {
			if (_iconLeft != value) {
				_iconLeft=value;
				sizeChange=true;
				invalidateDisplayList();
			}
		}
		public function get iconLeft():int {
			return _iconLeft;
		}
		public function set iconTop(value:int):void{
			if(_iconTop!=value){
				_iconTop=value;
				sizeChange=true;
				invalidateDisplayList();
			}
		}
		public function get iconTop():int{
			return _iconTop;
		}

		private var _label:String;

		public function set label(txt:String):void {
			if (_label == txt){
				return;
			}
			if (labelText == null) {
				createTextField();
			}
			_label=txt;
			labelText.text=txt;
			formatChanged=true;
			invalidateDisplayList();
			updatePosition();
		}

		public function get label():String {
			return _label;
		}

		private var _icon:DisplayObject;

		public function set icon(value:DisplayObject):void {
			if (_icon != null) {
				removeChild(_icon);
				_icon=null;
			}
			if (value != null) {
				_icon=value;
				if (value is Sprite) {
					Sprite(value).mouseEnabled=false;
				}
				addChild(value);
			}
			sizeChange=true;
			invalidateDisplayList();
		}

		public function get icon():DisplayObject {
			return _icon;
		}

		override public function set width(value:Number):void {
			super.width=value;
			sizeChange=true;
			invalidateDisplayList();
		}

		override public function set height(value:Number):void {
			super.height=value;
			sizeChange=true;
			invalidateDisplayList();
		}

		override public function set bgSkin(skin:Skin):void {
			super.bgSkin=skin;
			if (bgSkin != null) {
				bgSkin.enableMouse=enabled;
				skinChanged=true;
			}
		}

		private function createTextField():void {
			labelText=new TextField();
			labelText.mouseEnabled=false;
			labelText.autoSize=TextFieldAutoSize.LEFT;
			labelText.selectable=false;
			labelText.filters=[new GlowFilter(0x54251D,1,2,2,5)];//Style.CherryBorder
			addChild(labelText);
			formatChanged=true;
			invalidateDisplayList();
		}

		private function setTextFormat():void {
			if (labelText) {
				labelText.defaultTextFormat=new TextFormat(textFont, textSize, textColor, textBold);
			}
		}

		private function enabledChange():void {
//			mouseEnabled = false;
			if (_enabled) {
				if (bgSkin) {
					bgSkin.filters=[];
				}
				setTextColor(textColor);
			} else {
				var btnSkin:ButtonSkin=bgSkin as ButtonSkin;
				if (btnSkin == null || btnSkin.disableSkin == null) {
					bgSkin.filters=[new ColorMatrixFilter([0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0])];
				}
				setTextColor(enabledColor);
			}
			if(_enabled){
				for(var i:uint = 0; i < tempListener.length; i++){
					this.addEventListener(tempListener[i].type, tempListener[i].listener, tempListener[i].useCapture);
				}
			}else{
				var delEvent:Object;
				var size:int = listeners.length;
				for(var k:int=0;k<size;k++){
					delEvent = listeners[k];
					if(delEvent){
						if(delEvent.type != MouseEvent.ROLL_OUT && delEvent.type != MouseEvent.ROLL_OVER){
							super.removeEventListener(delEvent.type,delEvent.listener,delEvent.useCapture);
							tempListener.push(delEvent);
						}
					}
				}
			}
//			mouseEnabled=mouseChildren=_enabled;
			if (bgSkin != null) {
				bgSkin.enableMouse=enabled;
			}
//			mouseEnabled = mouseChildren = true;
		}

		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			if (formatChanged) {
				setTextFormat();
				updateButtonStyle();
				if (labelText) {
					TextUtil.fitText(labelText, labelText.text, width);
				}
				updatePosition();
				formatChanged=false;
			}
			if (sizeChange) {
				updatePosition();
				sizeChange=false;
			}
			if (skinChanged) {
				skinChanged=false;
				updatePosition();
			}
			if (enabledChanged) {
				enabledChange();
				enabledChanged=false;
			}
		}
		protected function updatePosition():void {
			var buttonSkin:ButtonSkin=bgSkin as ButtonSkin;
			if (buttonSkin) {
				topPadding=buttonSkin.topPadding;
			}
			if (labelText) {
				labelText.width=labelText.textWidth;
				labelText.height=labelText.textHeight;
			}
			if (_icon != null) {
				_icon.x=Math.round((width-_icon.width)/2) + iconLeft;
				_icon.y=Math.round((height-_icon.height)/2) + iconTop;
				if (labelText) {
					labelText.x=iconLeft+_icon.width*2+leftPadding;
					labelText.y=Math.round((height-labelText.height)/2)+topPadding;
				}
			} else if (labelText) {
				labelText.x=Math.round((width-labelText.width)/2)+leftPadding;
				labelText.y=Math.round((height-labelText.height)/2)+topPadding;
			}
		}

		protected function updateButtonStyle():void {
			var buttonSkin:ButtonSkin=bgSkin as ButtonSkin;
			if (buttonSkin && buttonSkin.color != -1) {
				buttonSkin.color=textColor;
			}
		}

		public function setTextColor(color:uint):void {
			if (labelText) {
				labelText.textColor=color;
			}
		}
		public function set textFilter(filters:Array):void{
			if(labelText){
				labelText.filters = filters;
			}
		}

		public function set lock(data:Object):void{
			_lock = data.bitmap;
			if(1 == data.type){
				_lock.x = this.width - _lock.width;
				_lock.y = -_lock.height>>1 + 1;
			}else if(0 == data.type){
				_lock.x = 5;
				_lock.y = 1;
			}else{
				_lock.x = this.width - _lock.width;
				_lock.y = 0;
			}
			this.addChild(_lock);
		}
		
		public function removeTabLock():void{
			if(null != this._lock){
				if(contains(_lock)){
					this.removeChild(_lock);
				}
				this._lock = null;
				enabled = true;
			}
		}

		public function set canClickFast(value:Boolean):void
		{
			_canClickFast = value;
		}


	}
}
