~nT = TempoClock.new(1.39 * 1 * 1.25).permanent_(true);
~nT.tempo;
~cb = Bus.control(s, 2);
Safety(s).disable;
(
SynthDef.new(\tick, {
    arg beat, subd;
    var sig = Impulse.kr(0.01);
    Line.kr(0, 1, 0.1, doneAction: 2);
    Out.kr(~cb, sig * [beat, subd]);
}).add;
)

(
~ticking = {
    ~ticks.stop;
    ~ticks = Pbind(
        \instrument, \tick,
        \dur, 0.25,
        \beat, Pseq([1, 0, 0, 0], inf),
        \subd, Pseq([1, 1, 1, 1], inf)
    ).play(~nT, quant: 4);
};
CmdPeriod.remove(~ticking);
CmdPeriod.add(~ticking);
~ticking.();
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([1, 1].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, a, a];
        var pat2 = (0!16) ++ [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].rotate(8);
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 22 + [0, 0, 0, 0] + 24,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 1],
            timbre: [1, 1, 1, 1],
            morph: 0.85 - [0, 0.1, 0.1, -0.2],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.9, 0.9, 2] * 0.75,
            lpg_colour: [0.75, 0.75, 0.75, 0.5] * 1,
            // fm_mod: -0.95,
            // timb_mod: 1,
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5 * 1)]!2 + sig2;
        // sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        sig = VAKorg35.ar(sig, 2000, 0.125, 0.125, 0);
        sig = ~v.(sig, 4000);
/*        sig = DCompressor.ar(
            input: sig,          sidechainIn: 0,        sidechain: 0,
            ratio: 4,            threshold: -40,        attack: 0.1,
            release: 100.1,      makeup: 0.5,           automakeup: 1
        );*/
        sig * 0.25;
    }.play(fadeTime: 0.01).register;
});
)

// Les toms du verni qui envenime
(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([1, 1].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, a, a];
        var pat2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 22 + [0, 0, 0, 0] + 24,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 1],
            timbre: [1, 1, 1, 1],
            morph: 0.85 - [0, 0.1, 0.1, -0.2],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.9, 0.9, 2] * 0.75,
            lpg_colour: [0.75, 0.75, 0.75, 0.5] * 1,
            // fm_mod: -0.95,
            // timb_mod: 1,
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5 *2)]!2 + sig2;
        // sig2 = (MiWarpsx.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        sig = VAKorg35.ar(sig, 2000, 0.125, 0.125, 0);
        sig = ~v.(sig, 4000);
/*        sig = DCompressor.ar(
            input: sig,          sidechainIn: 0,        sidechain: 0,
            ratio: 4,            threshold: -40,        attack: 0.1,
            release: 100.1,      makeup: 0.5,           automakeup: 1
        );*/
        sig * 0.25;
    }.play(fadeTime: 0.01).register;
});
)





// Les toms en support aux toms qui enveniment.


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms3.isPlaying, {~toms3.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms3 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq((0!16)++(0!16),inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, a, 0, a];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, a, 0];
        var pat2 = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] ++ (0!16);
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 12,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.4],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.2],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.9] * 0.5,
            lpg_colour: [0.75, 0.75, 0.75, 1],
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5 * 0)]!2 + sig2;
        // sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        // sig = sig + (CombC.ar(sig, 1, ~nT.beatDur/16, 4)*0.25);
        // sig = VAKorg35.ar(sig, 4000, 0.125, 0.125, 0);
        // sig = ~v.(sig, 7000);
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 1;
    }.play(fadeTime: 0.01).register;
});
)



// Les noisy off beats

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});
~noLow = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var trig = tr[0] * dd;
    var block = Demand.kr(trig, 0, Dseq([1, 0, 0, 0].wrapExtend(16), inf));
    var notes = Demand.kr(trig, 0,
        Dseq(32 + [0] + 0, inf)
    );
    var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
    var dem2 = Demand.kr(trig * block, 0, Dseq([0.2, 0.2], inf));
    var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
    var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
    var lfo3 = SinOsc.kr(1).range(0, 2000);
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
    var sig = MiBraids.ar(
        pitch: 2,
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 2,
        bits: 3,
        ws: 0.75
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    sig = VadimFilter.ar(sig, 2300, 0, 5) * 4;
    sig = VAKorg35.ar(sig, freq: 5000, res: 0, overdrive: 0.5);
    // sig.reverse * 0.02 * dd.lag(0.1);
    sig.reverse * 0.02 * dd.lag(0.1) * K2A.ar(tr[1]!2 + DelayN.ar(tr[0]!2*4,1,~nT.beatDur * 0.5)).lag(1) * 32 * 4;
}.play(fadeTime: 0.1);
});
)





// Drums tendres mais lourds et lointains. Klaus.

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
n.set(\trigGate, 0, \gate, 0, \fadeTime, 15);
n = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
 //     [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
        [1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0]
        , inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 27 + 24+12,                 engine: 10,
        harm: 0.95,                timbre: 0.25,                 morph: 0,
        trigger: b,                /*level: level.lag(0.05),*/
        fm_mod: 0.5,      timb_mod: 0,                  morph_mod: -0.5,
        decay: 0.35
            ,                lpg_colour: 0.5
   )[0] * dd.lag(0.05);
     sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 2;
    sig = VadimFilter.ar(sig, 50, 0, 5) * 2 * dd.lag(0.05);
}.play(fadeTime: 0);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([1, 1].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, a, a];
        var pat2 = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].rotate(8);
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 22 + [0, 0, 0, -12] + 24,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 1],
            timbre: [1, 1, 1, 1],
            morph: 0.85 - [0, 0.1, 0.1, 0.1],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.9, 0.9, 2] * 0.125,
            lpg_colour: [0.75, 0.75, 0.75, 1] * 1,
            // fm_mod: -0.95,
            // timb_mod: 1,
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5 *1)]!2 + sig2;
        // sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        sig = VAKorg35.ar(sig, 2000, 0.125, 0.125, 0);
        sig = ~v.(sig, 4000);
/*        sig = DCompressor.ar(
            input: sig,          sidechainIn: 0,        sidechain: 0,
            ratio: 4,            threshold: -40,        attack: 0.1,
            release: 100.1,      makeup: 0.5,           automakeup: 1
        );*/
        sig * 1;
    }.play(fadeTime: 0.01).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([1, 1].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, a, a];
        var pat2 = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].rotate(8);
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 22 + [0, 0, 0, 0] + 24 + 0,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 1],
            timbre: [1, 1, 1, 1]*0.5,
            morph: 0.5 - [0, 0.1, 0.1, -0.2],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.9, 0.9, 2] * 0.35,
            lpg_colour: [0.75, 0.75, 0.75, 0.5] * 1,
            // fm_mod: -0.95,
            // timb_mod: 1,
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5 *2)]!2 + sig2;
        // sig2 = (MiWarpsx.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        sig = VAKorg35.ar(sig, 2000, 0.125, 0.125, 0);
        sig = ~v.(sig, 4000);
/*        sig = DCompressor.ar(
            input: sig,          sidechainIn: 0,        sidechain: 0,
            ratio: 4,            threshold: -40,        attack: 0.1,
            release: 100.1,      makeup: 0.5,           automakeup: 1
        );*/
        sig * 0.25;
    }.play(fadeTime: 0.01).register;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms2.isPlaying, {~toms2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms2 = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([1, 1].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, a, a];
        var pat2 = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0].rotate(8);
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 22 + [0, 0, 0, 0] + 12,
            engine: 1,
            harm: [0.25, 0.4, 0.4, 1],
            timbre: [1, 1, 1, 1],
            morph: 0.85 - [0, 0.1, 0.1, -0.2],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.9, 0.9, 2] * 0.75,
            lpg_colour: [0.75, 0.75, 0.75, 0.5] * 1,
            // fm_mod: -0.95,
            // timb_mod: 1,
            morph_mod: -1
        ) * dd.lag(0.05);
        var v = 1;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.5 *2)]!2 + sig2;
        // sig2 = (MiWarpsx.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
        sig = VAKorg35.ar(sig, 2000, 0.125, 0.125, 0);
        sig = ~v.(sig, 4000);
/*        sig = DCompressor.ar(
            input: sig,          sidechainIn: 0,        sidechain: 0,
            ratio: 4,            threshold: -40,        attack: 0.1,
            release: 100.1,      makeup: 0.5,           automakeup: 1
        );*/
        sig * 0.25;
    }.play(fadeTime: 0.01).register;
});
)
