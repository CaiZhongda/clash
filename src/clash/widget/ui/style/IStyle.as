package clash.widget.ui.style
{
	import clash.widget.ui.skins.AccordionSkin;
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
	
	import flash.text.TextFormat;

	public interface IStyle
	{
		function get textFormat():TextFormat;
		function get buttonSkin():Skin;
		function get selectedSkin():Skin;
		function get scrollBarSkin():ScrollBarSkin;
		function get tabBarSkin():TabBarSkin;
		function get checkBoxSkin():CheckBoxSkin;
		function get comboBoxSkin():ComboBoxSkin;
		function get listSkin():ListSkin;
		function get textInputSkin():Skin;
		function get textAreaSkin():Skin;
		function get radioButtonSkin():CheckBoxSkin;
		function get panelSkin():PanelSkin;
		function get listItemSkin():Skin;
		function get numericStepperSkin():NumericStepperSkin;
		function get sliderSkin():SliderSkin;
		function get tabNavigationSkin():TabNavigationSkin;
		function get accordionSkin():AccordionSkin;
	}
}