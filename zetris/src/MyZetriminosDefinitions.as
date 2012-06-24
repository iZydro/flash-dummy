package
{
	public class MyZetriminosDefinitions
	{
		private var shapes:Array = new Array;
		private var colors:Array = new Array;
		
		private var shape1:Array =
			[
				[
					[0,0,1,0],
					[0,1,1,0],
					[0,1,0,0],
				]
				,
				[
					[0,1,1,0],
					[0,0,1,1],
					[0,0,0,0],
				]
				,
				[
					[0,0,1,0],
					[0,1,1,0],
					[0,1,0,0],
				]
				,
				[
					[0,1,1,0],
					[0,0,1,1],
					[0,0,0,0],
				]
			]
			;
		
		private var shape2:Array =
			[
				[
					[0,1,0,0],
					[0,1,1,0],
					[0,0,1,0],
				]
				,
				[
					[0,0,1,1],
					[0,1,1,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,0,0],
					[0,1,1,0],
					[0,0,1,0],
				]
				,
				[
					[0,0,1,1],
					[0,1,1,0],
					[0,0,0,0],
				]
			]
			;
		
		private var shape3:Array =
			[
				[
					[0,0,1,0],
					[0,0,1,0],
					[0,1,1,0],
				]
				,
				[
					[0,1,0,0],
					[0,1,1,1],
					[0,0,0,0],
				]
				,
				[
					[0,1,1,0],
					[0,1,0,0],
					[0,1,0,0],
				]
				,
				[
					[0,1,1,1],
					[0,0,0,1],
					[0,0,0,0],
				]
			]
			;
		
		private var shape4:Array =
			[
				[
					[0,1,0,0],
					[0,1,0,0],
					[0,1,1,0],
				]
				,
				[
					[0,1,1,1],
					[0,1,0,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,1,0],
					[0,0,1,0],
					[0,0,1,0],
				]
				,
				[
					[0,0,0,1],
					[0,1,1,1],
					[0,0,0,0],
				]
			]
			;
		
		private var shape5:Array =
			[
				[
					[0,1,1,0],
					[0,1,1,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,1,0],
					[0,1,1,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,1,0],
					[0,1,1,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,1,0],
					[0,1,1,0],
					[0,0,0,0],
				]
			]
			;
		
		private var shape6:Array =
			[
				[
					[1,1,1,1],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
				]
				,
				[
					[1,1,1,1],
					[0,0,0,0],
					[0,0,0,0],
					[0,0,0,0],
				]
				,
				[
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
					[0,1,0,0],
				]
			]
			;
		
		private var shape7:Array =
			[
				[
					[0,0,0,0],
					[0,1,1,1],
					[0,0,1,0],
				]
				,
				[
					[0,0,1,0],
					[0,1,1,0],
					[0,0,1,0],
				]
				,
				[
					[0,0,1,0],
					[0,1,1,1],
					[0,0,0,0],
				]
				,
				[
					[0,0,1,0],
					[0,0,1,1],
					[0,0,1,0],
				]
			]
			;
		
		public function MyZetriminosDefinitions()
		{
			// 4 inv
			shapes.push(shape1); colors.push(0x0000ff);
			
			// 4
			shapes.push(shape2); colors.push(0xff0000);
			
			// L inv
			shapes.push(shape3); colors.push(0x0000ff);
			
			// L
			shapes.push(shape4); colors.push(0xff0000);
			
			// Square
			shapes.push(shape5); colors.push(0xffff00);
			
			// Long
			shapes.push(shape6); colors.push(0x000080);
			
			// Tricornium
			shapes.push(shape7); colors.push(0x8080ff);
		}
		
		public function getZetriminosShapes():Array
		{
			return shapes;
		}

		public function getZetriminosColors():Array
		{
			return colors;
		}
	}
}