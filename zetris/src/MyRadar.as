package
{
	import mx.containers.*;

	public class MyRadar
	{
		private var canvasT1:Canvas;
		private var canvasT2:Canvas;
		private var canvasT3:Canvas;
		
		private var canvas:Canvas;

		public function MyRadar(menuCanvas:Canvas)
		{
			canvas = menuCanvas;
			
			canvasT1 = new Canvas();
			canvasT1.x = 20;
			canvasT1.y = 20;
			canvasT1.height = 64;
			canvasT1.width = 64;
			canvasT1.setStyle("backgroundColor",0x000000);
			canvas.addChild(canvasT1);
			
			canvasT2 = new Canvas();
			canvasT2.x = 20;
			canvasT2.y = 140;
			canvasT2.height = 64;
			canvasT2.width = 64;
			canvasT2.setStyle("backgroundColor",0x222222);
			canvas.addChild(canvasT2);
			
			canvasT3 = new Canvas();
			canvasT3.x = 20;
			canvasT3.y = 260;
			canvasT3.height = 64;
			canvasT3.width = 64;
			canvasT3.setStyle("backgroundColor",0x444444);
			canvas.addChild(canvasT3);
		}
		
		public function getTileCanvas(num:int):Canvas
		{
			switch(num)
			{
				case 0: return canvasT1; break;
				case 1: return canvasT2; break;
				case 2: return canvasT3; break;
				default: return null; break;
			}
		}
		
		public function clear():void
		{
			canvas.removeChild(canvasT1);
			canvas.removeChild(canvasT2);
			canvas.removeChild(canvasT3);
			canvasT1 = null;
			canvasT2 = null;
			canvasT3 = null;
		}
		
	}
}