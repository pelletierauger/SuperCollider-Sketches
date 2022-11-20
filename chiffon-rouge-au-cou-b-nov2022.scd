~t = TempoClock.new(1.2).permanent_(true);

(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0), {

    if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise2 = {
        | trigGate = 1 |
        var sig, env, delrd, r, n;
        // trig = Impulse.kr(1 * 1);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~t.tempo * 0.125).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 10,
            timbre: 0.125,
            color: [0.8, 0.81] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0
        );

        sig = VadimFilter.ar(sig, 700 + SinOsc.kr(0.1).range(0, 2000), 0, 5) * 2;
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig * 1 * 1;
    }.play(fadeTime: 0.01).register;
});
)


s.record;
s.stopRecording;


// ---------------------------------------------------------------
// La note lourde qui fait naître la nouvelle harmonie (phrygien).
// ---------------------------------------------------------------

(
~t.sched(~t.timeToNextBeat(quant: 4) + (~t.beatDur * 0), {

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var sig, env, delrd, r, n, trig;
        trig = Impulse.kr(~t.tempo * 0.25);
        // block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        // timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        // note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~t.tempo * 0.125).reciprocal;
        // env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        env = EnvGen.kr(Env([0, 1, 0], [0.1, 4], ['lin', 'lin']), trig);
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 20,
            timbre: 0.5,
            color: [0.8, 0.81] - 0.1,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0
        ) * Line.kr(0, 1, 0.1);

        sig = VadimFilter.ar(sig, 100 + (env * 1000), 0.125, 1) * 1;
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig * 1 * 1;
    }.play(fadeTime: 0.01).register;
});
)


(
~t.sched(~t.timeToNextBeat(quant: 4), {

    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes0 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~t.tempo * 1) * trigGate;
        var d = Demand.kr(trig, 0, Dseq([0, 5].stutter(4), inf));
        var sig = MiPlaits.ar(31 + 28 + -1 + 4 - 12  + d + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: 0.95,
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        // sig = Decimator.ar(sig, 15000, 12);
        VadimFilter.ar(sig, 5000, 0.25, 5) * 0.8 * 8;
    }.play.register;
});
)

    [~billes2, ~billes0].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});});

(
~t.sched(~t.timeToNextBeat(quant: 4), {

    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes0 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~t.tempo * 1) * trigGate;
        var d = Demand.kr(trig, 0, Dseq([0, -2, -4, -5].stutter(4), inf));
        var sig = MiPlaits.ar(62 - 0 + d + [0, 0.1],
            engine: 0,
            harm: 0.25,
            timbre: 0.5,
            morph: 0.75,
            trigger: trig,
            decay: 0.9,
            lpg_colour: 1,
            mul: 1.25);
        sig = Decimator.ar(sig, 400, 8);
        sig = VAKorg35.ar(sig, 2500, 0.5, 0, 0);
        // sig = VadimFilter.ar(sig, 3000, 0.25, 5) * 0.8 * 2;
        sig = VadimFilter.ar(sig, 3000, 0.25, 1) * 1;
        sig = MiRings.ar(sig,
            pit: 62 - 12 - 12, struct: 0.125, bright: 0.25,
            damp: 0.7, pos: 0.25, model: 0 ) * 0.1;
        sig = VadimFilter.ar(sig, 5000, 0.25, 1) * 2 * 4;
    }.play(fadeTime: 10).register;
});
)



(
~t.sched(~t.timeToNextBeat(quant: 4), {

    [~billes2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes2 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~t.tempo * 1) * trigGate;
        var d = Demand.kr(trig, 0, Dseq([0, -2, -4, -5].stutter(4), inf));
        var sig = MiPlaits.ar(62 - 0 + d,
            engine: 0,
            harm: 0.25,
            timbre: 0.5,
            morph: 0.75,
            trigger: trig,
            decay: 0.9,
            lpg_colour: 1,
            mul: 1.25);
        sig = Decimator.ar(sig, 400, 8);
        sig = VAKorg35.ar(sig, 2500, 0.5, 0, 0);
        // sig = VadimFilter.ar(sig, 3000, 0.25, 5) * 0.8 * 2;
        sig = VadimFilter.ar(sig, 3000, 0.25, 1) * 1;
        sig = MiRings.ar(sig,
            pit: 62 - 12 - 12, struct: 0.125, bright: 0.25,
            damp: 0.7, pos: 0.25, model: 0 ) * 0.1;
        sig = VadimFilter.ar(sig, 2000, 0.25, 5) * 4 * 40!2;
    }.play(fadeTime: 10).register;
});
)

(
~t.sched(~t.timeToNextBeat(quant: 4), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~t.tempo * 2);
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ] + 12 + 12,
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.7] * 1.25,
            lpg_colour: 0.85
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        // sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = VadimFilter.ar(sig, ddd * Amplitude.kr(sig) + 2000, 0.25, 1) * 0.5;
        // sig.unipolar.poll;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 1;
    }.play(fadeTime: 0.01).register;
});
)

(
    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});

)