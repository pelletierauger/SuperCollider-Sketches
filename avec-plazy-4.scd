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
u = 48;
~third = 3;
~fifth = 3;
~sequence = Plazy({
    // var pat;
    u = u + 1;
    if (u > 60, { u = 48 });
    if (u.odd, {~third = 4.midiratio}, {~third = 3.midiratio});
    if (u.odd, {~fifth = -5.midiratio}, {~fifth = 7.midiratio});
    // u.postln;
    // ~third.postln;
    // pat = Pseq(u.postln, 1);
    Pbind(
        \instrument, \bub,
        \freq, Pseq([[u.midicps, u.midicps * ~third, u.midicps * 12.midiratio], u.midicps * ~fifth], 8),
        \dur, Pseq([1 * 0.125, 1 * 0.125 * 0.5 * 2], 4),
        \amp, Pseq([8, 32], 4),
        \lon, Pseq([0.5, 0.125], 4),
        \lfoFreq, 2
    )
});
n = n * 2;
u;
)
q = Pn(~sequence, inf).play;
q.stop;
~third;
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