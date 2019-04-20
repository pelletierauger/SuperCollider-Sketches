(
SynthDef.new(\bubble, {
	arg freq = 220, lon = 3, lfoFreq = 6;
	var sig, sig2, lin, lin2, lfo;
	lin = XLine.kr(1, 0.0001, lon, doneAction: 2);
	// lin2 = Line.kr(1, 0, lon, don
	lfo = SinOsc.kr(lfoFreq);
	lin2 = XLine.kr(0.001, 0.1, 0.1, doneAction: 0);
	freq = freq * max(1, lin + 0.99);
	sig = LFTri.ar([freq/2, freq/2+2]) * (12 / lon);
	sig2 = SinOsc.ar([freq*1.01, freq*1.01+2]) * (12 / lon);
	sig = (sig /2) + (sig2/2);
	sig = sig * lin * lin2 * lfo;
	Out.ar(0, sig);
}).add;
)

x = Synth.new(\bubble, [\freq, 520]);

(
p.stop;
p = Pbind(
	\instrument, \bubble,
	\dur, Pseq([0.5, 0.125, 0.0125], inf),
	\freq, Pwhite(60, 900, inf).round(30),
	\lon, Pwhite(0.15, 12, inf),
	\lfoFreq, Pwhite(0.15, 6, inf)
	// \spos, Pwhite(1047552 - 850000 + a, 1047552 - 840000 + a, inf).round,
	// \rate, Pseq([1 * -2.midiratio, 1 * 5.midiratio, 1 * -7.midiratio], inf),
	// \pan, Pwhite(-1, 1, inf)
).play;
)

0.0125!5;

max(2,3);

s.boot;