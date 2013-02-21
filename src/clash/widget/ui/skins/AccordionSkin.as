package clash.widget.ui.skins
{
	import clash.widget.ui.controls.Button;

	public class AccordionSkin
	{
		public var branchFunc:Function;
		public var leafFunc:Function;
		public function AccordionSkin()
		{
		}
		
		public function branchSkin(btn:Button):void{
			if(branchFunc != null ){
				btn.bgSkin = branchFunc();
			}
		}
		
		public function leafSkin(btn:Button):void{
			if(leafFunc != null){
				btn.bgSkin = leafFunc();
			}
		}
	}
}