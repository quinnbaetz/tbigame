gotoAndStop("Scene_EMT");
return;

var toAdd = "1st person POV player: On top of hospital helipad, running toward the helicopter.\n"+
			"The EMT and pilots are running to the helicopter with stretcher. Fade out.\n"+
			"3rd person POV: Helicopter zooming over mountainous terrain.\n"+
			"Brief shots of inside helicopter, 1st POV player.\n"+
			"Helicopter hovers, lands near a person (friend) waving their arms at the helicopter.\n"+
			"1st POV player: gets out of helicopter and goes to patient on the ground begins examining them.\n"+
			"Blurs. [Title menu with new/load game, etc.]\n\n\n"+
			"     Part 1: Initial assessment mini-game\n"+
			"Scene\n"+
			"The patient is laying on his back on the ground, unconscious and with his chin toward his chest.\n"+
			"The friend is standing next to him.\n"+
			"I remember from my training that I should first check the ABC’s when I arrive at the scene of an emergency.\n"+
			"Let’s see… ‘A’ stands for Airway. I have to make sure the head is back so nothing is blocking the patient’s windpipe.\n"+
			"Player clicks on the patient’s neck/head. The head tilts back so the face is upward.\n"+
			"The airway is clear. ‘B’ stands for Breathing, so I should listen for breath.\n"+
			"Player clicks on the patient’s face/mouth.\n"+
			"I can hear his breath so he’s okay. Now I need to check for ‘C,’ circulation. I’ll check for a pulse.\n"+
			"Player clicks on patient’s wrist.\n"+
			"Looks like he’s okay. Better get him to the hospital.";

var textMsg:TextField = new TextField();
textMsg.textColor = 0x000000; 
textMsg.text = toAdd;
textMsg.x = 800/2-textMsg.textWidth/2;
textMsg.y += 600/2-textMsg.textHeight/2;
textMsg.width = 500;
textMsg.height = 500;
addChild(textMsg);

var skipAhead = function(){
		removeChild(textMsg);
		stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
		gotoAndStop("Scene_EMT");
}

stage.addEventListener(MouseEvent.CLICK, skipAhead);