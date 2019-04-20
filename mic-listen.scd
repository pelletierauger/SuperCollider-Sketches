s.boot;
s.quit;

ServerOptions.outDevices;

ServerOptions.inDevices;

(
~mic = {
	var sig, lfo;
	lfo = SinOsc.ar(15, mul: 0.5, add: 1);
	sig = In.ar(2!2);
	sig = sig * 25;
	sig = FreeVerb.ar(sig, mix: 0.33, room: 0.9, damp: 0.15);
	sig = sig * lfo;
    SendReply.kr(Impulse.kr(10), '/oceanAmp', sig, 1);
	Out.ar(0, sig);
}.play;
)

~mic.free;
s.freeAll;

(
~listen = OSCdef(\listener, {|msg|
        var data = msg[3..];
    // var data = msg;
    data.postln;
    // ~toOSC.sendMsg("/oceanAmp", data[0], data[1]);
}, '/oceanAmp');
)
~listen.free;