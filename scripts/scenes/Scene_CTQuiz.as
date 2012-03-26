import flash.geom.Point;
import flash.display.MovieClip;
import tbigame.scripts.Message;


var createPopupBox = function(){
	var pbox:MovieClip = new popupBox();
	pbox.x = WIDTH/2-pbox.width/2;
	pbox.y = HEIGHT/2-pbox.height/2;
	pbox.gotoAndStop(0);
	stage.addChild(pbox);
	return pbox
}

var loadImageAnimation = function(pbox, callback){
	pbox.gotoAndStop(2);
	var tween = null;
	var delayTimer = null;
	var pbar = pbox.getChildByName("scanProgress");
	pbar = pbox.scanProgress;
	var tempFun = function(){
		if(delayTimer !== null){
			delayTimer.stop();
			delayTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			delayTimer = null;
		}else{
			tween.fforward();
		}
	}
	delayTimer = timer(500, function(){
		delayTimer = null;
		tween = createTween(pbar, "width", None.easeInOut, 271, -1, 50, function(){
			delayTimer = timer(500, function(){
				trace("scan done");
				stage.removeEventListener(MouseEvent.CLICK, tempFun);
				stage.removeChild(pbox);
				callback();
			});
		});
	});
	stage.addEventListener(MouseEvent.CLICK, tempFun);
							
}
var doctorDialogIntro = function(callback){
	
	var messages = new Array("I’ll start with a quick introduction to our imaging system."); 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
		
}

var doctorDialogCTScanExplained = function(callback){
	
	var messages = new Array("A Computerized Tomography (or “CT”) scan is an x-ray that allows us to create an image of a patient’s brain.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
		
} 

var doctorDialogAdvanceOption = function(callback){
	
	var messages = new Array("The CT scans will appear on the right and illustrations of a brain will appear on the left.",
							 "Click “Begin” to get started.");
							 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
		
}


var doctorDialog2 = function(callback){
	
	var messages = new Array("Take your time examining the appearance of each landmark in both the CT scan and the illustrated image.",
							 "To move to the next structure just click your mouse.");
							 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
		
}

var doctorDialogReview = function(callback){
	var messages = new Array("Move your mouse over the parts you need to review.","Click when you are ready to take the quiz");
							 
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
	
};

var doctorDialogTest = function(callback){
	var messages = new Array("Ok, match the terms that appear below with the brain region on the CT image.",
							 "Move your mouse over the scan to see the regions you select, then click the region you think matches the term to mark your answer.");

	displayMessages(messages, 50, 60, callback, false, "doctorFace");
	
};

var doctorDialogFinished = function(callback){
	var messages = new Array("Looks like you listened during class!", "Now that you are familiar with a healthy brain, Let’s examine some common injury types as they appear on a CT image.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogOpenInjury = function(callback){
	var messages = new Array("Here is a CT scan of a patient who sustained an open or penetrating head injury from a gunshot wound to the head.",
							 "The arrows are pointing to the air pockets where the bullet damaged the brain.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogHematoma = function(callback){
	var messages = new Array("In other cases, a traumatic brain injury results in a build-up of blood in the head called a hematoma.",
							 "Hematomas and blood appear almost as white as bone on the CT scan.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogBleedingInjury = function(callback){
	var messages = new Array("Damage to the brain that results in internal bleeding reduces a hematoma. ");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogEpiduralInjury = function(callback){
	var messages = new Array("Here is an example of an epidural hematoma.", 
							 "We identified the type of hematoma because it is lens shaped and forms between the dura mater (the tough membrane that covers the brain) and the skull.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogSubduralInjury = function(callback){
	var messages = new Array("Another type of hematoma is a subdural hematoma, meaning it forms below the dura mater next to the brain.",
							 "We can recognize it due to its crescent shape.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogGoToScan = function(callback){
	var messages = new Array("Now that you are familiar with the CT imaging system, lets take a look at the patient’s scans");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogSlicesExplained = function(callback){
	var messages = new Array("We will take images from a series of horizontal ‘slices’ through the head. The view is from the bottom up, so remember that the structures on the LEFT side of the CT scan are actually on the RIGHT side of the patient.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};
var doctorDialogSidesExplained = function(callback){
	var messages = new Array("In the CT scan image, can you click the part that represents the RIGHT hemisphere of the patient’s brain?");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};
var doctorDialogSidesWrong = function(callback){
	var messages = new Array("Remember, the image you see on the scan is flipped.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};
var doctorDialogSidesCorrect = function(callback){
	var messages = new Array("Excellent, now let’s review some of the anatomical landmarks of a healthy brain.");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};

var doctorDialogReviewQuestion = function(callback){
	var messages = new Array("Ok, now that you have had a chance to look over the landmarks, let’s see how well you can identify them on the CT scan.  Do you want to review one last time?");
	displayMessages(messages, 50, 60, callback, false, "doctorFace");
};



var displayQuiz = function(){
	names = [{id: "frontalLobe", name: "Frontal Lobe", desc : "Among the many functions are executive functions such as attention, short-term memory tasks, planning, and drive. The region appears gray on the CT image as the tissue of the brain is less dense than bone."},
				{id: "temporalLobe", name: "Temporal Lobe", desc : "Functions include the processing of hearing, language and senses such as temperature, taste, and long term memory."},
				{id: "occipitalLobe", name: "Occipital Lobe", desc : "The center of our visual perception system. This region receives visual signals to identify stationary and moving objects and recognize patterns."},
				{id: "skull", name: "Skull", desc : "Made up of the bones of the braincase and face, the framework of the head appears almost white on a CT scan due to the high density of bone."},
				{id: "cerrebellum", name: "Cerebellum", desc : "Crucial in motor control, this region is responsible for coordination, precision and timing of motor activity. Its visibility on a CT scan will vary based on where in the brain the image was taken."},
				{id: "lateralVentrical", name: "Lateral Ventricle", desc : "Appearing black on a CT scan, they provide a pathway for the circulation of the cerebrospinal fluid, protecting the head from trauma."},
				{id: "thalamus", name: "Thalamus", desc : "Sensory relay station for the brain. It receives sensory information from all over the body. Slight changes in density can make the structure visible on a CT scan from surrounding brain tissue."}]
	
	brain = new brainBase();
	ct = new ctBase();
	brain.x = 60;
	brain.y = 40;
	ct.x = 510;
	ct.y = 40;
	
	desc = new TextField();
	desc.x = 50; desc.y = 353;
	desc.width = 700; desc.height = 134;
	desc.wordWrap = true;
	
	
	
	
	var txt_fmt:TextFormat = new TextFormat();
	txt_fmt.size = 24;
	desc.defaultTextFormat = txt_fmt;
	desc.selectable = false;
	
	pName = new TextField();
	pName.x = 310; pName.y = 150;
	pName.width = 200; pName.height = 40;
	pName.autoSize = TextFieldAutoSize.CENTER; 
	pName.selectable = false;
	
	var format:TextFormat = new TextFormat();
	format.size = 24;
	format.color = 0xFF0000;
	
	pName.defaultTextFormat = format;
	
	
				
				
	for each(var part in names){
		brain[part.id].gotoAndStop(0);
		part.brainBitMap = new BitmapData(brain[part.id].width, brain[part.id].height, true, 0x00000000);
		part.brainBitMap.draw(brain[part.id]); 
		
		ct[part.id+"2"].gotoAndStop(0);
		part.ctBitMap = new BitmapData(ct[part.id+"2"].width,ct[part.id+"2"].height, true, 0x00000000);
		part.ctBitMap.draw(ct[part.id+"2"]); 
		
	}
	
	stage.addChild(desc);
	stage.addChild(pName);
	stage.addChild(brain);
	stage.addChild(ct);
}

var brain;
var ct;
var injuries = new CTScanInjuries();
injuries.x = 510;
injuries.y = 40;
var desc;
var pName;
var names;

toolbox.switchMenuType(2, 1);

var review = function(callback){
	var reviewMouseMove = function(event){
		var updated = false;
		for each(var part in names){
			//hitTestPoint
			
			var p = new Point(mouseX, mouseY);
			if (part.brainBitMap.hitTest(new Point(0,0), 0xFF, brain[part.id].globalToLocal(p)) ||
				part.ctBitMap.hitTest(new Point(0,0), 0xFF, ct[part.id+"2"].globalToLocal(p))){
				brain[part.id].gotoAndStop(2);
				ct[part.id+"2"].gotoAndStop(2);
				desc.text = part.desc;
				pName.text = part.name;
				updated = true;
			}else{
				brain[part.id].gotoAndStop(1);
				ct[part.id+"2"].gotoAndStop(1);
				//desc.text = "";
				//pName.text = "";
			}
			if(!updated){
				desc.text = "";
				pName.text = "";
			}
		}
	};
	stage.addEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
	var firstClickIgnore = true;
	stage.addEventListener(MouseEvent.CLICK, function(){
		if(firstClickIgnore){
			firstClickIgnore = false;
			return;
		}
		stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
		callback();
	});
}

var refresherQuiz = function(callback){
	var num = 0;
	var lastnum = 0;
	stage.addEventListener(MouseEvent.CLICK, function(){
		if(num === names.length){
			callback();
			stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
			return;
		}
		if(num>=0){
			
			brain[names[lastnum].id].gotoAndStop(0);
			ct[names[lastnum].id+"2"].gotoAndStop(0);
			
			brain[names[num].id].gotoAndStop(4);
			ct[names[num].id+"2"].gotoAndStop(4);
			desc.text = names[num].desc;
			pName.text = names[num].name;
		}
		lastnum = num;
		num++;
		
	});
};

var resetBrains = function(){
	for each(var part in names){
		brain[part.id].gotoAndStop(1);
		ct[part.id+"2"].gotoAndStop(1);
		pName.text = "";
		desc.text = "";
	}
};

var termExplanation = function(callback){
	var ctExplained = addImage("CTExplainGraphic", 410, 90);
	ctExplained.width = 250;
	ctExplained.height = 200;
	stage.addChild(ctExplained);
	doctorDialogCTScanExplained(function(){
		stage.removeChild(ctExplained);
		var sliceExplained = addImage("sliceExplanation", 390, 90);
		stage.addChild(sliceExplained);
		sliceExplained.width = 200;
		sliceExplained.height = 200;
		var scanLoc = new CTScanLocation();
		scanLoc.x = 580;
		scanLoc.y = 40;
		stage.addChild(scanLoc);
		scanLoc.gotoAndStop(1);
		doctorDialogSlicesExplained(function(){
			stage.removeChild(sliceExplained);
			stage.removeChild(scanLoc);
			stage.addChild(injuries);
			injuries.gotoAndStop(1);
			
			//TODO: take this part and integrate it with other part that's similar
			injuries.left.stop();
			injuries.right.stop();
			var leftBitmap = new BitmapData(injuries.left.width, injuries.left.height, true, 0x00000000);
			leftBitmap.draw(injuries.left); 
			
			var rightBitmap = new BitmapData(injuries.right.width, injuries.right.height, true, 0x00000000);
			rightBitmap.draw(injuries.right); 
		
			doctorDialogSidesExplained(function(){
				
				var reviewMouseMove = function(event){
					var p = new Point(mouseX, mouseY);
					if(leftBitmap.hitTest(new Point(0,0), 0xFF, injuries.left.globalToLocal(p))){
						injuries.left.gotoAndStop(2);
					}else{
						injuries.left.gotoAndStop(1);
					}
					if(rightBitmap.hitTest(new Point(0,0), 0xFF, injuries.right.globalToLocal(p))){
						injuries.right.gotoAndStop(2);
					}else{
						injuries.right.gotoAndStop(1);
					}
					//stage.removeChild(injuries);
					//callback();
	
					
				};
				
				stage.addEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
				stage.addEventListener(MouseEvent.CLICK, function(){
					var callee = arguments.callee;
					var flashDelay = function(obj, msg, time){
						delayTimer = timer(time, function(){
							delayTimer = null;
							if(obj){
								obj.gotoAndStop(1);
							}
							if(msg){
								msg.remove();
							}
						});
					}
					var p = new Point(mouseX, mouseY);
					if(rightBitmap.hitTest(new Point(0,0), 0xFF, injuries.right.globalToLocal(p))){
						injuries.right.gotoAndStop(3);
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
						var msg = doctorDialogSidesWrong(function(){
						 	stage.addEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
						 });
						flashDelay(injuries.right, msg, 2000);
					}
					if(leftBitmap.hitTest(new Point(0,0), 0xFF, injuries.left.globalToLocal(p))){
						injuries.left.gotoAndStop(4);
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
						var msg = doctorDialogSidesCorrect(function(){
							stage.removeEventListener(MouseEvent.CLICK, callee);
							stage.removeChild(injuries);
							callback();
						});
						flashDelay(injuries.right, msg, 2000);
					}
					
									   
				});
				
				
			
			});
		});
	});
};
var takeTest = function(callback){
	/*for each(var part in names){
		brain[part.id].x = -800;
		createTween(ct[part.id+"2"], "x", None.easeInOut, ct[part.id+"2"].x-250);
	}*/
	
	names = shuffle(names);
	
	var myTween = createTween(brain, "alpha", None.easeInOut, 0, -1, 20, function(){
		//just so it doesn't get in the way
		brain.x = -800;
		myTween = createTween(ct, "x", None.easeInOut, ct.x-250, -1, 50, function(){
			myTween = null;  
		});
		pName.x += 200;
	});
	
	
	var reviewMouseMove = function(event){
		var hit = false;
		for each(var part in names){
			//hitTestPoint
			if(brain[part.id].currentFrame !== 3 && brain[part.id].currentFrame !== 4){
				var p = new Point(mouseX, mouseY);
				if (!hit&&(part.brainBitMap.hitTest(new Point(0,0), 0xFF, brain[part.id].globalToLocal(p)) ||
					part.ctBitMap.hitTest(new Point(0,0), 0xFF, ct[part.id+"2"].globalToLocal(p)))){
					brain[part.id].gotoAndStop(2);
					ct[part.id+"2"].gotoAndStop(2);
					hit = true;
				}else{
					brain[part.id].gotoAndStop(1);
					ct[part.id+"2"].gotoAndStop(1);
				}
			}
		}
	};
	stage.addEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
	desc.text = "Identify the "+names[0].name;
	var firstClickIgnore = true;
	var num = 0;
	var lostTime = false;
	var delayTimer = null;
	var flashDelay = function(id, msg, time){
		delayTimer = timer(time, function(){
			delayTimer = null;
			brain[id].gotoAndStop(1);
			ct[id+"2"].gotoAndStop(1);
			pName.text = "";
			if(msg){
				msg.remove();
			}
			if(num<names.length){
				desc.text = "Identify the "+names[num].name;
			}
		});
	
	}
	
	stage.addEventListener(MouseEvent.CLICK, function(){
		if(firstClickIgnore){
			firstClickIgnore = false;
			return;
		}
		if(myTween !== null){
			myTween.fforward();
			return;
		}
		if(delayTimer !== null){
			delayTimer.stop();
			delayTimer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			delayTimer = null;
			return;
		}
		if(num === names.length){
			stage.removeEventListener(MouseEvent.CLICK, arguments.callee);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, reviewMouseMove);
			callback();
			return;
		}
		if(num>=0){
			 var hit = false;
			 for each(var part in names){
				//hitTestPoint
				var p = new Point(mouseX, mouseY);
				trace("about to check", part);
				if ((part.brainBitMap.hitTest(new Point(0,0), 0xFF, brain[part.id].globalToLocal(p)) ||
					part.ctBitMap.hitTest(new Point(0,0), 0xFF, ct[part.id+"2"].globalToLocal(p)))){
					var msg = null;
					var msgTime = 2000;
					if(names[num].id===part.id){
						brain[part.id].gotoAndStop(4);
						ct[part.id+"2"].gotoAndStop(4);
						desc.text = part.desc;
						pName.text = part.name;
						lostTime = false;
						msgTime = 10000;
						num++;
					}else{
						brain[part.id].gotoAndStop(3);
						ct[part.id+"2"].gotoAndStop(3);
						if(!lostTime){
							clock.reduceAngle(4);
						};
						lostTime = true;
						msg = new Message(stage, 50, 60, "Try matching that once again…", false, "doctorFace");
					}
					flashDelay(part.id, msg, msgTime);
					break;
				}
			}
			//brain[names[lastnum].id].gotoAndStop(0);
			//ct[names[lastnum].id+"2"].gotoAndStop(0);
			
			//brain[names[num].id].gotoAndStop(4);
			//ct[names[num].id+"2"].gotoAndStop(4);
			//desc.text = names[num].desc;
			//pName.text = names[num].name;
		}
		

	});
};

var cleanup = function(){
	stage.removeChild(desc);
	stage.removeChild(pName);
	stage.removeChild(brain);
	stage.removeChild(ct);
}
switch(timeline){
	case 53:
		var testActions = function(){
			doctorDialogTest(function(){
				resetBrains();
				takeTest(function(){
					cleanup();
					doctorDialogFinished(function(){
						//beginning injury section
						var openHead = addImage('openheadwoundillustration', 350, 170);
						openHead.width = 150;
						openHead.height = 150;
						stage.addChild(injuries);
						injuries.gotoAndStop(5);
						doctorDialogOpenInjury(function(){
							stage.removeChild(injuries);
							stage.removeChild(openHead);
							injuries.gotoAndStop(2);
							doctorDialogHematoma(function(){
								var epIlus = addImage('epiduralIllustration', 400, 60);
								var epScan = addImage('epiduralCTscan', 560, 60);
								doctorDialogEpiduralInjury(function(){
									stage.removeChild(epIlus);
									stage.removeChild(epScan);
									var subIlus = addImage('subduralIllustration', 400, 60);
									var subScan = addImage('subduralScan', 560, 60);
									doctorDialogSubduralInjury(function(){
										stage.removeChild(subIlus);
										stage.removeChild(subScan);
										doctorDialogGoToScan(function(){
											gotoAndStop("Scene_CTScan");
										});
									});
								});
							});
						});
					});
				}); 
			});
		};
		
		var pbox;
		doctorDialogIntro(function(){
			termExplanation(function(){
				doctorDialogAdvanceOption(function(){
					pbox = createPopupBox();
					pbox.scanButton.addEventListener(MouseEvent.CLICK, function(){
						 pbox.scanButton.removeEventListener(MouseEvent.CLICK, arguments.callee);
						 loadImageAnimation(pbox, function(){
							displayQuiz();
							doctorDialog2(function(){
								refresherQuiz(function(){
									
									toolbox.switchMenuType(2, 8);
									
									var msg = doctorDialogReviewQuestion();
									
									var removeListeners = function(){
										if(msg){
											msg.advance();
										}
										toolbox.menuBox.questions.yes.addEventListener(MouseEvent.CLICK, yesFun);
										toolbox.menuBox.questions.no.addEventListener(MouseEvent.CLICK, noFun);
										toolbox.switchMenuType(2, 1);
									}
									
									var yesFun = function(){
										removeListeners();
										doctorDialogReview(function(){
											review(function(){
												testActions();   
											});  
									   });   
									}
									
									var noFun = function(){
										removeListeners();
										testActions();  
									}
									
									
									toolbox.menuBox.questions.yes.addEventListener(MouseEvent.CLICK, yesFun);
									toolbox.menuBox.questions.no.addEventListener(MouseEvent.CLICK, noFun);
			
									
								});  
							});
						}); 
					});
				});
			});
		});
		
		//var messages = new Array("Click to start the quiz"); 
		//displayMessages(messages, 550, 320, function(){
		//	gotoAndStop("Scene_CTQuiz");
		//});
		
		break;
	//case 9:
		//timer(3000, function(){
		//	fadeOut();
		//}, 1);
		
}
timeline++;
//trace(timeline);