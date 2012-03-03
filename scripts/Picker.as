package tbigame.scripts {
	import flash.display.MovieClip;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.utils.getDefinitionByName;
	import flash.filters.GlowFilter;
	public class Picker extends MovieClip
	{
		var theStage;
		var msgBox;  
		var textMsg:TextField;
		var textAnswers;
		function bindCallback(num, callback){
			return function(){
				remove();
				callback(num);
			}
		}
		
		function addBorder(temp){
			return function(){
				temp.border = true;
			}
		}
		function removeBorder(temp){
			return function(){
				temp.border = false;
			}
		}
		function Picker(theStage, x, y, str, choices, callback){
			//should add in word wrap
			//create text
			var format:TextFormat = new TextFormat();
			format.font="Arial";
    		format.size=18;

			textMsg = new TextField();
			textMsg.text  = str;
			//textMsg.autoSize = TextFieldAutoSize.LEFT;
			textMsg.setTextFormat(format);
			textMsg.textColor = 0x000000; 
			textMsg.x = x+10;
			textMsg.y = y+10;
			textMsg.width = 420;
			textMsg.wordWrap = true;
			textMsg.height = textMsg.textHeight+5;
			textMsg.selectable = false;
			textAnswers = new Array();
			var nextPos = textMsg.y + textMsg.height+5;
			for(var i = 0; i<choices.length; i++){
				var temp = new TextField();
				temp.htmlText = "<a href='event:null'>"+choices[i]+"</a>";
				//textMsg.autoSize = TextFieldAutoSize.LEFT;
				temp.setTextFormat(format);
				temp.textColor = 0x000000; 
				temp.x = x+40;
				temp.y = nextPos;
				temp.width = 390;
				temp.wordWrap = true;
				temp.height = temp.textHeight+5;
				temp.selectable = false;
				nextPos = temp.y + temp.height+5;
				
				//Not working right
				temp.addEventListener(MouseEvent.ROLL_OVER, addBorder(temp), false, 0, true);
				temp.addEventListener(MouseEvent.ROLL_OUT, removeBorder(temp), false, 0, true);
				temp.addEventListener(MouseEvent.CLICK, bindCallback(i+1, callback));
				
				textAnswers.push(temp);
				
			}
			//create black box
			msgBox = new Canvas();
			
			msgBox.graphics.lineStyle(2, 0x2a3037);
			msgBox.graphics.beginFill(0x6b6c68, .8);
			msgBox.graphics.drawRoundRect(0, 0, 420+30, (nextPos-y)+30, 25, 25);

			//msgBox.height=420+30;
			//msgBox.width=(nextPos-y)+30;
		
			msgBox.graphics.endFill();
			msgBox.x=x;
			msgBox.y=y;
		
			theStage.addChild(msgBox); 
			
			msgBox.filters = [new GlowFilter(0x222222, .75, 10, 10, 2, 2, false, false)];
			
			theStage.addChild(textMsg);
			for(var i in textAnswers){
				theStage.addChild(textAnswers[i]); 
			}
			this.theStage = theStage;
		}
		
		public function remove(){
			trace("remove msgBox");
			theStage.removeChild(msgBox);
			trace("remove textMsg");
			theStage.removeChild(textMsg);
			for(var i in textAnswers){
				trace("remove msgBox", i);
				theStage.removeChild(textAnswers[i]); 
			}
		}
		

	}
}