package clash.widget.ui.controls
{
	import clash.widget.ui.controls.core.UIComponent;
	import clash.widget.ui.style.StyleManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ProgressBar extends UIComponent
	{
		public static const CENTER:String = "CENTER";
		public static const RIGHT:String = "RIGHT";
		public static const TOP:String = "TOP";
		public static const BOTTOM:String = "BOTTOM";
		
		public var text:TextField;
		public var paddingTop:int = 0;
		public var padding:int = 2;
		public function ProgressBar()
		{
			super();	
			init();
		}
		
		private function init():void{
			var tf:TextFormat = StyleManager.textFormat;
			tf.align = "center";
			text = new TextField();
			text.height = 20;
			text.defaultTextFormat = tf;
			text.mouseEnabled = false;
			text.filters = [new GlowFilter(0x000000, 1, 3, 3)];
			addChild(text);
			value = 0;
		}
		
		public var _textAlign:String = CENTER;
		public function set textAlign(value:String):void{
			if(_textAlign != value){
				_textAlign = value;
				invalidateDisplayList();
			}
		}
		
		public function get textAlign():String{
			return _textAlign;
		}
		
		private var _label:String;
		public function set htmlText(param:String):void{
			_label = param;
			text.htmlText = param;
		}
		public function get htmlText():String{
			return _label;
		}
		
		private var _bar:DisplayObject;
		public function set bar(param:DisplayObject):void{
			_bar = param;	
			addChild(_bar);
			addChild(text);
			invalidateDisplayList();
		}
		
		public function get bar():DisplayObject{
			return _bar;
		}
		
		private var valueChanged:Boolean = false;
		/**
		 *是否允许相同值的输入 
		 */		
		public var enableSameVal:Boolean = false;
		private var _value:Number = -1;
		public function set value(param:Number):void{
			if(!param){
				param=0;
			}
			if(!enableSameVal){
				if(_value == param){
					return;
				}
			}
			_value = param;	
			_value = Math.max(0,param);
			_value = Math.min(1,param);
			valueChanged = true;
			invalidateDisplayList();
		}
		
		public function get value():Number{
			return _value;
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void{
			super.updateDisplayList(w,h);
			if(_bar){
				_bar.y = (h - _bar.height >> 1) +paddingTop;
				_bar.x = padding;
			}
			if(_textAlign == CENTER){
				text.width = w;
				text.y = h - text.height >> 1;
			}else if(_textAlign == RIGHT){
				text.width = text.textWidth+4;
				text.y = h - text.height >> 1;
				text.x = w + 2;
			}else if(_textAlign == TOP){
				text.width = w;
				text.y = - h - 2;
			}else if(_textAlign == BOTTOM){
				text.width = w;
				text.y = h + 2;
			}
			if(valueChanged && _bar){
				valueChanged = false;
				if(_value==0)
				{
					_bar.visible=false;
				}
				else
				{
					_bar.width = _value*(width-2*padding);
					_bar.visible=true;
				}
			}	
		}
	}
}