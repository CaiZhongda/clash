package clash.widget.ui.controls {
	import clash.widget.events.ResizeEvent;
	import clash.widget.events.TabNavigationEvent;
	import clash.widget.ui.constants.TabDirection;
	import clash.widget.ui.controls.core.UIComponent;
	import clash.widget.ui.skins.Skin;
	import clash.widget.ui.skins.TabBarSkin;
	import clash.widget.ui.skins.TabNavigationSkin;
	import clash.widget.ui.style.StyleManager;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;

	public class TabNavigation extends UIComponent {
		private var init:Boolean=false;
		public var tabBar:TabBar;
		public var tabContainer:TabContainer;
		private var _selectedIndex:int=0;
		private var updateLayout:Boolean=false;
		private var _direction:String=TabDirection.TOP;
		public var vspace:Number = -2;
		private var _lock:Bitmap;
		public function TabNavigation($x:int=8,$y:int=-5){
			bgAlpha=0;
			x=$x;y=$y;
			tabBar=new TabBar();
			tabBar.selectIndex=0;
			tabContainer=new TabContainer();
			tabBavigationSkin = StyleManager.tabNavigationSkin;
			tabBar.addEventListener(ResizeEvent.RESIZE, onResize);
			tabBar.addEventListener(TabNavigationEvent.SELECT_TAB_CHANGED, selectTabChangedHandler);
			addEventListener(ResizeEvent.RESIZE, onResizeHandler);
		}
		public function set isTween(value:Boolean):void {
			if (tabContainer) {
				tabContainer.isTween=value;
			}
		}
		public function set tabBavigationSkin(skin:TabNavigationSkin):void{
			tabBarSkin = skin.tabBar;
			tabContainerSkin = skin.tabContainer;
		}
		public function removeTabContainerSkin():void{
			tabBarSkin = StyleManager.tabNavigationSkin.tabBar;
			tabContainerSkin = null;
		}
		private var _tabBarPaddingLeft:int=26;
		public function set tabBarPaddingLeft(value:int):void {
			_tabBarPaddingLeft = value;
			if(direction == TabDirection.LEFT || direction == TabDirection.RIGHT){
				tabBar.y=_tabBarPaddingLeft;
			}else{
				tabBar.x=_tabBarPaddingLeft;
			}
		}

		public function set itemDoubleClickEnabled(value:Boolean):void {
			tabBar.itemDoubleClickEnabled=value;
		}

		public function set contentVisible(value:Boolean):void {
			if (tabContainer) {
				tabContainer.visible=value;
			}
		}

		public function get contentVisible():Boolean {
			return tabContainer ? tabContainer.visible : false;
		}

		public function removeTabContainer():void {
			if (tabContainer) {
				removeChild(tabContainer);
			}
		}

		public function addTabContainer():void {
			if (tabContainer) {
				addChildAt(tabContainer, 0);
			}
		}

		public function set tabBarSkin(skin:TabBarSkin):void {
			tabBar.tabBarSkin=skin;
		}

		public function set tabContainerSkin(skin:Skin):void {
			tabContainer.bgSkin=skin;
		}

		public function set direction(value:String):void {
			if (value != _direction) {
				_direction=value;
				updateLayout=true;
				invalidateDisplayList();
			}
		}

		public function get direction():String {
			return _direction;
		}

		override public function set mouseEnabled(enabled:Boolean):void {
			tabContainer.mouseEnabled=enabled;
			super.mouseEnabled=enabled;
		}

		private function selectTabChangedHandler(event:TabNavigationEvent):void {
			_selectedIndex=event.index;
			tabContainer.selectIndex=event.index;
			tabContainer.validateNow();
			dispatchEvent(event.clone());
		}

		private function show():void {
			if (!init) {
				init=true;	
				addChild(tabContainer);
				addChild(tabBar);
			
			}
		}

		private function onResize(evt:ResizeEvent):void {
			updateLayout=true;
			invalidateDisplayList();
		}

		public function addItem(label:String, tab:DisplayObject, w:Number=NaN, h:Number=NaN, index:Number=-1, isLock:Boolean = false):void {
			if(isLock){
				tabBar.addItem(label, w, h,index, _lock);
			}else{
				tabBar.addItem(label, w, h,index);
			}
			tabContainer.addItem(tab,index);
			if(index == -1){
				selectedIndex=0;
			}
			show();
		}
		public function set useDefaultSkin(value:Boolean):void{
			tabBar.useDefaultSkin = value;
		}
		public function addToggleItem(btn:ToggleButton, tab:DisplayObject):void{
			tabBar.addToggleItem(btn);
			tabContainer.addItem(tab, -1);
			selectedIndex=0;
			show();
		}
		public function removeItems():void{
			tabBar.removeItems();
			tabContainer.removeItems();
		}

		private function autoLayout():void {
			if (direction == TabDirection.BOTTOM) {
				tabContainer.width=this.width;
				tabContainer.height=this.height - tabBar.height;
				tabContainer.y=0;
				tabBar.y=tabContainer.height;
			} else if (direction == TabDirection.TOP) {
				tabContainer.width=this.width;
				tabContainer.height=this.height - tabBar.height;
				tabBar.y=0;
				tabBar.x=_tabBarPaddingLeft;
				tabContainer.y=tabBar.height+vspace;
			} else if (direction == TabDirection.LEFT) {
				tabBar.direction=TabDirection.VECTICAL;
				tabBar.validateNow();
				tabBar.x=0;
				tabBar.y=_tabBarPaddingLeft;
				tabContainer.x=tabBar.width+tabBar.x;
				tabContainer.width=this.width - tabBar.width;
				tabContainer.height=this.height;
			} else if (direction == TabDirection.RIGHT) {
				tabBar.direction=TabDirection.VECTICAL;
				tabBar.x=tabContainer.width;
				tabContainer.width=this.width - tabBar.width;
				tabContainer.height=this.height;
			}
		}

		public function set selectedIndex(index:int):void {
			_selectedIndex=index;
			tabBar.selectIndex=index;
		}

		public function get selectedIndex():int {
			return _selectedIndex;
		}

		override public function dispose():void {
			super.dispose();
			if (tabBar) {
				tabBar.dispose();
			}
			if (tabContainer) {
				tabContainer.dispose();
			}
		}

		private function onResizeHandler(event:ResizeEvent):void {
			autoLayout();
		}

		override protected function updateDisplayList(w:Number, h:Number):void {
			super.updateDisplayList(w, h);
			if (updateLayout) {
				updateLayout=false;
				autoLayout();
			}
		}
		
		public function set lock(bitmap:Bitmap):void{
			_lock = bitmap;
		}
	}
}