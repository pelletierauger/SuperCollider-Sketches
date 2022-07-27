s.boot;

//create a one second buffer
b = Buffer.alloc(s, s.sampleRate);
p = "/Users/guillaumepelletier/Desktop/sons/slide-guitar-mono.aiff"
// design a fun source
(
p = Platform.resourceDir +/+ "sounds/a11wlk01.wav";
d = Buffer.read(s, p);
)

// play it
x = d.play(true, 0.1)

// add a basic delay after, no feedback, 6dB lower
(
y = {arg gain = 0.5, dur = 1, feedback = 0, interp = 0;
    var delout, index;
    index = Phasor.ar(0, dur.reciprocal, 0, b.numFrames);
    delout = BufRd.ar(1,b.bufnum,index,0,1);
    IBufWr.ar(In.ar(0,1) * gain, b.bufnum, index, interp, feedback);
    [0, delout]}.play(addAction:'addToTail');
)

// add basic feedback
y.set(\feedback, 0.5)

// change the duration (notice you don't hear the spike in pitch being looped)
y.set(\dur, 0.5)
y.set(\dur, 2)
y.set(\dur, 1)

// kill the input gain and enjoy the tail
y.set(\gain, 0)

// set the feedback to unity
y.set(\feedback, 1)

// send sparingly to what is now a dirty looper
y.set(\gain, 0.75)
y.set(\gain, 0)

// change the length/pitch/speed
y.set(\dur, 0.5)
y.set(\dur, 2)
y.set(\dur, 1.5)

// a little overdub at another speed maybe
y.set(\gain, 0.1)
y.set(\gain, 0)

//  kill the source, set the feedback a little less than unity, enjoy the decay
x.free
y.set(\feedback, 0.8)

// free the delay and both buffers
y.free; b.free; d.free;




y.free; b.zero;

// this works better using IBufWr
// start the sound source
x = d.play(true, 0.1);

// start the delay
(
y = {
    arg gain = 1, dur = 1, feedback = 0.7, interp = 1, freq=2000, lag = 0;
    var delout, index;
    index = Phasor.ar(0, Ramp.kr(dur.reciprocal,lag), 0, b.numFrames);
    delout = BufRd.ar(1, b.bufnum, index,0,1);
    IBufWr.ar(BPF.ar((In.ar(0) * gain) + (delout * feedback),freq,1),b.bufnum,index,interp);
    [0,delout];
}.play(addAction:'addToTail')
)

// much better!
y.set(\dur, 0.91111)

// and more fun - set a 400 ms filtered looper
y.set(\gain, 0, \feedback, 1, \dur, 0.4);

// send some stuff in, then cut the source
y.set(\gain, 1);
y.set(\gain, 0);

// fun but abrupt
y.set(\dur, 0.8)

// with smoothing
y.set(\gain, 1, \lag, 0.4, \dur, 0.05, \feedback, 1);

// cool stop!
(
y.set(\feedback, 0.9, \lag, 2, \dur, 1);
x.free;
)

//clean up
y.free; b.free; d.free;