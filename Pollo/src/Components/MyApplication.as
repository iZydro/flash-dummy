package Components
{
    import flash.events.*;
    import flash.net.*;
    import flash.display.Loader;

    import mx.controls.Alert;
    import mx.events.FlexEvent;

	//import mx.containers.*;
	import mx.containers.Canvas;

    import spark.components.Application;
    import spark.components.Button;

	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.display.Shape;

	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	import spark.core.*;
	import spark.components.*;

    public class MyApplication extends Application
    {
    	private static var app:Application;
		private static var myLoader:Loader;
		private static var canvas:Components.MyCanvas;
    	
    	private var tile:Components.MyTile;
    	private var tile1:Components.MyTile;
    	private var tile2:Components.MyTile;
    	
		private var timer:Timer = null;
		
		public static const FRAMERATE:Number = 200;
		public static const DELAY:Number = 10;

        public function MyApplication()
        {
    	
        	app = this;
        	
        	//stage.frameRate = FRAMERATE;
        	
			//createMainPanel();
			//addChild(MyApplication.mainPanel)

			
			var panel:Components.MyPanel = new Components.MyPanel(); 
			this.addElement(panel);

			var sp:SpriteVisualElement = new SpriteVisualElement();
			sp.left = 50;
			sp.top = 50;
			this.addElement(sp);
			sp.graphics.beginFill(0x00ff00,1);
			sp.graphics.drawRoundRect(10,10,100,100,150,150);
			sp.graphics.endFill();

			//var canvas:Components.MyCanvas = new Components.MyCanvas();
			canvas = new Components.MyCanvas();
			addElement(canvas);
			
			var shape:Components.MyShape = new Components.MyShape(); 
			this.addElement(shape);
			
			tile = new Components.MyTile(); 
			addElement(tile);

			tile1 = new Components.MyTile("http://www.isidrogilabert.com/img/vttennis.png"); 
			addElement(tile1);

			tile2 = new Components.MyTile("http://www.isidrogilabert.com/img/yummy.png"); 
			//addElement(tile2);
			canvas.rawChildren.addChild(tile2);
			
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
	    	tile.move();
	    	tile1.move();
	    	tile2.move();
	    	
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
