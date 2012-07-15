package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import mx.containers.Canvas;
	
	public class MyZetrimino
	{
		private var tick:int = 1000;
		private var fasttick:int = 50;
		private var firsttick:int = -400;
		
		// Time that a Zetrimino can move after having landed
		private var time_move_landed:int = 500;
		
		private var shape:Array;
		private var shapeTile:Array;
		private var shapeColor:int;
		private var shapeType:int;
		
		// Array containing the sprites that form the Zetrimino
		private var sprites:Array = new Array;

		// Array containing the sprites that form the Zetrimino radar
		private var minisprites:Array = new Array;
		
		// Data related to the Zetrimino logic
		private var posx:int, posy:int;
		
		// pos_faked_x is the x original coordinate after faking it to permit to rotate the Zetriminos near a wall
		// After rotate is pressed, the game will try to use the real x again instead of the faked position
		// If a rotation makes a piece go out of bounds, the game will try to change the x position and will keep a copy on pos_faked_x
		private var pos_faked_x:int;
		
		private var frame:int;
		
		private var timer:int;
		
		public static var ZETRIMINO_STATUS_FREE:int = 0;
		public static var ZETRIMINO_STATUS_LANDED:int = 1;
		public static var ZETRIMINO_STATUS_LANDING:int = 2;
		
		private var status:int;
		
		public function MyZetrimino(board:MyBoard, zetriminos:MyZetriminosDefinitions)
		{
			var shapes:Array = new Array;
			shapes = zetriminos.getZetriminosShapes();
			
			var colors:Array = new Array;
			colors = zetriminos.getZetriminosColors();
			
			var tile:int = Math.floor(Math.random()*(shapes.length));
			shapeType = tile;
			shapeTile = shapes[shapeType];
			shapeColor = colors[shapeType];
			
			frame = 0; // Math.floor(Math.random()*(shapeTile.length));
			shape = shapeTile[frame];
			
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					var imgContainer1:Sprite = new Sprite();
					imgContainer1.graphics.beginFill(shapeColor);
					imgContainer1.graphics.lineStyle(1,0x00ff00);
					imgContainer1.graphics.drawRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE);
					imgContainer1.graphics.endFill();
					imgContainer1.x = x * MyApplication.ZT_TILES_SIZE + 50;
					imgContainer1.y = y * MyApplication.ZT_TILES_SIZE + 50;
					sprites.push(imgContainer1);
					
					imgContainer1 = new Sprite();
					imgContainer1.graphics.beginFill(shapeColor);
					imgContainer1.graphics.lineStyle(1,0x00ff00);
					imgContainer1.graphics.drawRect(0, 0, MyApplication.ZT_MINITILES_SIZE, MyApplication.ZT_MINITILES_SIZE);
					imgContainer1.graphics.endFill();
					//imgContainer1.x = x * MyApplication.ZT_TILES_SIZE + 50;
					//imgContainer1.y = y * MyApplication.ZT_TILES_SIZE + 50;
					minisprites.push(imgContainer1);
				}
			}
			
			timer = firsttick;
			
			posx = board.getSizeX() / 2 - 2;
			
			posx = 0;
			pos_faked_x = posx;
			posy = 0;
			
			status = ZETRIMINO_STATUS_FREE;
			
		}
		
		public function setX(_x:int):void
		{
			posx = _x;
			pos_faked_x = posx;
		}
		
		public function getType():int
		{
			return shapeType;
		}
		
		public function getX():int
		{
			return posx;
		}
		
		public function getY():int
		{
			return posy;
		}
		
		public function getShape():Array
		{
			return shape;			
		}
		
		public function getStatus():int
		{
			return status;
		}
		
		public function setStatus(the_status:int):void
		{
			status = the_status;
		}

		// Unpaint Zetriino
		
		public function unpaint_radar(canvas:Canvas):void
		{
			do_unpaint(canvas, minisprites);
		}
		
		public function unpaint(canvas:Canvas):void
		{
			do_unpaint(canvas, sprites);
		}
		
		public function do_unpaint(canvas:Canvas, the_sprites:Array):void
		{
			for (var i:int = 0; i < the_sprites.length; i++)
			{
				if (canvas.rawChildren.contains(the_sprites[i]))
				{
					var imgContainer1:Sprite = the_sprites[i];
					canvas.rawChildren.removeChild(imgContainer1);
				}
			}
		}
		
		// Paint Zetrimino
		
		public function paint_radar(canvas:Canvas):void
		{
			do_paint(canvas, minisprites, MyApplication.ZT_MINITILES_SIZE);
		}
		
		public function paint(canvas:Canvas):void
		{
			do_paint(canvas, sprites, MyApplication.ZT_TILES_SIZE);
		}

		public function do_paint(the_canvas:Canvas, the_sprites:Array, the_size:int):void
		{
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					var spr:Sprite = the_sprites[y*shape[y].length + x];
					
					if ((posy+y) >= 0)
					{
						if (shape[y][x] == 1)
						{
							// Pieza
							spr.x = (posx + x) * the_size;
							spr.y = (posy + y) * the_size;
							
							if (!the_canvas.rawChildren.contains(spr))
							{
								the_canvas.rawChildren.addChild(spr);
							}
						}
						else
						{
							// Blanco
							if (the_canvas.rawChildren.contains(spr))
							{
								the_canvas.rawChildren.removeChild(spr);
							}
						}
					}
				}
			}
			
		}
		
		public function move(board:MyBoard, elapsed:int, keyboard:MyKeyboard):Boolean
		{
			
			if (status == MyZetrimino.ZETRIMINO_STATUS_LANDED)
			{
				status = MyZetrimino.ZETRIMINO_STATUS_LANDING;
				timer = 0;
			}
			
			var VALID:Boolean = false;
			var INVALID:Boolean = true;
			
			timer += elapsed;
			
			var oldx:int = posx;
			var oldy:int = posy;
			
			if(keyboard.left.triggered || keyboard.left.repeated)  
			{
				posx--;
				pos_faked_x = posx;
			}
			
			if(keyboard.right.triggered || keyboard.right.repeated)
			{
				posx++;
				pos_faked_x = posx;
			}
			
			if(keyboard.up.triggered)
			{
				// Let's use the original x not being faked first!
				
				posx = pos_faked_x;
				
				var oldframe:int = frame;
				frame++;
				frame %= shapeTile.length;
				shape = shapeTile[frame];
				if (!checkGoodPos(board))
				{
					// The Zetrimino did not fit after rotating
					
					// Let's try to fake the x position. Twice...
					
					pos_faked_x = posx;

					var found:Boolean = false;
					var counter:int = 0;
					while (counter < 2 && !found)
					{
						if (posx >= (board.getSizeX()>>1))
						{
							posx--;
						}
						else
						{
							posx++;
						}
						
						if (checkGoodPos(board))
						{
							found = true;
						}
						counter++;
					}
					if (!found)
					{
						posx = pos_faked_x;
						frame = oldframe;
						shape = shapeTile[frame];
					}
				}
			}
			
			// Control of down key. Not based on key repeat, instead on timer and pressed
			
			// If dow key is pressed, skip longer wait for first frame
			if (keyboard.down.triggered || keyboard.down.pressed)
			{
				if (timer < 0) timer = fasttick;
			}
			
			// Select tick time
			
			var thistick:int = tick;
			if (keyboard.down.triggered || keyboard.down.pressed)
			{
				thistick = fasttick; 
			}
			
			if (status == MyZetrimino.ZETRIMINO_STATUS_LANDING)
			{
				thistick = time_move_landed;
			}
			
			//var thistick:int = (keyboard.down.triggered || keyboard.down.pressed) ? fasttick : tick;
			
			if (timer >= thistick)
			{
				timer -= thistick;
				posy += 1;
			}
			
			var newx:int = posx;
			var newy:int = posy;

			if (oldx == newx && oldy == newy)
			{
				// Did not even try to move
				return VALID;
			}
			
			// If we are here, it means that the Zetrimino wanted to move
			
			if (checkGoodPos(board))
			{
				zetriFree(oldy, newy);
				return VALID;
			}
			
			// No ha cabido, probamos primero solo Y si ha habido movimiento en Y
			
			if (oldy != newy)
			{
				posx = oldx;
				posy = newy;
				if (checkGoodPos(board))
				{
					zetriFree(oldy, newy);
					return VALID;
				}
				else
				{
					if (newy != oldy)
					{
						// Hemos tocado suelo!!!
						posx = oldx;
						posy = oldy;
						return INVALID;
					}
					return VALID;
				}
			}
			
			// Check only X
			posx = newx;
			posy = oldy;
			if (!checkGoodPos(board))
			{
				// No ha habido manera 
				posx = oldx;
				posy = oldy;
			}

			return VALID;
		}
		

		private function zetriFree(oldy:int, newy:int):void
		{
			// If moved and was good in landing mode, give more time to move
			if (status == MyZetrimino.ZETRIMINO_STATUS_LANDING)
			{
				timer = 0;
				//if (oldy != newy)
				{
					// If it moved in X, back to normal mode
					status = MyZetrimino.ZETRIMINO_STATUS_FREE;
				}
			}

		}
		
		public function checkGoodPos(board:MyBoard):Boolean
		{
			// Comprobamos que ninguna tile del zetrimino está fuera del panel
			
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					/*if ((y+posy) < 0)
					{
					}
					else*/
					{
						if (shape[y][x] == 1)
						{
							if ( (x+posx) < 0 || (x+posx >= MyApplication.ZT_TILES_X) ) return false;
							if ( /*(y+posy) < 0 ||*/ (y+posy >= MyApplication.ZT_TILES_Y) ) return false;
							
							if (board.getZininoAt(y+posy, x+posx) == 2) return false;
						}
					}
				}
			}
			
			return true;
		}

		public function consolidate(board:MyBoard):void
		{
			for (var y:int = 0; y < shape.length; y++)
			{
				for (var x:int = 0; x < shape[y].length; x++)
				{
					if (y+posy >= 0)
					{
						if (shape[y][x] == 1)
						{
							var sp:Sprite = new Sprite();//board.getZininoImageAt(y+posy, x+posx);
							
							
							var bm:Bitmap;
							
							// Create class
							var mbm:MyBitmap = new MyBitmap();
							
							// Create bitmap data to be copied
							//var mybmd:BitmapData = mbm.createBitmapData(bsBase.width, bsBase.height, bsBase);
							var mybmd:BitmapData = mbm.createBitmapData(MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, MyApplication.sp);
							
							// Fetch bitmap data to bitmap
							bm = mbm.createBitmap();
							bm.x = 0;//size_tile >> 1;
							bm.y = 0;//size_tile >> 1;
							
							// And add it to the Sprite holder
							sp.addChild(bm);
							
							
							sp.visible = true;
	/*						
							sp.graphics.beginFill(0xff0000);
							sp.graphics.drawRoundRect(0, 0, MyApplication.ZT_TILES_SIZE, MyApplication.ZT_TILES_SIZE, 32);
							sp.graphics.endFill();
	*/						
							sp.x =  (x+posx) * MyApplication.ZT_TILES_SIZE/* + 50*/;
							sp.y =  (y+posy) * MyApplication.ZT_TILES_SIZE/* + 50*/;
							
							// Create the MyZydroSprite
							var myz:MyZydroSprite = new MyZydroSprite(sp);
							myz.setX( (x+posx) * MyApplication.ZT_TILES_SIZE/* + 50*/);
							myz.setY( (y+posy) * MyApplication.ZT_TILES_SIZE/* + 50*/);
							//myz.update();
							
							// Set the new image
							
							var sp_behind:MyZydroSprite = board.getZininoImageAt(y+posy, x+posx);
							if (sp_behind == null)
							{
								// There was a Zinino there already
								board.setZininoImageAt(y+posy, x+posx, myz);
								board.boardCanvas.rawChildren.addChild(myz.getSprite());
								
								// Set the logical piece
								board.setZininoAt(y+posy, x+posx, 2);
							}
						}
					}
				}
			}
		}
		
	}
}
