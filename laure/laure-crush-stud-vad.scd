(
SynthDef(\crushedNoHPFSpread, {
    arg out = 0, amp = 1, pan = 0, atk = 0.001, dec = 0.01, sus = 1,
    rel = 0.5, susTime = 0.5, pitch = 12, timbre = 1, color = 0.8, model = 37,
    resamp = 2, decim = 32, bits = 2, ws = 0, lpfFreq = 1700;
    var env = EnvGen.kr(Env([0, 1, sus, 0], [atk, dec, susTime, rel]), doneAction: 2);
    var sig = MiBraids.ar(
        pitch: pitch + [0, 0.05],
        timbre: timbre,
        color: color,
        model: model,
        resamp: resamp,
        decim: decim,
        bits: bits,
        ws: ws
    );
    sig = VadimFilter.ar(sig, lpfFreq + 1000, 0.25, 5) * env * amp;
    // sig = HPF.ar(sig, 200);
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
)

(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, Pseq([\crushedNoHPFSpread], inf),
    \dur, Pseq([1, 1, 1, 3] / 3 * 4, inf) * 2,
    \pitch, 12 + Pseq(0!3 ++ (-6!1) * 1, inf),
    \color, Pseq([0.1, 0.1, 0.1, 0.12] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq(1!3 ++ (2!1) / 1, inf),
    \rel, 0.001,
    \amp, Pseq(1!3 ++ (0.75!1) * 1, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
)


(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, Pseq([\crushedNoHPFSpread], inf),
    \dur, Pseq([1, 1, 1, 3] / 3 * 4, inf),
    \pitch, 12 + Pseq(0!3 ++ (0!1) * 1, inf),
    \color, Pseq([0.1, 0.1, 0.1, 0.1] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq(1!3 ++ (2!1) / 1, inf),
    \rel, 0.001,
    \amp, Pseq(1!3 ++ (1!1) * 1, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
)


(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, Pseq([\crushedNoHPFSpread], inf),
    \dur, Pseq([Rest(1), 1, 1, 1, 2] / 3 * 4, inf),
    \pitch, 50 - 12 + Pseq(-5!3 ++ (-12!1) ++ (-5!1) * 1, inf),
    \model, 0,
    \color, Pseq([0.1, 0.1, 0.1, 0.12, 0.1] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq(1!3 ++ (2!1) ++ (2!1) * 0.5, inf),
    \rel, 0.001,
    \amp, Pseq(1!3 ++ (1!1) ++ (1!1) * 1, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
)


0.375.reciprocal
1/3/2

6 / 3