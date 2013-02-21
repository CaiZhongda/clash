package clash.widget.ui.controls
{
	import clash.widget.managers.ToolTipManager;
	import clash.widget.ui.skins.CheckBoxSkin;
	import clash.widget.ui.skins.Skin;
	import clash.widget.ui.style.StyleManager;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class RadioButton extends CheckBox
	{
		public static var SELECTED:String = "selectedevent";
		
		private var _tip:String; 
		
		public function RadioButton(label:String)
		{
			super();
			init();
			this.iconWidth = 19;
			this.iconHeight = 19;
			this.text = label;
		}
		
		private function init():void
		{
			this.height = 19;
			var radioButtonSkin:CheckBoxSkin = StyleManager.radioButtonSkin;
			if(radioButtonSkin){
				iconSkin = radioButtonSkin;
				var unSelectedSkin:Skin = iconSkin.unSelectedSkin;
				if(unSelectedSkin){
					icon.bgSkin = unSelectedSkin;
				}
			}
		}
		
		override protected function click(evt:MouseEvent):void
		{
			if(selected == true)
				return;
			selected = true;
			
			this.dispatchEvent(new Event(SELECTED));
		}
		
		public function set tip(value:String):void
		{
			_tip = value;
			if(_tip=="")
			{
				this.removeEventListener(MouseEvent.ROLL_OVER, showTip);
			}
			else
			{
				this.addEventListener(MouseEvent.ROLL_OVER, showTip);
			}
			
		}
		
		private function showTip(event:MouseEvent):void {
			ToolTipManager.getInstance().show(_tip,0);	
			this.addEventListener(MouseEvent.ROLL_OUT, hideTip);
		}
		private function hideTip(event:MouseEvent):void {
			this.removeEventListener(MouseEvent.ROLL_OUT, hideTip);
			ToolTipManager.getInstance().hide();
		}
	}
}