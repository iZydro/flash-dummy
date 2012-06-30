package
{
	public class MyZetriminosStack
	{
		private var stack:Array = new Array;
		private var board:MyBoard;
		private var definitions:MyZetriminosDefinitions;
		
		public function MyZetriminosStack(the_board:MyBoard, the_definitions:MyZetriminosDefinitions)
		{
			board = the_board;
			definitions = the_definitions;
			fillZetriminos();
		}
		
		public function getNextZetrimino():MyZetrimino
		{
			var zetri:MyZetrimino = stack.pop();
			fillZetriminos();
			return(zetri);
		}

		public function getZetriminoAt(pos:int):MyZetrimino
		{
			var zetri:MyZetrimino = stack[pos];
			return(zetri);
		}
		
		private function fillZetriminos():void
		{
			while(stack.length < 3)
			{
				var zetri:MyZetrimino = new MyZetrimino(board, definitions);
				stack.push(zetri);
			}
		}
	}
}