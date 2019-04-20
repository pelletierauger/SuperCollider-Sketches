s.boot;
s.plotTree;
s.meter;

(
SynthDef.new(\drone, {
	arg freq=146.8323, amp=0.5, trig=1, lfoFreq = 0.1, lfoAmp = 0.1;
	var sig, env, lfo;
	env= EnvGen.ar(
		Env([0.01,1,0.01],
			[2,4],
			curve: 'exp',
			releaseNode: 1),
		gate: trig,
		doneAction: 2
	);
	// sig = SinOsc.ar(freq)!2;
	sig = PinkNoise.ar(mul: 0.2);
	sig = Ringz.ar(sig, [freq, freq + 1], 15, 0.2) * env;
	sig = sig * env;
	// lfo = SinOsc.kr(lfoFreq, mul: lfoAmp);
	// sig = sig * lfo;
	sig = LPF.ar(sig, freq * 3);
	sig = sig * amp;
	Out.ar(0, sig);
}).add;
)


~dr3.set(\lfoAmp, 1);

~dr.set(\trig, 1);
~dr.set(\trig, 0);

// 73.42, D2
// 82.41, E2
~fundamental = 146.8323; // D3
~fundamental = 164.81; // E3

~dr = Synth.new(\drone, [\freq, ~fundamental * 1, \amp, 0.025]);
~dr.set(\trig, 0);
~dr2 = Synth.new(\drone, [\freq, ~fundamental * 2, \amp, 0.0245]);
~dr2.set(\trig, 0);
~dr3 = Synth.new(\drone, [\freq, ~fundamental * 3, \amp, 0.025]);
~dr3.set(\trig, 0);
~dr4 = Synth.new(\drone, [\freq, ~fundamental * 4, \amp, 0.005]);
~dr4.set(\trig, 0);
~dr5 = Synth.new(\drone, [\freq, ~fundamental * 5, \amp, 0.005]);
~dr5.set(\trig, 0);
~dr6 = Synth.new(\drone, [\freq, ~fundamental * 6, \amp, 0.0025]);
~dr6.set(\trig, 0);
~dr7 = Synth.new(\drone, [\freq, ~fundamental * 7, \amp, 0.0125]);
~dr7.set(\trig, 0);
~dr8 = Synth.new(\drone, [\freq, ~fundamental * 8, \amp, 0.00625]);
~dr8.set(\trig, 0);

~dr5b = Synth.new(\drone, [\freq, ~fundamental * 5, \amp, 0.05]);
~dr5b.set(\freq, ~fundamental * 4);
~dr5b.set(\trig, 0);
~dr5b.set(\freq, ~fundamental * 5);

[~dr, ~dr2, ~dr3, ~dr4, ~dr5, ~dr6, ~dr7].do({arg item, i; [i, item].set(\trig, 0);});
