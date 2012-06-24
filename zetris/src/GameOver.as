package
{
	import mx.containers.Panel;

	public class GameOver
	{
		private var timer:int;
		
		public function GameOver()
		{
			timer = 0;
		}
		
		public function process(elapsedTime:int, panel:Panel, board:MyBoard):Boolean
		{
			timer += elapsedTime;
			if (timer >= 2000)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
	}
}