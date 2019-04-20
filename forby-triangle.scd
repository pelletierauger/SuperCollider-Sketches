(
SynthDef.new(\triangle, {
    arg freq = 220, mod = 0.1, amp = 1, pan = 1;
    var sig, sig1, sig2, lfo, lfo2, env;
    env = XLine.kr(0.5, 0.001, 4, 1, 0, 2);
    lfo = SinOsc.kr(mod);
    lfo2 = SinOsc.kr(ExpRand(20,800), mul: 0.75, add:1);
    env = env * lfo;
    sig1 = LFTri.ar((freq + 1)) * env * amp;
    sig2 = LFTri.ar(freq) * env * amp;
    // sig1 = FreeVerb.ar(sig1, mix: 0.3, room: 0.95, damp: 0.15);
    // sig2 = FreeVerb.ar(sig2, mix: 0.3, room: 0.95, damp: 0.15);
/*    Out.ar(0, sig1);
    Out.ar(1, sig2);*/
    sig = Balance2.ar(sig1, sig2, pan, 1);
	Out.ar(0, sig);
}).add;
)

[1, 2, 3, 4].mirror.postln;

[1, 2, 3] + 4;

(
~tri.stop;
~tri = Pbind(
    \instrument, \triangle,
    // \dur, Prand([0.5, 0.25, 0.125], inf),
    \dur, Prand([4, 2, 1] * 0.125 * 0.25, inf),
    \freq, Pseq([Plazy({
    var x;
        // x = (a[0] + 10).midicps;
        x = (a.choose + 40).midicps * 24.midiratio * [-12, 0].midiratio;
        // if (a[0] == 0, {x = 1 * -4.midiratio}, {x = 1 * -2.midiratio});
        Pseq([x],1);
})], inf),
    \mod, Pwhite(0.1, 4, inf),
    \amp, Pseq([0.15] * 0.5, inf),
    \pan, Pwhite(-0.5, 0.5, inf)
).play(t, quant: 1);
)