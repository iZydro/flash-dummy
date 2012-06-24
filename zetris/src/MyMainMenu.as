package
{
	import mx.controls.*;
	import mx.containers.*;
	import flash.events.*;
	
	public class MyMainMenu
	{
		private var boton1:MyMenuItem;
		private var boton2:MyMenuItem;
		
		public function MyMainMenu(canvas:Canvas)
		{
			boton1 = new MyMenuItem(canvas, 32, 32, "Caca");
			boton2 = new MyMenuItem(canvas, 64, 32, "Pipi");
		}
		
		public function process():int
		{
			if (boton1.pressed) return MyApplication.APP_STATUS_RUNNING;
			
			return 0;
		}
		
		public function clear():void
		{
			boton1.kill();
			boton1 = null;

			boton2.kill();
			boton2 = null;
		}
	}
}
