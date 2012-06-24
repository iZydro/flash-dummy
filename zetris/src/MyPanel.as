package 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.containers.*;
	import mx.events.DragEvent;
	
	//import spark.components.*;

	public class MyPanel extends Panel
	{
		private var mx:int;
		private var my:int;
		private var mouseState:int;
		
		public function MyPanel():void
		{
			x = 0;
			y = 0;
			title = "Chuck's Pic 3"; 
			width = 780; 
			height = 500;
			
			/*this.addEventListener(MouseEvent.MOUSE_DOWN, mdown);
			this.addEventListener(MouseEvent.MOUSE_UP, mup);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mmove);*/
			
		}
		
		public function setTitle(_title:String):void
		{
			title = _title;
		}
		
		private function mdown(event:MouseEvent):void
		{
			//trace ("Down! " + mouseX);
			mx = mouseX;
			my = mouseY;
			mouseState = 1;
		}
		
		private function mup(event:MouseEvent):void
		{
			//trace ("Up!");
			/*x += (mouseX - mx);
			y += (mouseY - my);*/
			mouseState = 0;
		}

		private function mmove(event:MouseEvent):void
		{
			if (mouseState == 1)
			{
				//trace ("Move!");
				x += (mouseX - mx);
				y += (mouseY - my);
				
				if (x < 0) x = 0;
				if (y < 0) y = 0;
				
			}
		}
		
		
	}
}