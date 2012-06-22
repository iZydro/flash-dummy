package
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import mx.containers.Canvas;

	public class MyKeyboard
	{
		public var up:MyKey;
		public var down:MyKey;
		public var left:MyKey;
		public var right:MyKey;

		public function MyKeyboard()
		{
			up = new MyKey();
			down = new MyKey();
			left = new MyKey();
			right = new MyKey();
			clear();
		}
		
		public function clear():void
		{
			up.clear();
			down.clear();
			left.clear();
			right.clear();
		}
		
		public function setCallbacks(canvas:Canvas):void
		{
			canvas.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			canvas.stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
		}

		private function keyPressedUp(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			
			switch (key)
			{
				case Keyboard.LEFT  :  left.pressedUp(); break;
				case Keyboard.RIGHT : right.pressedUp(); break;
				case Keyboard.UP :       up.pressedUp(); break;
				case Keyboard.DOWN:    down.pressedUp(); break;
			}
			
		}
		
		private function keyPressedDown(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			
			switch (key)
			{
				case Keyboard.LEFT :   left.pressedDown(); break;
				case Keyboard.RIGHT : right.pressedDown(); break;
				case Keyboard.UP :       up.pressedDown(); break;
				case Keyboard.DOWN :   down.pressedDown(); break;
			}
		}
		
		public function processKeyboard(elapsed:int):void
		{
			left.process(elapsed);
			right.process(elapsed);
			up.process(elapsed);
			down.process(elapsed);
		}
		
	}
}
