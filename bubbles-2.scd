s.quit;
s.boot;
s.plotTree;

(
~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);
~reverbBus = Bus.audio(s, 2);
~wahwahBus = Bus.audio(s, 2);
)

(
SynthDef.new(\bubble, {
	arg out, freq = 220, lon = 3, lfoFreq = 6, amp = 1;
	var sig, sig2, lin, lin2, lfo, linUp;
	lin = XLine.kr(1, 0.0001, lon, doneAction: 2);
	linUp = XLine.kr(0.0001, 1, lon * 0.25, doneAction: 0);
	// lin2 = Line.kr(1, 0, lon, don
	lfo = SinOsc.kr(lfoFreq);
	lin2 = XLine.kr(0.001, 0.1, 0.5, doneAction: 0);
	freq = freq * max(1, linUp + 0.99);
	sig = LFTri.ar([freq/2, freq/2+2]) * (12 / lon);
	sig2 = SinOsc.ar([freq*1.01, freq*1.01+2]) * (12 / lon);
	sig = (sig /2) + (sig2/2);
	sig = sig * lin * lin2 * lfo;
	sig = sig * amp;
	Out.ar(out, sig);
}).add;
)


(
SynthDef.new(\reverb, {
	arg in, out = 0;
	var sig, del;
	sig = In.ar(in, 2);
	del = CombC.ar(in: sig,
		maxdelaytime: 0.5,
		delaytime: [0.5, 0.51],
		decaytime: 20,
		mul: 1, add: 0);
	sig = sig + (del * 0.25);
	// sig = FreeVerb.ar(sig, 0.5, 0.8, 0.001);
	Out.ar(out, sig);
}).add;
)
y.free;
y = Synth.new(\reverb, [\in, ~reverbBus], ~fxGroup);

x = Synth.new(\bubble, [\freq, 520]);



a = Scale.ionian;
a[0].choose;


(
p.stop;
p = Pbind(
	\instrument, \bubble,
	\out, ~reverbBus,
	\dur, Pseq([5, 0.125, 0.0125], inf),
	\freq, Prand([0, 2, 4, 5, 7, 9, 11], inf).midiratio * 220 * Prand([1, 2, 4], inf),
	// \freq, Pwhite(60, 900, inf).round(30),
	\lon, Pwhite(0.15, 12, inf),
	\amp, 1,
	\lfoFreq, Pwhite(0.15, 6, inf)
	// \spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \rate, Pseq([1 * -2.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	// \pan, Pwhite(-1, 1, inf)
).play;
)

(
q.stop;
q = Pbind(
	\instrument, \bubble,
	\out, ~reverbBus,
	\dur, Pseq([0.5, 0.5, 0.5, 2], inf),
	\freq, Prand([0.5, 1], inf) * 220,
	\amp, 4,
	// \freq, Pwhite(60, 900, inf).round(30),
	\lon, Pwhite(0.5, 1, inf),
	\lfoFreq, Pwhite(0.15, 6, inf)
	// \spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \rate, Pseq([1 * -2.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	// \pan, Pwhite(-1, 1, inf)
).play;
)

(
r.stop;
r = Pbind(
	\instrument, \bubble,
	\out, ~reverbBus,
	\dur, Pseq([1, 0.125, 0.0125], inf),
	\freq, Prand([0, 2, 4, 5, 7, 9, 11], inf).midiratio * 220 * Prand([2, 4, 8], inf),
	// \freq, Pwhite(60, 900, inf).round(30),
	\lon, Pwhite(0.01, 0.05, inf),
	\amp, 1,
	\lfoFreq, Pwhite(0.15, 6, inf)
	// \spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \rate, Pseq([1 * -2.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	// \pan, Pwhite(-1, 1, inf)
).play;
)

0.0125!5;

max(2,3);

s.boot;