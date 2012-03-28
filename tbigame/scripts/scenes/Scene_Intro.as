var index=0;

var textMsg:TextField = new TextField();
var format:TextFormat = new TextFormat();

var toAdd;
var skipToNextScene;
toolbox.hide();
format.font="Arial";

textMsg.textColor = 0x00FF00; 


switch(timeline){
	case 0:
		toAdd = "Dispatcher: 9-1-1, what is your emergency?\n\n"+
					"Caller: There’s been an accident! He’s not moving!\nWe were biking and he fell and… Oh my gosh…\n\n"+
					"Dispatcher:  Ma’am, just try to remain calm; help is\nbeing dispatched to your location.";
		
		skipToNextScene = function(){
			stage.removeChild(textMsg);
			stage.removeEventListener(MouseEvent.CLICK, skipAhead);
			//Put skip ahead info here
			//currentTool = "thermometer";
			//timeline = 11;
			//gotoAndStop("Scene_Head");
			gotoAndStop("Scene_EMT");
		}
		
		format.size=24;
		textMsg.x = 100;
		
	break;
	case 51:
		toAdd = 	"Doctor: What’s the patient’s condition?\n\n"+
					"EMT: 25 year old male with a biking related head injury.\nAirway is clear, normal breathing, stable blood pressure and body temperature.\nIn the helicopter he had limited response to verbal commands and dilated pupils…\nhe passed out just as we were bringing him into the ER.\n\n"+
					"Doctor: Let me see his file…\nbased on his GCS it’s possible the accident caused underlying damage.\nWe won’t know until we get a CT scan.\n\n"+
					"EMT: Thanks, we lost a lot of time in transport,\n the sooner the patient gets treated the better.\n\n"+
					"Doctor: We’re a little shorthanded;\ndo you need the med student to go back out with you?\nWe could use the extra help.\n\n"+
					"EMT: No problem.\n[To player] I think it’s best you see this one through.\n\n"+
					"Doctor:  Thanks…\n[To player] Follow me.\n\n";

		var skipToNextScene = function(){
			stage.removeChild(textMsg);
			stage.removeEventListener(MouseEvent.CLICK, skipAhead);
			//Put skip ahead info here
			//currentTool = "thermometer";
			//timeline = 11;
			//gotoAndStop("Scene_Head");
			timeline++;
			toolbox.show();
			gotoAndStop("Scene_CTRoom");
		}
		format.size=20;
		textMsg.x = 50;
		
		
	break;
	default:
		return;
};


textMsg.text = toAdd;
textMsg.y += 600/2-textMsg.textHeight/2;

textMsg.text = "";

stage.addChild(textMsg);



var advanceText = function(){
	index++;
	textMsg.text = toAdd.substr(0, index);
	textMsg.y = 600/2-textMsg.textHeight/2-70;
	textMsg.setTextFormat(format);
	textMsg.width = textMsg.textWidth+5;
	textMsg.height = textMsg.textHeight+5;
}

var time = timer(30, advanceText, toAdd.length);
var startedFade = false;
var tween;

var skipAhead = function(){
	if(startedFade){
		tween.stop();
		tween = null;
		skipToNextScene();
		return;
	}
	if(index<toAdd.length){
		index=toAdd.length;
		advanceText();
		time.stop();
		time=null;
	}else{
		startedFade = true;
		tween = createTween(textMsg, "alpha", None.easeInOut, 0, -1, 45, function(){
			
			timer(300, function(){skipToNextScene();});
		});
	}
}


stage.addEventListener(MouseEvent.CLICK, skipAhead);