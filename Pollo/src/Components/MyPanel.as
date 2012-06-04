package Components
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import spark.components.*;

	public class MyPanel extends Panel
	{
		public function MyPanel():void
		{
			var child:Panel = this; //new SpriteVisualElement();
			top = 20;
			left = 20;
			title = "Chuck's Pic 3"; 
			percentHeight = 95; 
			percentWidth = 95; 
			  
			setStyle("paddingTop", 10); 
			setStyle("paddingLeft", 10); 
			setStyle("paddingRight",10); 
			setStyle("paddingBottom", 10); 
			
		}
		
		public function setTitle(_title:String):void
		{
			title = _title;
		}
		
	}
}