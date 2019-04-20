s.quit;
s.boot;

x = Array.series(rrand(2, 4), [1, 5].choose, 1);
x;
x.put(x.size.rand, 8+0.1.rand2);

0.1.rand2;

0.1;

8+0.1.rand2;

1.0.rand2;

70.midicps;


(
SynthDef.new(\bub, {
	arg out, freq = 220, lon = 3, lfoFreq = 6, amp = 1;
	var sig, sig2, lin, lin2, lfo, linUp;
	lin = XLine.kr(1, 0.0001, lon, doneAction: 2);
	linUp = XLine.kr(0.0001, 1, lon * 0.5, doneAction: 0);
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



u = 54;
u = 28;
(
u = 68;

~sequence = Plazy({
    // var pat;
    u = u + 3;
    if (u > 100, { u = 68 });
    u.postln;
    // pat = Pseq(u.postln, 1);
    Pbind(
        \instrument, \bub,
        \freq, Pseq([u.midicps, u.midicps * 5.midiratio], 2),
        \dur, Pseq([0.125 * 0.25, 0.125 * 2], 2),
        \amp, Pseq([2, 4], 2),
        \lon, Pseq([1, 0.1], 2),
    )
});

u;
)
q = Pn(~sequence, inf).play;
q.stop;

(
a = Plazy({
    var x, y;
    x = Array.series(rrand(2, 4), [1, 5].choose, 1);
    x.put(x.size.rand, 8+0.1.rand2);
    Pbind(
        \instrument, \help_sinegrain,
        \dur, 0.12,
        \degree, Pseq(x, 2)
    )
});

Pn(a, inf).play;
)