package  /*Components*/
{
    import flash.display.Graphics;
    import flash.display.Loader;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.events.TimerEvent;
    import flash.net.*;
    import flash.utils.Timer;
	
	import flash.geom.*;
    
    import mx.containers.Canvas;
    import mx.controls.Alert;
    import mx.events.FlexEvent;
    import mx.graphics.SolidColor;

	import mx.controls.*;
/*    
    import spark.components.*;
    import spark.components.Application;
    import spark.components.Button;
    import spark.core.*;
    import spark.layouts.*;
    import spark.primitives.Rect;
*/

    public class MyApplication extends Canvas
    {
		private var isActive:Boolean = false;

    	//private static var app:Application;
		private static var myLoader:Loader;
		private static var canvas:MyCanvas;
		
		private var panel:MyPanel;
		    	
		private static var basiclayout:MyBasicLayout;

		private var tile:MyTile;
    	private var tile1:MyTile;
    	private var tile2:MyTile;
    	
		private var timer:Timer = null;
		
		public static const DELAY:Number = 1;
		
		private static var myScore:int = 0;

		public function done():Canvas
		{
			return this;
		}
		
        public function MyApplication()
        {
    	
        	//app = this;

        	//stage.frameRate = FRAMERATE;
        	
			//createMainPanel();
			//addChild(MyApplication.mainPanel)

			
			panel = new MyPanel(); 
			this.addChild(panel);

/*			
			var sp:SpriteVisualElement = new SpriteVisualElement();
			sp.left = 50;
			sp.top = 50;
			this.addElement(sp);
			sp.graphics.beginFill(0xffff00,1);
			sp.graphics.drawRoundRect(10,10,100,100,150,150);
			sp.graphics.endFill();

			//var canvas:Components.MyCanvas = new Components.MyCanvas();
*/
/*			
			var group:Group = new Group();
			group.width = 400;
			group.height = 400;
			group.x = 0;
			group.y = 0;
*/
			var bg:Canvas = new Canvas();
			bg.x = 0;
			bg.y = 0;
			bg.height = 195; 
			bg.width = 195; 
			bg.setStyle("backgroundColor", 0xff00ff);
			panel.rawChildren.addChild(bg);
			
//			group.addElement(bg);
			
			//var shape:MyShape = new MyShape(); 
			//this.addElement(shape);
			
			//group.addElement(shape);
			
			//panel.addElement(group);
			
			canvas = new MyCanvas();
			panel.rawChildren.addChild(canvas);
			
			tile = new MyTile(); 
			canvas.rawChildren.addChild(tile);

			tile1 = new MyTile("http://www.isidrogilabert.com/img/vttennis.png"); 
			panel.rawChildren.addChild(tile1);

			tile2 = new MyTile("http://www.isidrogilabert.com/img/yummy.png"); 
			panel.rawChildren.addChild(tile2);

/*			
			group.addElement(tile2);
*/
			
			
/*			
			myLoader = new Loader();
			myLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressStatus);
			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
			
			//var fileRequest:URLRequest = new URLRequest("http://www.isidrogilabert.com/img/isidro.png");
			//myLoader.load(fileRequest);
*/
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
			button.x = width>>1;
			button.y = height>>1;
            button.addEventListener(MouseEvent.CLICK, handleClick);
            addChild( button );
        }
        
        private function handleClick(e:MouseEvent):void
        {
            Alert.show("You clicked it!", "Clickity!");
        }
        
    }
}
