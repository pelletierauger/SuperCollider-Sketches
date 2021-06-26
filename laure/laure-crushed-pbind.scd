(
SynthDef(\crushedNo, {
    arg out = 0, amp = 1, pan = 0, atk = 0.001, dec = 0.01, sus = 1,
    rel = 0.5, susTime = 0.5, pitch = 12, timbre = 1, color = 0.8, model = 37,
    resamp = 2, decim = 32, bits = 2, ws = 0, lpfFreq = 1700;
    var env = EnvGen.kr(Env([0, 1, sus, 0], [atk, dec, susTime, rel]), doneAction: 2);
    var sig = MiBraids.ar(
        pitch: pitch!2,
        timbre: timbre,
        color: color,
        model: model,
        resamp: resamp,
        decim: decim,
        bits: bits,
        ws: ws
    );
    sig = LPF.ar(sig, lpfFreq) * env * amp;
    // sig = HPF.ar(sig, 1000);
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\crushedNoHPF, {
    arg out = 0, amp = 1, pan = 0, atk = 0.001, dec = 0.01, sus = 1,
    rel = 0.5, susTime = 0.5, pitch = 12, timbre = 1, color = 0.8, model = 37,
    resamp = 2, decim = 32, bits = 2, ws = 0, lpfFreq = 1700;
    var env = EnvGen.kr(Env([0, 1, sus, 0], [atk, dec, susTime, rel]), doneAction: 2);
    var sig = MiBraids.ar(
        pitch: pitch!2,
        timbre: timbre,
        color: color,
        model: model,
        resamp: resamp,
        decim: decim,
        bits: bits,
        ws: ws
    );
    sig = LPF.ar(sig, lpfFreq) * env * amp;
    sig = HPF.ar(sig, 200);
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig);
}).add;
)

// ------------------------------------------------------------
// Version la plus intéressante
// ------------------------------------------------------------

(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, Pseq([\crushedNoHPF, \crushedNoHPF], inf),
    \dur, Pseq([0.75, 1.25] * 4, inf),
    \pitch, 12,
    \color, Pseq([0.8, 0.95] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq([1.5, 0.25] / 1, inf),
    \rel, 0.001,
    \amp, Pseq([1, 3] * 4, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
)


(
~guitareW.stop;
~guitareW = Pbind(
    \instrument, Pseq([\crushedNoHPF, \crushedNoHPF], inf),
    \dur, Pseq([0.75, 1.25] * 4, inf),
    \pitch, 12 + 12 + 12,
    \model, 26,
    \color, Pseq([0.8, 0.95] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq([1.5, 0.25] / 1, inf),
    \rel, 0.001,
    \amp, Pseq([1, 3] * 1, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
)


(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, Pseq([\crushedNoHPF, \crushedNoHPF], inf),
    \dur, Pseq([0.75, 1.25] * 4, inf),
    \pitch, 12,
    \color, Pseq([0.8, 0.95] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq([1.5, 0.25] / 1, inf),
    \rel, 0.001,
    \amp, Pseq([1, 3] * 6, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
~guitareW.stop;
~guitareW = Pbind(
    \instrument, Pseq([\crushedNoHPF, \crushedNoHPF], inf),
    \dur, Pseq([0.75, 1.25] * 4, inf),
    \pitch, 12 + 12 + 12,
    \model, 26,
    \color, Pseq([0.8, 0.95] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq([1.5, 0.25] / 1, inf),
    \rel, 0.001,
    \amp, Pseq([1, 3] * 0.5, inf),
    \out, 0
).play(~nT, quant: [4, -0.4]);
)

// ------------------------------------------------------------
// Version précédente
// ------------------------------------------------------------

(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \crushedNo,
    \dur, Pseq([0.75, 1.25] * 4, inf),
    \pitch, 12,
    \color, Pseq([0.8, 0.95] / 2, inf),
    \susTime, Pseq([1, 3] / 2, inf),
    \rel, 0.001,
    \amp, Pseq([1, 2] * 5, inf),
    \out, 0
).play(~nT, quant: [4, -0.3]);
)


(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

~crushedNoise = {
    | trigGate = 1 |
    var trig, sig, env, block, decay, timbre, delrd, note, r, n;
    trig = Impulse.kr(~nT.tempo * 1.5 * 1);
    block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
    timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
    note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
    r = 0.01;
    n = (~nT.tempo * 1.5 * 0.25).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    // timbre = timbre.lag(0.07);
    // delrd = LocalIn.ar(2);
    sig = MiBraids.ar(
        pitch: 12,
        timbre: 1,
        color: [0.8, 0.95],
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 2,
        ws: 0
    ) * [env, 1 - env];
    sig = LPF.ar(sig, 1700 + SinOsc.ar(0.1).range(0, 7000));
    // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
    // sig = sig + delrd;
    // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
    // sig = LPF.ar(sig, 2700);
    sig!2 * 0.25 * 4 * 4;
}.play(fadeTime: 0.01).register;
)