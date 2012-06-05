package 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import mx.containers.*;
	
	//import spark.components.*;

	public class MyPanel extends Panel
	{
		public function MyPanel():void
		{
			x = 0;
			y = 0;
			title = "Chuck's Pic 3"; 
			width = 780; 
			height = 500; 
			  
			//setStyle("paddingTop", 10); 
			//setStyle("paddingLeft", 10); 
			//setStyle("paddingRight",10); 
			//setStyle("paddingBottom", 10); 
			
		}
		
		public function setTitle(_title:String):void
		{
			title = _title;
		}
		
	}
}