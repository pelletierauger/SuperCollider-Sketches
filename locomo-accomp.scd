(
~input.free;
~input = {
    var in = LocalIn.ar(2);
    var t = Impulse.kr(2);
    var d = Demand.kr(t, 0, Dseq([0, -2, -5, -2].stutter(2), inf) + Dseq([0, 0].stutter(8), inf));
    var env = EnvGen.kr(Env([0,1,0], [0.05, 0.25], [16, -16]), gate: t);
    var sig = MiBraids.ar(pitch: ~toMidi.("A5") + d, timbre: 0.125, color: 0.15, model: 14);
    var filteredSig = ~v.(sig, 3000 * env + 400) + in;
    var filteredDelayedSig = DelayN.ar(filteredSig * 0.999, 1, 0.05 * [1, 1.01]);
    filteredDelayedSig = ~v.(filteredDelayedSig, 3500, 0);
    LocalOut.ar(filteredDelayedSig);
    // sig = sig + in;
    // sig = sig + (DelayN.ar(sig, 1, 0.05) * 0.7);
    // sig = sig + (DelayN.ar(sig, 1, 0.1) * 0.3);
    // sig = sig + CombC.ar(sig, 1, 0.05, 2);
    // sig = ~v.(sig, 3000 * ~lfo.(6) + 400);
    Out.ar(0, filteredSig * 0.1);
}.play;
)


(
~input.free;
~input = {
    var in = LocalIn.ar(2);
    var t = Impulse.kr(2);
    var d = Demand.kr(t, 0, Dseq([0, 3, 5, 3].stutter(2), inf) + Dseq([0, 0].stutter(8), inf));
    var env = EnvGen.kr(Env([0,1,0], [0.05, 0.25], [16, -16]), gate: t);
    var sig = MiBraids.ar(pitch: ~toMidi.("A5") + d, timbre: 0.125, color: 0.15, model: 14);
    var filteredSig = ~v.(sig, 3000 * env + 400) + in;
    var filteredDelayedSig = DelayN.ar(filteredSig * 0.999, 1, 0.05 * [1, 1.01]);
    filteredDelayedSig = ~v.(filteredDelayedSig, 3500, 0);
    LocalOut.ar(filteredDelayedSig);
    // sig = sig + in;
    // sig = sig + (DelayN.ar(sig, 1, 0.05) * 0.7);
    // sig = sig + (DelayN.ar(sig, 1, 0.1) * 0.3);
    // sig = sig + CombC.ar(sig, 1, 0.05, 2);
    // sig = ~v.(sig, 3000 * ~lfo.(6) + 400);
    Out.ar(0, filteredSig * 0.1);
}.play;
)




(
~input.free;
~input = {
    var in = LocalIn.ar(2);
    var t = Impulse.kr(2);
    var d = Demand.kr(t, 0, Dseq([0, -2, -5, -2].stutter(2), inf) + Dseq([0, 0].stutter(8), inf));
    var env = EnvGen.kr(Env([0,1,0], [0.05, 0.25], [16, -16]), gate: t);
    var sig = MiBraids.ar(
        pitch: ~toMidi.("A5") + d, timbre: 0.125, color: 0.15, model: 13);
    var filteredSig = ~v.(sig, 3000 * env + 400) + in;
    var filteredDelayedSig = DelayN.ar(filteredSig * 0.999, 1, 0.05 * [1, 1.01]);
    filteredDelayedSig = ~v.(filteredDelayedSig, 3500, 0);
    LocalOut.ar(filteredDelayedSig);
    // sig = sig + in;
    // sig = sig + (DelayN.ar(sig, 1, 0.05) * 0.7);
    // sig = sig + (DelayN.ar(sig, 1, 0.1) * 0.3);
    // sig = sig + CombC.ar(sig, 1, 0.05, 2);
    // sig = ~v.(sig, 3000 * ~lfo.(6) + 400);
    Out.ar(0, filteredSig * 0.1);
}.play;
)




(

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [1, 0]+0,
            timbre: 0.25,
            color: [0.95, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 12,
            bits: [4, 3],
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 3700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig = sig!2 * 1 * 2;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    }.play(fadeTime: 0.01).register;

)



(

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [1, 0]+0,
            timbre: 0.25,
            color: [0.95, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 2,
            bits: [4, 3]- 2,
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 3700 + SinOsc.kr(0.1).range(0, 1000), 0, 5);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig = sig!2 * 8 * 2;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    }.play(fadeTime: 0.01).register;

)


(

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: [1, 0]+0,
            timbre: 0.25,
            color: [0.95, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 2,
            bits: [4, 3]- 2,
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 3700 + SinOsc.kr(0.1).range(0, 1000), 0, 3);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig = sig!2 * 4 * 2;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    }.play(fadeTime: 0.01).register;

)



(

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo / 12).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
        pitch: [1, 0]+(~lfo.(0.1)*8*0),
            timbre: 0.75,
            color: [0.95, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 2,
            bits: [4, 3] - 2,
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 3700 + SinOsc.kr(0.1).range(0, 1000), 0, 3);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig = sig!2 * 2 * 2;
    // sig = [sig, DelayC.ar(sig, 0.5, 0.02)];
    }.play(fadeTime: 0.01).register;

)