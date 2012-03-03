package tbigame.scripts{
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.events.Event;
	public class Tooltip extends MovieClip{
		
		private var tFormat:TextFormat;
		private var theTextField;
		private var obj;
		private var myStage;
		function Tooltip(hex:Number,hex2:Number, theStage) {
			myStage = theStage;
			theTextField = new TextField();
			theTextField.height = 25;
			this.addChild(theTextField);
			this.graphics.beginFill(hex);
			this.graphics.lineStyle(1, hex2, 100);
			this.graphics.moveTo(0, 0);
			this.graphics.lineTo(100, 0);
			this.graphics.lineTo(100, 20);
			this.graphics.lineTo(20, 20);
			this.graphics.lineTo(15, 30);
			this.graphics.lineTo(10, 20);
			this.graphics.lineTo(0, 20);
			this.graphics.lineTo(0, 0);
			this.graphics.endFill();
			this.visible = false;
			theTextField.selectable = false;
			this.tFormat = new TextFormat();
			this.tFormat.font = "Arial";
			this.tFormat.size = 11;
			this.tFormat.align = "center";
			theTextField.setTextFormat(this.tFormat);
			myStage.addChild(this);
			var that = this;
			myStage.addEventListener(Event.ADDED, function(){
				myStage.setChildIndex(myStage.getChildByName(that.name), myStage.numChildren-1); 
			});
		}
		
		private function movePos(evt){
			this.x = evt.stageX-15;
			this.y = evt.stageY-35;
			if(!obj.hitTestPoint(evt.stageX,evt.stageY,true))
			{
				hideTip();
			}
		}
		
		public function addTip(theObj, theText){
			if(obj){
				obj.removeEventListener(MouseEvent.ROLL_OVER, showTip);
			}
			if(obj && this.hasEventListener(MouseEvent.MOUSE_MOVE)){
				obj.removeEventListener(MouseEvent.MOUSE_MOVE, movePos);
				this.removeEventListener(MouseEvent.MOUSE_MOVE, movePos);
			}
			
			obj = theObj;
			theTextField.text = theText;
			myStage.setChildIndex(myStage.getChildByName(this.name), myStage.numChildren-1);
			obj.addEventListener(MouseEvent.ROLL_OVER, showTip);
			
			showTip();
			this.addEventListener(MouseEvent.MOUSE_DOWN, function(evt){
				obj.dispatchEvent(evt);  
			});
			this.x = stage.mouseX-15;
			this.y = stage.mouseY-35;
								
		}
		
		public function removeTip(){
			trace("removing tip");
			if(obj){
				obj.removeEventListener(MouseEvent.ROLL_OVER, showTip);
			}
			if(obj && this.hasEventListener(MouseEvent.MOUSE_MOVE)){
				obj.removeEventListener(MouseEvent.MOUSE_MOVE, movePos);
				this.removeEventListener(MouseEvent.MOUSE_MOVE, movePos);
			}
			this.visible = false;
		}
		public function showTip(evt = null):void {
			this.visible = true;
			if(obj && !this.hasEventListener(MouseEvent.MOUSE_MOVE)){
				obj.addEventListener(MouseEvent.MOUSE_MOVE, movePos);
				this.addEventListener(MouseEvent.MOUSE_MOVE, movePos);
			}
		}
		
		public function hideTip():void {
			this.visible = false;
			obj.removeEventListener(MouseEvent.MOUSE_MOVE, movePos);
			this.removeEventListener(MouseEvent.MOUSE_MOVE, movePos);
			
		}
	
	}	
}