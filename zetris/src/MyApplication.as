package  /*Components*/
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Loader;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.TimerEvent;
    import flash.geom.*;
    import flash.net.*;
    import flash.ui.Keyboard;
    import flash.utils.*;
    import flash.utils.Timer;
    
    import mx.containers.Canvas;
    import mx.controls.*;
    import mx.controls.Alert;
    import mx.events.DragEvent;
    import mx.events.FlexEvent;
    import mx.graphics.SolidColor;

	[SWF(width = "1024", height = "768")]
	public class MyApplication extends Canvas
    {
		
		public static var ZT_TILES_X:int = 8;
		public static var ZT_TILES_Y:int = 12;
		public static var ZT_TILES_SIZE:int = 32;
		
		private var ZETRI_STATUS_MOVING:int = 1;
		private var ZETRI_STATUS_CONSOLIDATING:int = 2;
		
		private var zetriStatus:int;
		
		private var isActive:Boolean = false;

		private static var myLoader:Loader;
		private static var canvas:MyCanvas;
		
		private var panel:MyPanel;
		    	
		private static var basiclayout:MyBasicLayout;

		private var tile:MyTile;
    	private var tile1:MyTile;
    	private var tile2:MyTile;
    	
		private var timer:Timer = null;
		private var elapsedTimer:int;
		private var currentTimer:int;
		
		public static const DELAY:Number = 1000 / 30;
		
		private static var myScore:int = 0;
		
		//private var bs1:MyBaseSprite;
		
		private var bs0:Sprite;
		private var bs1:Sprite;
		
		private var tiles:Array = new Array;
		
		private var board:MyBoard;
		private var zetri:MyZetrimino;
		
		private var ztColors:Array = [ 0xff0000, 0x00ff00, 0x00ffff ];
		
		private var bsBase:MyBaseSprite;
		
		private var leftPressed:Boolean, rightPressed:Boolean, upPressed:Boolean, downPressed:Boolean, downReleased:Boolean;
		
		private var gameover:GameOver = null;
		
		public function done():Canvas
		{
			return this;
		}
		
        public function MyApplication()
        {
    	
			x=0;
			y=0;
			panel = new MyPanel();
			this.addChild(panel);

			board = new MyBoard(ZT_TILES_Y, ZT_TILES_X, ZT_TILES_SIZE, panel);

			zetri = new MyZetrimino(board);
			zetriStatus = ZETRI_STATUS_MOVING;
	
			currentTimer = getTimer();

	        timer = new Timer(DELAY);
	        timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.start();

			addEventListener(FlexEvent.CREATION_COMPLETE, creationHandler);
			
			leftPressed = rightPressed = upPressed = downPressed = false;
			downReleased = true;
			gameover = null;
		
		}
		
		private function initGame():void
		{
			//while(board.getNumTiles()) board.deleteOneTile(panel);
			
			board.deleteBoardImages();

			board.deleteZininos();
			
			zetri = new MyZetrimino(board);
			zetriStatus = ZETRI_STATUS_MOVING;

		}

	    private function onTimerTick(event:TimerEvent):void
	    {
			
			var now:int = getTimer();
			elapsedTimer = now - currentTimer;
			currentTimer = now;
			
			if (gameover)
			{
				if (gameover.process(elapsedTimer, panel, board))
				{
					initGame();
					gameover = null;
				}
				return;
			}
			
			switch(zetriStatus)
			{
				case ZETRI_STATUS_MOVING:
					moveZetrimino();
					break;
				
				case ZETRI_STATUS_CONSOLIDATING:
					break;
					
			}

			// Clear keyboard
			leftPressed = rightPressed = upPressed = downPressed = false;
			
			panel.setTitle("Elapsed: " + elapsedTimer);
		}

		
		private function moveZetrimino():void
		{
			zetri.paint(panel);
			
			var done:Boolean = zetri.move(board, elapsedTimer, leftPressed, rightPressed, upPressed, downPressed, downReleased);
			if (done)
			{
				zetri.consolidate(board);
				zetri.unpaint(panel);
				zetri = null;
				
				board.checkCompleteLines();
				
				zetri = new MyZetrimino(board);
				zetriStatus = ZETRI_STATUS_MOVING;

				if (!zetri.checkGoodPos(board))
				{
					// GAME OVER!
					zetri.consolidate(board);
					zetri.paint(panel);
					zetri.unpaint(panel);
					zetri = null;
					gameover = new GameOver();
				}
			
				if (downPressed) downReleased = false;
			}
				    	
	    }
		
		public function addScore(score:int):void
		{
			myScore += score;	
		}

		public function onProgressStatus(e:ProgressEvent):void
		{   
		      // this is where progress will be monitored     
		      //trace(e.bytesLoaded, e.bytesTotal); 
		}
		
		public function onLoaderReady(e:Event):void
		{     
		      // the image is now loaded, so let's add it to the display tree!     
		      MyApplication.canvas.rawChildren.addChild(myLoader);
		}			
		

        private function creationHandler(e:FlexEvent):void
        {
			trace("Create button");
			isActive = true;
            var button : Button = new Button();
            button.label = "My favorite button";
            button.styleName="halo"
			button.x = panel.width>>1;
			button.y = panel.height>>1;
            button.addEventListener(MouseEvent.CLICK, handleClick);
            /*panel.rawChildren.*/addChild( button );
        }

		public function addedApp():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
		}
		
        private function handleClick(e:MouseEvent):void
        {
            Alert.show("You clicked it!", "Clickity!");
        }
		
		private function keyPressedUp(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
			
			switch (key)
			{
				case Keyboard.DOWN:
					downReleased = true;
					break;
			}
			
		}
			
		private function keyPressedDown(event:KeyboardEvent):void
		{
			var key:uint = event.keyCode;
		
			switch (key)
			{
				case Keyboard.LEFT :
					leftPressed = true;
					break;
				case Keyboard.RIGHT :
					rightPressed = true;
					break;
				case Keyboard.UP :
					upPressed = true;
					break;
				case Keyboard.DOWN :
					downPressed = true;
					break;
			}
		}
        
    }
}
