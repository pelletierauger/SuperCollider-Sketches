// From : "https://gist.github.com/umbrellaprocess/973d2aa16e95bf329ee2"

MIDIClient.init;
MIDIIn.connect;
s.boot;
s.quit;

(
SynthDef("umbSinewave",{
	arg freq=440, gate=1, amp=10, pan=0;
	var x;
	x = SinOsc.ar(freq, 0, amp);
	x = EnvGen.kr(Env.adsr(0.01,0.3,0.5,1,0.6,-4),gate,doneAction: 2) * x;
	Out.ar(0, Pan2.ar(x,pan));
}).add;
)

(
var keys;
keys = Array.newClear(128);

~noteOnFunc = {arg src, chan, num, vel;
	var node;
	node = keys.at(num);
	if (node.notNil, {
		node.release;
		keys.put(num, nil);
	});
	node = Synth.tail(nil, "umbSinewave", [\freq, num.midicps, \amp, vel/127]);
	keys.put(num, node);
	[chan,num,vel/127].postln;
};
MIDIIn.addFuncTo(\noteOn, ~noteOnFunc);

~noteOffFunc = {arg src, chan, num, vel;
	var node;
	node = keys.at(num);
	if (node.notNil, {
		node.release;
		keys.put(num, nil);
	});
};
MIDIIn.addFuncTo(\noteOff, ~noteOffFunc);

)

// cleanup
(
MIDIIn.removeFuncFrom(\noteOn, ~noteOnFunc);
MIDIIn.removeFuncFrom(\noteOff, ~noteOffFunc);
MIDIIn.disconnectAll;
)