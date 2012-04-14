   import flash.events.Event;
   import flash.events.SampleDataEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;    

      const BYTES_PER_CALLBACK:int = 4096; // Should be >= 2048 && < = 8192

      var _playbackSpeed:Number = 1;

      function playbackSpeed(value:Number):void
      {
         if (value < 0) {
            throw new Error('Playback speed must be positive!');
         }
         _playbackSpeed = value;
      }

      var _mp3:Sound;
      var _dynamicSound:Sound;
      var _channel:SoundChannel;

      var _phase:Number;
      var _numSamples:int;

      function loadAndPlaySound(request:URLRequest):void
      {
         _mp3 = new Sound();
         _mp3.addEventListener(Event.COMPLETE, mp3Complete);
         _mp3.load(request);
      }

      function playLoadedSound(s:Sound):void
      {
         _mp3 = s;
         playSound();
      }
     
      function stopSound():void
      {
         if (_dynamicSound) {
            _dynamicSound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
            _channel.removeEventListener(Event.SOUND_COMPLETE, onSoundFinished);
            _dynamicSound = null;
            _channel = null;
         }
      }

      function mp3Complete(event:Event):void
      {
         playSound();
      }

      function playSound():void
      {
         stopSound();
         _dynamicSound = new Sound();
         _dynamicSound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
         
         _numSamples = int(_mp3.length * 44.1);
         
         _phase = 0;
         _channel = _dynamicSound.play();
         _channel.addEventListener(Event.SOUND_COMPLETE, onSoundFinished);
      }
     
      function onSoundFinished(event:Event):void
      {
         _channel.removeEventListener(Event.SOUND_COMPLETE, onSoundFinished);
         playSound();
       //  _channel.addEventListener(Event.SOUND_COMPLETE, onSoundFinished);
      }

      function onSampleData( event:SampleDataEvent ):void
      {
         var l:Number;
         var r:Number;
         var p:int;
         
         
         var loadedSamples:ByteArray = new ByteArray();
         var startPosition:int = int(_phase);
         _mp3.extract(loadedSamples, BYTES_PER_CALLBACK * _playbackSpeed, startPosition);
         loadedSamples.position = 0;
         
         while (loadedSamples.bytesAvailable > 0) {
           
            p = int(_phase - startPosition) * 8;
           
            if (p < loadedSamples.length - 8 && event.data.length <= BYTES_PER_CALLBACK * 8) {
               
               loadedSamples.position = p;
               
               l = loadedSamples.readFloat();
               r = loadedSamples.readFloat();
           
               event.data.writeFloat(l);
               event.data.writeFloat(r);
               
            } else {
               loadedSamples.position = loadedSamples.length;
            }
           
            _phase += _playbackSpeed;
           
            // loop
            if (_phase >= _numSamples) {
               _phase -= _numSamples;
               break;
            }
         }
	  }