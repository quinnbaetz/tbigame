package  tbigame.scripts{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	public class tabletLogic {
		
		private var theStage;
		public var theTabletContent;

		function tabletLogic(theStage) {
			var tabletContents = new TabletContent();
			this.theStage = theStage;
			this.theTabletContent = tabletContents;
			theTabletContent.gotoAndStop(2);
			this.theStage.addChild(theTabletContent);
			theTabletContent.alpha = 0;
		}
		
		public function showTablet():void {
			theTabletContent.alpha = 1;
		}
		
		public function hideTablet():void {
			theTabletContent.alpha = 0;
		}

	}
	
}
