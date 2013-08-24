package
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.controls.Distractor;
	import com.facebook.graph.data.FacebookAuthResponse;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLVariables;
	
	import UI.Button;
	
	import facebook.ReceivedRequest;
	
	[SWF(width='760', height='800', backgroundColor='#ffff00', frameRate='30')]
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
			
			//stage.addEventListener(MouseEvent.CLICK, onClick);
			
			var ei:* = ExternalInterface.objectID;
			
			trace(ei);
			
			var dis:Distractor = new Distractor();
			addChild(dis);
			
			Facebook.init("1408994869324945", loginHandler);
			
		}
		
		private function loginHandler(response:FacebookAuthResponse, extra:*):void
		{
			trace("Login Handler accessToken: " + response.accessToken);
			
			var search:String = ExternalInterface.call("window.location.href.toString");
			search = search.substr(search.indexOf("?") + 1, search.length);
			var vars:URLVariables = new URLVariables(search);
			
			var but_send:Button = new Button(64, 40);
			but_send.setText("Request");
			but_send.x = 0;
			but_send.y = 0;
			but_send.addEventListener(MouseEvent.CLICK, onClick);
			addChild(but_send);
			
			for (var v:String in vars)
			{
				trace(v + " => " + vars[v]);
				
				if (v == "request_ids")
				{
					var requests_id_list:Array = vars[v].split(",");
					for (var i:int = 0; i < requests_id_list.length; i++)
					{
						addChild(new ReceivedRequest(requests_id_list[i], response.uid, response.accessToken, i));
					}
				}
			}
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