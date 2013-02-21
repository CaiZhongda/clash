package clash.widget.collections {
	/**
	 * 定义迭代器接口
	 */ 
	public interface IIterator {
		
		function reset():void;
		function next():Object;
		function hasNext():Boolean;		
	}
}