package clash.widget.ui.style
{
	import clash.widget.ui.skins.AccordionSkin;
	import clash.widget.ui.skins.ButtonSkin;
	import clash.widget.ui.skins.CheckBoxSkin;
	import clash.widget.ui.skins.ComboBoxSkin;
	import clash.widget.ui.skins.ListSkin;
	import clash.widget.ui.skins.NumericStepperSkin;
	import clash.widget.ui.skins.PanelSkin;
	import clash.widget.ui.skins.ScrollBarSkin;
	import clash.widget.ui.skins.Skin;
	import clash.widget.ui.skins.SliderSkin;
	import clash.widget.ui.skins.TabBarSkin;
	import clash.widget.ui.skins.TabNavigationSkin;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextFormat;

	public class StyleManager
	{
		public function StyleManager()
		{
		}
		private static var instance:StyleManager = getInstance();
		public static function getInstance():StyleManager{
			if(instance == null){
				instance = new StyleManager();
			}
			return instance;
		}
		
		private var styleProxy:IStyle;
		public function setUpStyle(styleProxy:IStyle):void{
			this.styleProxy = styleProxy;
		}
		public static function get textFormat():TextFormat{
			return instance.styleProxy ? instance.styleProxy.textFormat : null;
		}
		
		public static function get buttonSkin():Skin{
			return instance.styleProxy ? instance.styleProxy.buttonSkin : null;
		}
		
		public static function get selectedSkin():Skin{
			return instance.styleProxy ? instance.styleProxy.selectedSkin : null;
		}
		
		public static function get scrollBarSkin():ScrollBarSkin{
			return instance.styleProxy ? instance.styleProxy.scrollBarSkin : null;
		}
		
		public static function get tabBarSkin():TabBarSkin{
			return instance.styleProxy ? instance.styleProxy.tabBarSkin : null;
		}
		
		public static function get checkBoxSkin():CheckBoxSkin{
			return instance.styleProxy ? instance.styleProxy.checkBoxSkin : null;
		}
		
		public static function get comboBoxSkin():ComboBoxSkin{
			return instance.styleProxy ? instance.styleProxy.comboBoxSkin : null;
		}
		
		public static function get listSkin():ListSkin{
			return instance.styleProxy ? instance.styleProxy.listSkin : null;
		}
		
		public static function get textInputSkin():Skin{
			return instance.styleProxy ? instance.styleProxy.textInputSkin : null;
		}
		
		public static function get textAreaSkin():Skin{
			return instance.styleProxy ? instance.styleProxy.textAreaSkin : null;
		}
		
		public static function get radioButtonSkin():CheckBoxSkin{
			return instance.styleProxy ? instance.styleProxy.radioButtonSkin : null;
		}
		
		public static function get panelSkin():PanelSkin{
			return instance.styleProxy ? instance.styleProxy.panelSkin : null;
		} 
		
		public static function get listItemSkin():Skin{
			return instance.styleProxy ? instance.styleProxy.listItemSkin : null;
		}
		
		public static function get numericStepperSkin():NumericStepperSkin{
			return instance.styleProxy ? instance.styleProxy.numericStepperSkin : null;
		}
		
		public static function get textScrollSkin():ScrollBarSkin{
			return instance.styleProxy ? instance.styleProxy.scrollBarSkin : null;
		}
		
		public static function get sliderSkin():SliderSkin{
			return instance.styleProxy ? instance.styleProxy.sliderSkin : null;
		}
		
		public static function get tabNavigationSkin():TabNavigationSkin{
			return instance.styleProxy ? instance.styleProxy.tabNavigationSkin : null;
		}
		
		public static function get accordionSkin():AccordionSkin{
			return instance.styleProxy ? instance.styleProxy.accordionSkin : null;
		}
	}
}