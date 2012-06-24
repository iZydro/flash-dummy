package
{
	import flash.events.*;
	
	import mx.containers.*;
	import mx.controls.*;
	
	public class MyMenuItem
	{
		private var label:String;
		public var pressed:Boolean;
		private var canvas:Canvas;
		private var button:Button;
		
		public function MyMenuItem(_canvas:Canvas, y:int, x:int, _label:String)
		{
			button = new Button();
			label = _label;
			button.label = _label;
			button.styleName = "halo"
			button.y = y;
			button.x = x;
			pressed = false;
			button.addEventListener(MouseEvent.CLICK, handleClick);
			canvas = _canvas;
			canvas.addChild( button );
		}
		
		public function kill():void
		{
			canvas.removeChild(button);
		}
		
		private function handleClick(e:MouseEvent):void
		{
			pressed = true;
		}
	}
}