package Components
{
    import flash.display.Graphics;
    import flash.display.Loader;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.events.TimerEvent;
    import flash.net.*;
    import flash.utils.Timer;
    
    import mx.containers.Canvas;
    import mx.controls.Alert;
    import mx.events.FlexEvent;
    import mx.graphics.SolidColor;
    
    import spark.components.*;
    import spark.components.Application;
    import spark.components.Button;
    import spark.core.*;
    import spark.layouts.*;
    import spark.primitives.Rect;


    public class MyApplication extends Application
    {
		private var isActive:Boolean = false;

    	private static var app:Application;
		private static var myLoader:Loader;
		private static var canvas:Components.MyCanvas;
		
		private var panel:Components.MyPanel;
		    	
		private static var basiclayout:Components.MyBasicLayout;

		private var tile:Components.MyTile;
    	private var tile1:Components.MyTile;
    	private var tile2:Components.MyTile;
    	
		private var timer:Timer = null;
		
		public static const DELAY:Number = 1;
		
		private static var myScore:int = 0;

        public function MyApplication()
        {
    	
        	app = this;

        	//stage.frameRate = FRAMERATE;
        	
			//createMainPanel();
			//addChild(MyApplication.mainPanel)

			
			panel = new Components.MyPanel(); 
			this.addElement(panel);

			var sp:SpriteVisualElement = new SpriteVisualElement();
			sp.left = 50;
			sp.top = 50;
			this.addElement(sp);
			sp.graphics.beginFill(0xffff00,1);
			sp.graphics.drawRoundRect(10,10,100,100,150,150);
			sp.graphics.endFill();

			//var canvas:Components.MyCanvas = new Components.MyCanvas();
			
			var group:Group = new Group();
			group.width = 400;
			group.height = 400;
			group.x = 0;
			group.y = 0;

			var bg:Rect = new Rect();
			bg.fill = new SolidColor(0x00ff00);
			bg.left = 0;
			bg.right = 0;
			bg.top = 0;
			bg.bottom = 0;
			group.addElement(bg);
			
			var shape:Components.MyShape = new Components.MyShape(); 
			//this.addElement(shape);
			
			group.addElement(shape);
			
			panel.addElement(group);
			
			tile = new Components.MyTile(); 
			panel.addElement(tile);

			tile1 = new Components.MyTile("http://www.isidrogilabert.com/img/vttennis.png"); 
			panel.addElement(tile1);

			tile2 = new Components.MyTile("http://www.isidrogilabert.com/img/yummy.png"); 
			//addElement(tile2);
			//tile2.x = 0;
			//tile2.y = 50;
			//tile2.top = 100;
			//tile2.left = 100;
			
			//canvas.rawChildren.addChild(tile2);

			group.addElement(tile2);
			
			canvas = new Components.MyCanvas();
			panel.addElement(canvas);
			
			
			
			myLoader = new Loader();
			myLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressStatus);
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
			
			//var fileRequest:URLRequest = new URLRequest("http://www.isidrogilabert.com/img/isidro.png");
			//myLoader.load(fileRequest);

	        timer = new Timer(DELAY);
	        timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.start();

			addEventListener(FlexEvent.CREATION_COMPLETE, creationHandler);
        }

	    private function onTimerTick(event:TimerEvent):void
	    {
	    	//Alert.show("Timer!");
			if (isActive)
			{
		    	tile.move();
		    	tile1.move();
		    	tile2.move();
				
				panel.setTitle("Papás:" + tile.getScore() + " Tenis: "+ tile1.getScore() + " Yummy: " + tile2.getScore());
			}
	    	
	    }
		
		public function addScore(score:int):void
		{
			myScore += score;	
		}

		public function onProgressStatus(e:ProgressEvent):void
		{   
		      // this is where progress will be monitored     
		      trace(e.bytesLoaded, e.bytesTotal); 
		      //Alert.show(e.bytesLoaded.toString());
		}
		
		public function onLoaderReady(e:Event):void
		{     
		      // the image is now loaded, so let's add it to the display tree!     
		      //Alert.show("Loaded!");
		      MyApplication.canvas.rawChildren.addChild(myLoader);
		      //myLoader.content.x = 10;
		      //Alert.show("Added!");
		      //MyApplication.app.addChild(myLoader.content);
		      //MyApplication.app.addElement(MyApplication.myLoader);
		}			
		

        private function creationHandler(e:FlexEvent):void
        {
			isActive = true;
            var button : Button = new Button();
            button.label = "My favorite button";
            button.styleName="halo"
            button.addEventListener(MouseEvent.CLICK, handleClick);
            addElement( button );
        }
        
        private function handleClick(e:MouseEvent):void
        {
            Alert.show("You clicked it!", "Clickity!");
        }
        
    }
}
