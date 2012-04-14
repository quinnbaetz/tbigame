trace("---", timeline);
switch(timeline){
	case 50:
		sounds['scene2'] = playSound("sound_scene2", int.MAX_VALUE);
		tweenSound(sounds['scene2'], .8, 0, 10000);
		
		fadeIn(function(){
			stage.addEventListener(MouseEvent.CLICK, function(){
				stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
				fadeOut(function(){
					gotoAndStop("Scene_Intro");
				});
			});
		});
		
		break;
	case 52:
		fadeIn(function(){
			var monitorRegion:ClickRegion = new ClickRegion(stage, 0, 100, 500, 350);
			monitorRegion.addEventListener(MouseEvent.MOUSE_DOWN, function(){
				monitorRegion.removeEventListener(MouseEvent.MOUSE_DOWN, arguments.callee);
				monitorRegion.remove();
				gotoAndStop("Scene_CTQuiz");
			});
		});
		
		break;
		
}

timeline++;
