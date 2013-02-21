package clash.widget.ui.controls
{
	import clash.widget.events.ItemEvent;
	import clash.widget.ui.containers.List;
	import clash.widget.ui.controls.core.UIComponent;
	import clash.widget.ui.skins.ComboBoxSkin;
	import clash.widget.ui.skins.Skin;
	import clash.widget.ui.style.StyleManager;
	import clash.widget.utils.StringUtil;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ComboBox extends UIComponent
	{
		private var text:TextField;
		private var list:List;
		private var dataProviderChanged:Boolean = false;
		private var listHeightChanged:Boolean = false;
		private var selectedIndexChanged:Boolean = false;
		private var selectedItemChanged:Boolean = false;
		private var defualtTF:TextFormat;
		public var labelField:String;
		private var _cbSkin:ComboBoxSkin;
		private var _cbSkinChange:Boolean;
		private var cbBg:UIComponent;
		private var btn:Button;
		public function ComboBox(){
			_cbSkin=StyleManager.comboBoxSkin;
			init();
		}
		private var _selectedIndex:int = -1;
		public function set selectedIndex(value:int):void{
			if(_selectedIndex != value){
				_selectedIndex = value;
				selectedIndexChanged = true;
				dispatch = true;
				invalidateDisplayList();
			}
		}
		public function get selectedIndex():int{
			return _selectedIndex;
		}
		
		private var dispatch:Boolean = false;
		public function setSelectIndex(value:int):void{
			selectedIndex = value;
			dispatch = false;
		}
		
		private var _selectedItem:Object;
		public function set selectedItem(value:Object):void{
			if(_selectedItem != value){
				_selectedItem = value;
				selectedItemChanged = true;
				dispatch = true;
				invalidateDisplayList();
			}
		}
		public function get selectedItem():Object{
			return _selectedItem;
		}
		
		public function setSelectedItem(value:Object):void{
			selectedItem = value;
			dispatch = false;
		}
		
		private var _paddingLeft:Number = 0;
		public function set paddingLeft(value:Number):void{
			if(value != _paddingLeft){
				this._paddingLeft = value;
				text.x = _paddingLeft;
			}
		}
		public function get paddingLeft():Number{
			return _paddingLeft;
		}
		
		private var _dataProvider:Array;
		public function set dataProvider(value:Array):void{
			this._dataProvider = value;
			selectedIndexChanged = true;
			selectedItemChanged = true;
			dataProviderChanged = true;
			invalidateDisplayList();
		}
		public function get dataProvider():Array{
			return _dataProvider;
		}
		
		private var _maxListHeight:Number = 150;
		public function set maxListHeight(value:Number):void{
			if(value != _maxListHeight){
				this._maxListHeight = value;
				listHeightChanged = true;
				invalidateDisplayList();
			}
		}
		
		public function get maxListHeight():Number{
			return _maxListHeight;
		}
		
		private var _textformat:TextFormat;
		public function set textFormat(tf:TextFormat):void{
			_textformat = tf;
			if(text && StringUtil.trim(text.text) != ""){
				text.setTextFormat(_textformat);
			}else{
				text.defaultTextFormat = _textformat;
			}
		}

		protected function init():void{
			cbBg=new UIComponent();
			addChild(cbBg);
			cbBg.mouseChildren=cbBg.mouseEnabled=false;
			btn=new Button();
			addChild(btn);
			if(_cbSkin){
				cbSkin=_cbSkin;
			}
			text = new TextField();
			text.mouseEnabled = false;
			if(StyleManager.textFormat){
				textFormat = StyleManager.textFormat;
			}
			text.text = "     ";
			addChild(text);
			addEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			sizeChanged = true;
			paddingLeft = 2;
			width=80;
			height=21;
		}
		public function set cbSkin(s:ComboBoxSkin):void{
			if(s){
				cbBg.bgSkin=s.bgSkin;
				btn.bgSkin=s.buttonSkin;
			}
			_cbSkinChange=true;
			_cbSkin=s;
			invalidateDisplayList();
		}
		public function get cbSkin():ComboBoxSkin{
			return _cbSkin;
		}
		private function mouseDownHandler(event:MouseEvent):void{
			if(list == null || list.parent == null){
				openList();
				stage.addEventListener(MouseEvent.MOUSE_DOWN,onCloseList);
			}else if(list && !list.contains(event.target as DisplayObject)){
				closeList();
			}else if(list && list.parent){
				closeList();
			}
		}
		
		private function onCloseList(event:MouseEvent):void{
			var target:DisplayObject = event.target as DisplayObject;
			if(!contains(target) && !list.contains(target)){
				closeList();
			}
		}
		
		private function closeList():void{
			if(list && list.parent){
				list.parent.removeChild(list);
			}	
			if(stage){
				stage.removeEventListener(MouseEvent.MOUSE_DOWN,onCloseList);
			}
		}
		
		private function openList():void{
			if(list == null){
				list = new List();
				list.dataProvider = dataProvider;
				list.width = width;
				list.itemHeight = 20;
				list.labelField = labelField;
				list.addEventListener(ItemEvent.ITEM_CLICK,onItemChange);
				var listHeight:Number = 0;
				if(dataProvider)
				listHeight = dataProvider.length*list.itemHeight;
				listHeight = Math.min(listHeight,maxListHeight);
				list.height = listHeight;
			}
			if(dataProvider){
				var p:Point = localToGlobal(new Point(0,height));
				list.x = p.x;
				if(p.y + list.height > stage.stageHeight){
					list.y = p.y - (list.height+height);
				}else{
					list.y = p.y;
				}
				stage.addChild(list);
			}
		}
		
		public function invalidateItem(item:Object):void{
			if(list){
				list.refreshItem(item);
				if(selectedItem == item){
					if(labelField && selectedItem){
						text.htmlText = selectedItem[labelField];
					}else if(selectedItem){
						text.htmlText = selectedItem.toString();
					}
				}
			}
		}
		
		private function onItemChange(event:ItemEvent):void{
			selectedItem = event.selectItem;
			closeList();
			validateNow();
		}
		
		private var sizeChanged:Boolean = false;
		override public function set width(value:Number):void{
			if(super.width != value){
				super.width = value;
				sizeChanged = true;
				invalidateDisplayList();
			}
		}
		
		override public function set height(value:Number):void{
			if(super.height != value){
				super.height = value;
				sizeChanged = true;
				invalidateDisplayList();
			}
		}
		
		private var _enabled:Boolean = false;
		public function set enabled(value:Boolean):void{
			_enabled = value;
			if (_enabled){
				filters = [];
			}else{
				filters = [new ColorMatrixFilter([1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0])];
			}
			mouseEnabled = mouseChildren = _enabled;
			if (bgSkin != null){
				bgSkin.enableMouse = enabled;
			}
		}
		public function get enabled():Boolean{
			return _enabled;
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void{
			super.updateDisplayList(w,h);
			if(dataProviderChanged){
				dataProviderChanged = false;
				if(list && dataProvider){
					list.dataProvider = dataProvider;
					var h:Number = 0;
					h = dataProvider.length*list.itemHeight;
					h = Math.min(h,maxListHeight);
					list.height = h;
				}
				text.text = "     ";
			}
			if(listHeightChanged){
				listHeightChanged = false;
				if(list){
					var listHeight:Number = dataProvider.length*list.itemHeight;
					listHeight = Math.min(listHeight,maxListHeight);
					list.height = listHeight;
				}
			}
			if(selectedIndexChanged){
				selectedIndexChanged = false;
				var max:int = dataProvider ? dataProvider.length - 1 : -1;
				var index:int = Math.max(0,selectedIndex);
				index = Math.min(index,max);
				if(index >= 0){
					_selectedItem = dataProvider[index];
					selectedItemChanged = true;
				}
			}
			if(selectedItemChanged){
				selectedItemChanged = false;
				if(labelField && selectedItem){
					text.htmlText = selectedItem[labelField];
				}else if(selectedItem){
					text.htmlText = selectedItem.toString();
				}
				_selectedIndex = dataProvider.indexOf(selectedItem);
				sizeChanged = true;
				if(dispatch){
					dispatch = false;
					dispatchEvent(new Event(Event.CHANGE));
				}
			}
			if(_cbSkinChange){
				if(_cbSkin){
					btn.width=_cbSkin.btnWidth;
					btn.height=_cbSkin.btnHeight;
				}
			}
			if(sizeChanged){
				sizeChanged = false;
				text.width = width - paddingLeft;
				text.height = text.textHeight + 5;
				text.y = (height - text.height)/2
				cbBg.width=width;
				cbBg.height=height;
				if(_cbSkin){
					btn.x=width-btn.width-_cbSkin.btnPaddingR;
					btn.y=_cbSkin.btnPaddingT;
				}
			}
		}
	}
}