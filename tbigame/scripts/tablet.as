package  tbigame.scripts{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.Shape;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	public class tablet {
		
		private var theStage;
		public var theTabletContent;

		public function tablet(theStage) {
			var tabletContents = new TabletContent();
			this.theStage = theStage;
			this.theTabletContent = tabletContents;
			tabletContents.gotoAndStop(2);
		}
		
		public function showTablet():void {
			this.theStage.addChild(theTabletContent);
		}

	}
	
}
