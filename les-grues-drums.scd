(
    f.set(\trigGate, 0, \relGate, 1);
g.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 25);
~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 25);
    if(~crushedLow.isPlaying, {~crushedLow.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    v.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    w.set(\trigGate, 0, \gate, 0, \fadeTime, 3);

)

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    y.set(\trigGate, 0, \gate, 0, \fadeTime, 3);
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo) * trigGate;
        var b = t * Demand.kr(t, 0, Dseq([0, 0, 0, 0, 1, 0], inf));
        var d = Demand.kr(b, 0, Dseq([0.15, 0.15, 0.15, 0.5].rotate(1), inf));
        var d2 = Demand.kr(b, 0, Dseq([500, 1000].stutter(4), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [0.01, 1.5], [0, -8]), b);
        var sig = MiBraids.ar(
            pitch: 20,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * 2!2 * e;
        sig = (Decimator.ar(sig, 1000, 2) * 0.4);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        VadimFilter.ar(sig, 2700, 0.25, 1) * 2 * Line.kr(0, 1, 1);
    }.play(fadeTime: 0);
});
)

//------------------------------------------------------------------------
// Une batterie forte et décidée.
//------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare2 = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo);
    var pat0 = [1, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0];
    var pat1 = [0, 0, 0, 1, 0, 0] ++ [0, 0, 0, 1, 0, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + -12,
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * 0.85,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig + (Decimator.ar(sig, 1000, 6) * 0.14);
        // sig = VadimFilter.ar(sig, 4000, 0, 1);
    sig = sig * 3.6 * 0.25;
}.play(fadeTime: 0.01).register;
});
)


//------------------------------------------------------------------------
// Une douce friture.
//------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 12), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo);
    var pat0 = [1, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0];
    var pat1 = [0, 0, 0, 0, 1, 0] ++ [0, 0, 0, 0, 1, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var grr = Demand.ar(trig, 0, Dseq([0.85, 1.25].stutter(24), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + -12,
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * grr,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * (Decimator.ar(sig, 1000, 6) * 0.4);
        sig = VadimFilter.ar(sig, 4000 - Line.kr(0, 3000, ~nT.beatDur * 48 * 3), 0, 5);
    sig = sig * 3.6 * 0.25;
}.play(fadeTime: 0.01).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 12) - 0.1, {
    f.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
});
~nT.sched(~nT.timeToNextBeat(quant: 12), {
    // f.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
    f =    {
        | trigGate = 1 |
        var envGate = EnvGate.new(fadeTime: 0);
        var trig = Impulse.kr(~nT.tempo / 3) * trigGate;
        var no = Demand.kr(trig, 0, Dseq([0, 1, 0, 1, -2, -3, -4, -5].stutter(2), inf));
        var sig = MiPlaits.ar(31 + 24 + 12 + no,
            engine: 11,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 8);
        sig = sig[0]!2;
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 0.5 * envGate;
        VadimFilter.ar(sig, 100, 0, 5);
        // sig = Decimator.ar(sig, 100, 12);
        // sig = VadimFilter.ar(sig, 2000, 0, 1) * 1!2;
    }.play;
    nil;
});

~nT.sched(~nT.timeToNextBeat(quant: 12), {
    g.set(\trigGate, 0, \gate, 0, \fadeTime, 10);
    g =    {
        | trigGate = 1 |
        var envGate = EnvGate.new;
        var trig = Impulse.kr(~nT.tempo) * trigGate;
        var bl = trig * Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 0, 0], inf));
        var amp = Demand.kr(bl, 0, Dseq([1, 1, 0.1], inf)).lag(0.1);
        var no2 = Demand.kr(bl, 0, Dseq([1, 1, 0.25], inf)).lag(0.1);
        var no = Demand.kr(bl, 0, Dseq([0, 3, 6, 5].stutter(2), inf));
        var sig = MiPlaits.ar(31 + 24 + 2 - 24 + no + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25 * 1,
            trigger: bl,
            decay: 0.1,
            lpg_colour: 0,
            mul: 8);
        sig = [sig[0][0], sig[1][0]] * envGate;
        // sig = VadimFilter.ar(sig, 2000, 0, 1);
        // VadimFilter.ar(sig, 500, 0, 5) * 8;
        // sig = Decimator.ar(sig, 1000, 12);
        sig = VadimFilter.ar(sig, 200 + (800), 0, 1) * 1;
    }.play;
    nil;
});
~nT.sched(~nT.timeToNextBeat(quant: 12), {
~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~snare = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo);
    var pat0 = [1, 0, 0, 0, 0, 0] ++ [1, 0, 0, 0, 0, 0];
    var pat1 = [0, 0, 0, 0, 1, 0] ++ [0, 0, 0, 0, 1, 0];
    var pat2 = [1];
    var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
    var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
    var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var grr = Demand.ar(trig, 0, Dseq([0.85, 1.25].stutter(24), inf));
    var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
    var sig = MiPlaits.ar(
        pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + -12,
        engine: 9,
        harm: 0.95,
        timbre: 1,
        morph: 0.45 - [0, 0.2, 0, 0],
        trigger: trig * [block0, block1, block1, block2] * trigGate,
        decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * grr,
        lpg_colour: 0
    );
    var sig2 = [sig[1][1], sig[2][1]] * 1.5;
    sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
    // sig = (sig * 0.75) + HPF.ar(sig, 200);
    // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * (Decimator.ar(sig, 1000, 6) * 0.4);
        sig = VadimFilter.ar(sig, 4000, 0, 5);
    sig = sig * 3.6 * 0.25;
}.play(fadeTime: 0.01).register;
});
)