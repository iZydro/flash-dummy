package
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.controls.Distractor;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLVariables;
	
	public class index extends Sprite
	{
		public function index()
		{
			trace("caca");
			init();
		}
		
		private function init():void
		{
			var myStr:Object = root.loaderInfo;
				
			ExternalInterface.addCallback("myFlashcall", myFlashcall);
			
			var search:String = ExternalInterface.call("window.location.href.toString");
			search = search.substr(search.indexOf("?") + 1, search.length);
			var vars:URLVariables = new URLVariables(search);
			
			for (var v:String in vars)
			{
				trace(v + " => " + vars[v]);
				ExternalInterface.call("showtext", v + " => " + vars[v]);
			}
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			var ei:* = ExternalInterface.objectID;
			
			trace(ei);
			
			var dis:Distractor = new Distractor();
			addChild(dis);
			
			Facebook.init("1408994869324945", loginHandler);
			
		}
		
		private function loginHandler(a:*, b:*):void
		{
			trace("Login Handler");
		}
		
		private function myFlashcall(str:String):void
		{
			trace("myFlashcall: "+str);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if(ExternalInterface.available)
			{
				trace("onClick");
				var result:* = "caca";
				result = ExternalInterface.call("myFBcall");
				trace(result);
			}
		}
	}
}