package tbigame.scripts {
	import flash.display.MovieClip;
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class TabletLogic extends MovieClip{
		
		//public var tabletContent;
		public var theStage;
		public var scope;
		private var padX = -105;
		private var padY = 420;
		private var padRot = 30;
		private var scale = .4;
		public var pad;
		public var inToolbox;

		public function TabletLogic(theStage, scope, myToolbox) {
			this.theStage = theStage;
			this.scope = scope;
			
			//set parameters for tablet
			this.pad = new Tablet();
			this.pad.x = padX;
			this.pad.y = padY;
			this.pad.scaleX = scale;
			this.pad.scaleY = scale;
			this.pad.rotation = padRot;
			
			//tabletContent is embedded within the tablet movieClip now
			this.pad.tabletContent.gotoAndStop("defaultScreen");
			this.scope.addCache(this.pad, this.theStage, "Tablet");
			this.inToolbox = myToolbox;
			addContentEvtListeners();
		}
		
		private function addContentEvtListeners() {
			//listens for user click on search button
			this.pad.tabletContent.SearchButton.addEventListener(MouseEvent.CLICK, termSearch);
		}
		
		/* triggered when clicked on search. We take the entered string and see if it is a substring from the list of
		 * valid entries
		 */

		private function termSearch(event:MouseEvent) {
			displayQueryResult(this.pad.tabletContent.SearchInput.text);
		}
		
		//public wrapper for the actual toggle function
		public function padToggle(evt, forceOpen = false, forceClose = false) {
			tabletToggle(evt, forceOpen, forceClose);
		}
		
		/**
		* Hides all elements of searchList
		*/
		private function hideResults():void {
			this.pad.tabletContent.gotoAndStop("searchList");
			//A good place in code to see the strange instance names!
			this.pad.tabletContent.EMT.alpha = 0;
			this.pad.tabletContent.Penlight.alpha = 0;
			this.pad.tabletContent.Stethoscope.alpha = 0;
			this.pad.tabletContent.EarTherm.alpha = 0;
			this.pad.tabletContent.BPCuff.alpha = 0;
			this.pad.tabletContent.Gauze.alpha = 0;
			this.pad.tabletContent.GCS.alpha = 0;
			this.pad.tabletContent.MedevacHeli.alpha = 0;
		}
		
		private function displayAll():void {
			this.pad.tabletContent.EMT.alpha = 1;
			this.pad.tabletContent.Penlight.alpha = 1;
			this.pad.tabletContent.Stethoscope.alpha = 1;
			this.pad.tabletContent.EarTherm.alpha = 1;
			this.pad.tabletContent.BPCuff.alpha = 1;
			this.pad.tabletContent.Gauze.alpha = 1;
			this.pad.tabletContent.GCS.alpha = 1;
			this.pad.tabletContent.MedevacHeli.alpha = 1;
		}
		
		/**
		* Uses indexOf to check for subStrings. hideResults will first set
		* all elements invisible, and if indexOf spots match it will reveal it.
		*/
		private function displayQueryResult(queryStr:String):void {
			hideResults();
			var numFound:int = 0;
			trace("string of query is: " + queryStr);
			var foundStr:String = "Emergency medical technician";
			//began the great if statement sequence
			if(foundStr.search(queryStr) >= 0 ){
				//EXAMPLE IF *** ALL ARE THE SAME BEYOND
				//Set alpha to opaque
				this.pad.tabletContent.EMT.alpha = 1;
				//numFound will "crunch" the found search terms into a nice order from sart point -97
				this.pad.tabletContent.EMT.y = -97 + numFound*24;
				//if we've found it, then iterate numFound for next possible if
				numFound++;
			}
			foundStr = "Penlight";
			if(foundStr.search(queryStr) >= 0 ) {
				this.pad.tabletContent.Penlight.alpha = 1;
				this.pad.tabletContent.Penlight.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "Stethoscope";
			if(foundStr.search(queryStr) >= 0 ) {
				this.pad.tabletContent.Stethoscope.alpha = 1;
				this.pad.tabletContent.Stethoscope.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "Ear thermometer";
			if(foundStr.search(queryStr) >= 0 ) {
				this.pad.tabletContent.EarTherm.alpha = 1;
				this.pad.tabletContent.EarTherm.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "Blood pressure cuff";
			if(foundStr.search(queryStr) >= 0 ) {
				this.pad.tabletContent.BPCuff.alpha = 1;
				this.pad.tabletContent.BPCuff.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "Gauze";
			if(foundStr.search(queryStr) >= 0){
				this.pad.tabletContent.Gauze.alpha = 1;  
				this.pad.tabletContent.Gauze.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "Glasgow Coma Scale";
			if(foundStr.search(queryStr) >= 0 ) {
				this.pad.tabletContent.GCS.alpha = 1;
				this.pad.tabletContent.GCS.y = -97 + numFound*24;
				numFound++;
			}
			foundStr = "Medevac helicopter";
			if(foundStr.search(queryStr) >= 0 ) {
				this.pad.tabletContent.MedevacHeli.alpha = 1;
				this.pad.tabletContent.MedevacHeli.y = -97 + numFound*24;
				numFound++;
			}
			if(numFound == 0) {
				displayAll();
			}
			this.pad.tabletContent.SearchInput.text = "";
		}
		
		private function tabletToggle(evt, forceOpen = false, forceClose = false): void {
			trace("here");

			if((pad.x<-50 || forceOpen) && !forceClose){
				trace("opening");
				this.inToolbox.hideMenu();
				this.scope.createTween(pad, "x", None.easeInOut, 20);
				this.scope.createTween(pad, "y", None.easeInOut, 5);
				this.scope.createTween(pad, "scaleX", None.easeInOut, 1);
				this.scope.createTween(pad, "scaleY", None.easeInOut, 1);
				this.scope.createTween(pad, "rotation", None.easeInOut, 0, -1, 10, function(){
					//ExternalInterface.call("showTabletContent");
				});
				return;
			}
			if(pad.x>=-50 || forceClose){
				trace("closing");
				var myTimer:Timer = new Timer(250, 1);
				myTimer.start();
				var scope = this.scope;
				myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, function(){
					myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, arguments.callee);
					myTimer = null;
					scope.createTween(pad, "x", None.easeInOut, padX);
					scope.createTween(pad, "y", None.easeInOut, padY);
					scope.createTween(pad, "scaleX", None.easeNone, scale);
					scope.createTween(pad, "scaleY", None.easeNone, scale);
					scope.createTween(pad, "rotation", None.easeInOut, padRot);
				 });
				 //ExternalInterface.call("hideTabletContent");
			} 
		}

	}
	
}
