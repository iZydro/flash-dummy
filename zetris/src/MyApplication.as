package  /*Components*/
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
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
		
		public static var APP_STATUS_LOADING:int   = 1;
		public static var APP_STATUS_MAIN_MENU:int = 2;
		public static var APP_STATUS_RUNNING:int   = 3;
		public static var APP_STATUS_GAME_OVER:int = 4;
		
		private var ZETRI_STATUS_MOVING:int = 1;
		private var ZETRI_STATUS_CONSOLIDATING:int = 2;
		private var ZETRI_STATUS_GRAVITING:int = 3;
		
		private var zetriStatus:int;
		private var zetriTimer:int;
		
		private var appStatus:int;
		
		private var isActive:Boolean = false;

		private static var myLoader:Loader;
		private static var canvas:MyCanvas;
		
		private var mainMenu:MyMainMenu;
		
		private var panel:MyPanel;
		private var menuCanvas:Canvas;
		    	
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
		private var stack:MyZetriminosStack;
		
		private var zetri:MyZetrimino;
		
		private var ztColors:Array = [ 0xff0000, 0x00ff00, 0x00ffff ];
		
		// Sprite used as a template to clone new ones
		public static var sp:/*MyBase*/Sprite;

		private var bsBase:MyBaseSprite;
		
		private var keyboard:MyKeyboard;
		private var zetriminos:MyZetriminosDefinitions;
		
		private var gameover:GameOver = null;
		
		[Embed(source = "../assets/isidro-32.png")]
		private var isidro:Class;
		
		public function done():Canvas
		{
			return this;
		}
		
        public function MyApplication()
        {
			appStatus = APP_STATUS_LOADING;
    	
			sp = new Sprite();
			var displayObj:DisplayObject = new isidro();
			displayObj.x = -displayObj.width>>1;
			displayObj.y = -displayObj.height>>1;
			sp.addChild(displayObj);
			
			panel = new MyPanel();
			this.addChild(panel);

			currentTimer = getTimer();
			
			timer = new Timer(DELAY);
			timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.start();
			
			//addEventListener(FlexEvent.CREATION_COMPLETE, creationHandler);
			
			keyboard = new MyKeyboard();
			
			// Specific values for down key
			keyboard.down.setRepeatDelay(100);
			keyboard.down.setRepeatRate(75);
			
			// Create menu Canvas
			menuCanvas = new Canvas();
			menuCanvas.x = 400;
			menuCanvas.y = 80;
			menuCanvas.height = 300;
			menuCanvas.width = 200;
			menuCanvas.setStyle("backgroundColor",0x00ff00);			
			panel.rawChildren.addChild(menuCanvas);
			
			gameover = null;
			
		}
		
		private function initBoardAndTiles():void
		{
			board = new MyBoard(ZT_TILES_Y, ZT_TILES_X, ZT_TILES_SIZE, panel, sp);

			zetriminos = new MyZetriminosDefinitions();
			stack = new MyZetriminosStack(board, zetriminos);
			
			initGame();
		}
		
		private function initGame():void
		{
			board.deleteBoardImages();

			board.deleteZininos();
			
			//zetri = new MyZetrimino(board, zetriminos);
			zetri = stack.getNextZetrimino();
			
			zetriStatus = ZETRI_STATUS_MOVING;

		}

	    private function onTimerTick(event:TimerEvent):void
	    {
			var now:int = getTimer();
			elapsedTimer = now - currentTimer;
			currentTimer = now;
			
			keyboard.processKeyboard(elapsedTimer);

			// State machine
			switch(appStatus)
			{
				case APP_STATUS_LOADING:
					//if (sp.isActive)
					{
						initBoardAndTiles();
						mainMenu = new MyMainMenu(menuCanvas);
						appStatus = APP_STATUS_MAIN_MENU;
					}
					break;
				
				case APP_STATUS_MAIN_MENU:
					var menuResult:int = mainMenu.process(); 
					if (menuResult != 0)
					{
						appStatus = menuResult;
						
						mainMenu.clear();
						mainMenu = null;

						// Clear keyboard
						keyboard.clear();
						
						// Restore focus to MyApplication
						stage.focus = this
					}
					break;
				
				case APP_STATUS_RUNNING:
					runGame();
					break;
				
				case APP_STATUS_GAME_OVER:
					//board.deleteOneZinino();
					board.updateZetriminos();
					if (gameover.process(elapsedTimer, panel, board))
					{
						initGame();
						gameover = null;
						
						mainMenu = new MyMainMenu(menuCanvas);
						appStatus = APP_STATUS_MAIN_MENU;
					}
					break;
				
			}
		}
		
		private function runGame():void
		{
			switch(zetriStatus)
			{
				case ZETRI_STATUS_MOVING:
					moveZetrimino(elapsedTimer);
					break;
				
				case ZETRI_STATUS_CONSOLIDATING:
					consolidateZetrimino(elapsedTimer);
					break;
				
				case ZETRI_STATUS_GRAVITING:
					gravityZetriminos(elapsedTimer);
					break;
					
			}
			
			// Update Zetriminos animation
			board.updateZetriminos();

			panel.setTitle
			(
				"Elapsed:" + elapsedTimer + 
				" z1:" + stack.getZetriminoAt(0).getType() + 
				" z2:" + stack.getZetriminoAt(1).getType() +
				" z3:" + stack.getZetriminoAt(2).getType()
			);
		}

		
		private function moveZetrimino(elapsedTimer:int):void
		{
			zetri.paint(panel);
			
			var done:Boolean = zetri.move(board, elapsedTimer, keyboard);
			if (done)
			{
				switch (zetri.getStatus())
				{
					case MyZetrimino.ZETRIMINO_STATUS_FREE:
						zetri.setStatus(MyZetrimino.ZETRIMINO_STATUS_LANDED);
						break;
					
					case MyZetrimino.ZETRIMINO_STATUS_LANDING:
						zetriStatus = ZETRI_STATUS_CONSOLIDATING;
						zetriTimer = 0;
						break;
				}
			}
		}

		private function gravityZetriminos(elapsedTimer:int):void
		{
			zetriTimer += elapsedTimer;
			if (zetriTimer >= 200)
			{
				board.checkGravity();
				
				//zetri = new MyZetrimino(board, zetriminos);
				zetri = stack.getNextZetrimino();
				
				zetriStatus = ZETRI_STATUS_MOVING;
				
				if (!zetri.checkGoodPos(board))
				{
					// GAME OVER!
					zetri.consolidate(board);
					zetri.paint(panel);
					zetri.unpaint(panel);
					zetri = null;
					gameover = new GameOver();
					appStatus = APP_STATUS_GAME_OVER;
				}
				
				if (keyboard.down.pressed)
				{
					keyboard.down.clear();
					keyboard.down.force_release();
				}
			}
			
		}
		
		private function consolidateZetrimino(elapsedTimer:int):void
		{
			zetriTimer += elapsedTimer;
			if (zetriTimer >= 200 || true)
			{
				zetri.consolidate(board);
				zetri.unpaint(panel);
				zetri = null;
				
				board.checkCompleteLines();
				
				zetriStatus = ZETRI_STATUS_GRAVITING;
				zetriTimer = 0;
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
            addChild( button );
        }

		public function addedApp():void
		{
			keyboard.setCallbacks(this);
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			//stage.addEventListener(KeyboardEvent.KEY_UP, keyPressedUp);
		}
		
        private function handleClick(e:MouseEvent):void
        {
            Alert.show("You clicked it!", "Clickity!");
        }

    }
}
