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
    lfo = SinOsc.kr([lfoFreq, lfoFreq + 0.1]);
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
SynthDef.new(\bub2, {
	arg out, freq = 220, lon = 3, lfoFreq = 6, amp = 1;
	var sig, sig2, lin, lin2, lfo, linUp;
	lin = XLine.kr(1, 0.0001, lon, doneAction: 2);
	linUp = XLine.kr(0.0001, 1, lon * 0.5, doneAction: 0);
	// lin2 = Line.kr(1, 0, lon, don
    lfo = SinOsc.kr([lfoFreq, lfoFreq + 0.1]);
	lin2 = XLine.kr(0.001, 0.1, 0.5, doneAction: 0);
    // freq = freq * max(1, linUp + 0.99);
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
u = 60;
~third = 3;
~fifth = 3;
~sequence = Plazy({
    // var pat;
    // u = u + [1].choose;
    if (u.odd, {u = u + 2}, {u = u + 1});
    if (u > 64, { u = 60 });
    if (u.odd, {~third = 4.midiratio}, {~third = 4.midiratio});
    if (u.odd, {~fifth = -5.midiratio}, {~fifth = 7.midiratio});
    u.postln;
    // ~third.postln;
    // pat = Pseq(u.postln, 1);
    Pbind(
        \instrument, \bub,
        \freq, Pseq([[u.midicps, u.midicps * ~third, u.midicps * ~fifth]], 8),
        \lfoFreq, Pseq([0.1], 8),
        \dur, Pseq([1], 4),
        \amp, Pseq([8, 32], 4),
        \lon, Pseq([5], 4)
        // \lfoFreq, 2
    )
});
// n = n * 2;
// u;
)

~third;

(
u = 63;
q.stop;
~high.stop;
~high2.stop;
q = Pn(~sequence, inf).play(quant: 1);

~highNotes = Plazy({
    Pbind(
        \instrument, \bub,
        \freq, Pseq([
            Pseq([u.midicps * 12.midiratio], 4),
            Pseq([u.midicps * ~third * 0.midiratio], 2),
            Pseq([u.midicps * ~fifth * 0.midiratio], 2)
        ], 1),
        \lfoFreq, Pseq([6], 8),
        \dur, Pseq([1/8], 8),
        \amp, Pseq([8 * 1.5, 32 * 1.5], 8),
        \lon, Pseq([0.25], 8)
        // \lfoFreq, 2
    )
});
~high = Pn(~highNotes, inf).play(quant: 1);
/*~highNotes2 = Plazy({
    Pbind(
        \instrument, \bub,
        \freq, Pseq([Rest(1),
            Pseq([u.midicps * ~fifth * 12.midiratio], 3),
            Pseq([u.midicps * ~third * -12.midiratio], 2),
            Pseq([u.midicps * 0.midiratio], 2)
        ], 1),
        \lfoFreq, Pseq([2], 8),
        \dur, Pseq([1/8], 8),
        \amp, Pseq([8 * 1.5, 32 * 1.5], 8),
        \lon, Pseq([2], 8)
        // \lfoFreq, 2
    )
});
~high2 = Pn(~highNotes2, inf).play(quant: 1);*/
)
(
q.stop;
~high.stop;
)


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

s.record;
s.stopRecording;