~nT = TempoClock.new(0.5).permanent_(true);
~nT.tempo;
~nT.tempo = 0.5;
~cb = Bus.control(s, 2);
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
z.free;
z = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
    var t = tr[1] * dd * Demand.kr(tr[1] * dd, 0, Dseq(
        [1, 0].wrapExtend(8) ++ [1, 0, 0, 1, 0, 0, 0, 0]
        , inf));
    var de = Demand.kr(t, 0, Dseq([3, 3, 3, 3, 3, 6], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.01, de], [2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -1].stutter(12), inf));
    var sig = MiBraids.ar(
        pitch: 27 + 12 + [0, 7, 12] + ([0, 0.25].stutter(3)) + note,
        timbre: 0.5,     color: 0.75,     model: 9,
        trig: t,
        resamp: 2,       decim: 10,       bits: 4,       ws: 0,
    ) * 0.4 * dd.lag(0.05);
    // sig = DelayC.ar(sig, 1, (0..3)*0.1);
    sig = sig.sum;
    sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3 * e,
        shelvingfreq: (27 + 48 + 12).midicps, oversample: 0
    ) * 0.2;
    sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3,
        shelvingfreq: (27 + 48 + 48 + 12).midicps, oversample: 0
    ) * 0.2;
    sig = ~v.(sig, 8000 * e + 1800 * 0.5);
    sig = MiRings.ar(sig!2,
            pit: 27+0+note+[0,0.1]+12, struct: 0.65, bright: 0.85,
            damp: 0.76, pos: 0.25, model: 1) * 0.5 + (sig * 0.25);
    // sig = sig + (~v.(sig, 3000, 0, 3) * 8);
    sig * 0.5 * dd.lag(0.05);
}.play;
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
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0];
        var pat2 = (0!16) ++ [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
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
            decay: [0.9, 0.6, 0.6, 2] * 0.5,
            lpg_colour: [0.75, 0.75, 0.75, 0],
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
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        sig * 0.5;
    }.play(fadeTime: 0.01).register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms.isPlaying, {~toms.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var hh = Demand.kr(trig * block2, 0, Dseq([0.9, 1.1], inf));
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
        var sig = MiPlaits.ar(
            pitch: 27 + [0, 12, 12, 24] + 0,
            engine: 9,
            harm: [0.25, 0.4, 0.4, 0.25],
            timbre: [1, 1, 1, 1],
            morph: 0.75 - [0, 0.2, 0, -0.1],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, hh] * 0.75,
            lpg_colour: [0.75, 0.75, 0.75, 1] * 1,
            // fm_mod: -0.5,
            // timb_mod: 0.5
            morph_mod: -1
        ) * dd.lag(0.1);
        // var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16), inf));
        var v = 0;
        var sig3;
        var sig2 = [sig[1][v], sig[2][v]] * 1.5 * Line.kr(0, 1, ~nT.beatDur * 2);
        sig = [sig[0][v] * 2 + (sig[3][v] * 0.15)]!2 + sig2;
        sig = sig + (~v.(sig, 3000, 0, 5) * 8);
/*            sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.25, bias: 0, lowgain: 0.3, highgain: 0.3,
        shelvingfreq: (27 + 24).midicps, oversample: 0
    ) * 0.2;*/
        // sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 1, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig + (sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1));
        // sig = sig + (~v.(sig, 3000, 0, 3) * 2);
        sig * 1;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
n.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
n = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
 //     [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
        [1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0]
        , inf));
    var note = Demand.kr(t, 0, Dseq([27, 26].stutter(32), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: note + 12,                 engine: 10,
        harm: 0.95,                timbre: 0.25,                 morph: 0,
        trigger: b,                /*level: level.lag(0.05),*/
        fm_mod: 0.5,      timb_mod: 0,                  morph_mod: -0.5,
        decay: 0.35
            ,                lpg_colour: 0.5
   ).sum * dd.lag(0.05);
     sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 2;
    sig = VadimFilter.ar(sig, 50, 0, 5) * 2 * dd.lag(0.05);
        sig = CombC.ar(sig, 1, (note-0).midicps.reciprocal*[1,1.01], 4);
        // sig = CombC.ar(sig, 1, (note-0).midicps.reciprocal*1.01, 4);
        sig = ~v.(sig, 3000, 0, 3);
            sig = MiRings.ar(sig!2,
            pit: 27+0+note+[0,0.1]+0, struct: 0.65, bright: 0.85,
            damp: 0.76, pos: 0.25, model: 1) * 0.5 + (sig * 0.25)*1;
   /* sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3,
        shelvingfreq: (27 + 48 + 48 + 12).midicps, oversample: 0
    ) * 0.1;
                sig = ~v.(sig, 3000, 0, 5);
            sig = MiRings.ar(sig!2,
            pit: 27+0+note+[0,0.1]+0, struct: 0.65, bright: 0.5,
            damp: 0.76, pos: 0.25, model: 1) * 0.5 + (sig * 0.25)*2;*/
        sig = ~v.(sig, \freq.kr(3000), 0, 1);
}.play(fadeTime: 0);
});
)

