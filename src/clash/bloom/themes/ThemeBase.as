package clash.bloom.themes 
{	
	import clash.bloom.brushes.*;
	
	/**
	 * ThemeBase
	 * 
	 * @author sindney, impaler
	 */
	public final class ThemeBase {
		
		/**
		 * Use this to set your theme. Then new your components.
		 * @param	theme
		 */
		public static function setTheme(theme:ITheme):void {
			theme.initialize();
		}
		
		///////////////////////////////////
		// Gloabal
		///////////////////////////////////
		
		public static var ALPHA:Number = 0.8;
		
		public static var FOCUS:uint = 0xEEDD88;
		
		///////////////////////////////////
		// TextBrushes
		///////////////////////////////////
		
		public static var Text_Button:TextBrush;
		
		public static var Text_CheckBox:TextBrush;
		
		public static var Text_Label:TextBrush;
		
		public static var Text_List:TextBrush;
		
		public static var Text_NumericStepper:TextBrush;
		
		public static var Text_TabBox:TextBrush;
		
		public static var Text_TextBox:TextBrush;
		
		public static var Text_TextInput:TextBrush;
		
		public static var Text_ToggleButton:TextBrush;
		
		///////////////////////////////////
		// ColorBrushes
		///////////////////////////////////
		
		// Accordion
		public static var AC_Title:Brush;
		public static var AC_Content:Brush;
		
		// Button
		public static var Button:Brush;
		
		// CheckBox
		public static var CheckBox:Brush;
		
		// Conatiner
		public static var Container:Brush;
		
		// Form
		public static var Form:Brush;
		public static var Form_ScrollBar:Brush;
		public static var Form_ScrollBarButton:Brush;
		
		// FormItem
		public static var FormItem:Brush;
		
		// List
		public static var List:Brush;
		public static var List_ScrollBar:Brush;
		public static var List_ScrollBarButton:Brush;
		
		// ListItem
		public static var ListItem:Brush;
		
		// NumericStepper
		public static var NumericStepper:Brush;
		public static var NS_Increase:Brush;
		public static var NS_Decrease:Brush;
		
		// ProgressBar
		public static var ProgressBar:Brush;
		
		// ScrollContainer
		public static var ScrollContainer:Brush;
		public static var SC_ScrollBar:Brush;
		public static var SC_ScrollBarButton:Brush;
		
		// Slider
		public static var Slider:Brush;
		public static var SliderButton:Brush;
		
		// TabBox
		public static var TabBox:Brush;
		public static var TabBox_Title:Brush;
		
		// TextBox
		public static var TextBox:Brush;
		public static var TB_ScrollBar:Brush;
		public static var TB_ScrollBarButton:Brush;
		
		// TextInput
		public static var TextInput:Brush;
		
		// ToggleButton
		public static var ToggleButton:Brush;
		
		// ToggleSwitcher
		public static var ToggleSwitcher:Brush;
		
		// Window
		public static var Window:Brush;
		public static var Window_Header:Brush;
		public static var Window_Footer:Brush;
		
	}

}