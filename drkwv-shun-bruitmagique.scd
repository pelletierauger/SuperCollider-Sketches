~nT.tempo = 1;
~nT.tempo;
(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    q.free;
    q = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(71 + [0, 0.1],
            engine: 9,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        var trig2 = Impulse.ar(~nT.tempo * 8);
        var sig2 = MiPlaits.ar(68 + [0, 0.1],
            engine: 9,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig2,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = ~v.(sig2 + sig, 1000, 0, 5) * 0.4;
            sig = MiWarps.ar(
            sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.85,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    q.free;
    q = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(71 - 12 + [0, 0.1],
            engine: 9,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        var trig2 = Impulse.ar(~nT.tempo * 8);
        var sig2 = MiPlaits.ar(68 - 12 + [0, 0.1],
            engine: 9,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig2,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = ~v.(sig2 + sig, 1000, 0, 3) * 0.4;
            sig = MiWarps.ar(
            sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.85,
        algo: 4, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    }.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    r.free;
    r = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(71 - 12 + [0, 0.1],
            engine: 9,
            harm: 0.75,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig,
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25);
        var trig2 = Impulse.ar(~nT.tempo * 8);
        var sig2 = MiPlaits.ar(68 - 12 + [0, 0.1],
            engine: 9,
            harm: 0.75,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig2,
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25);
        sig = ~v.(sig2 + sig, 1000, 0, 1) * 0.4;
            sig = MiWarps.ar(
            sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.85,
        algo: 4, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    }.play;
});
)


(
~droo.free;
~droo = {
    var x = 0.479251; // MouseX.kr(0, 1);
    var y = 0.861758; // MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1);
    var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);
    var sig = MiPlaits.ar(
        ~toMidi.("C1") + 8 + [0, 0.01 * lfo] + xx,
        engine: 0,
        harm: x, timbre: 1 - y, morph: y
    );
    sig = [sig[0][1], sig[1][1]];
    // y.poll;
    sig = VadimFilter.ar(
        sig,
        1000 * lfo.unipolar + 100,
        0.25,
        1
    ) * 0.2 * Line.kr(0,1,15);
}.play;
)

// -----------------------------------------------------------------
// Une tierce au-dessus.
// -----------------------------------------------------------------

(
~droo2.free;
~droo2 = {
    var x = 0.479251; // MouseX.kr(0, 1);
    var y = 0.861758; // MouseY.kr(0, 1);
    var lfo = SinOsc.kr(0.1);
    var xx = (round(sin(x * 50) * 0.5 + 0.5)).lag(0.5);
    var sig = MiPlaits.ar(
        ~toMidi.("C1") + 8 + 15 + [0, 0.01 * lfo] + xx,
        engine: 0,
        harm: x, timbre: 1 - y, morph: y
    );
    sig = [sig[0][1], sig[1][1]];
    // y.poll;
    sig = VadimFilter.ar(
        sig,
        1000 * lfo.unipolar + 100,
        0.25,
        1
    ) * 0.2 * Line.kr(0,1,15);
}.play;
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1);
        var trig2 = Impulse.kr(~nT.tempo * 2);
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 0];
        var pat1 = [0, 0, 1, 0, 0, 0, 1, 1];
        var pat2 = [1];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dm = Demand.kr(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [ 0, 12, 12, 36 ],
            engine: 9,
            harm: 0.25,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate,
            decay: [0.9, 0.6, 0.6, 0.7] * 0.85,
            lpg_colour: 0
        );
        var dd = Demand.kr(trig, 0, Dseq([2, 1].stutter(16), inf));
        var ddd = Demand.kr(trig, 0, Dseq([8000, 5000].stutter(16) - 0, inf));
        var sig2 = [sig[1][1], sig[2][1]] * 1.5;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = VadimFilter.ar(sig, 2500, 0.5, 1);
        sig = Decimator.ar(sig, 1100 * dd, 12) * 0.5;
        sig = VadimFilter.ar(sig, ddd, 0.25, 1) * 2;
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 0.5;
    }.play(fadeTime: 0.01).register;
});
)

(
~k.stop;
~k = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq(1 * [1], inf),
    \buf, Pindex(~kicks, Pseq([59, 59], inf)),
    \amp, 0.125 * 0.25
).play(~nT, quant: 2);
)

(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([0.125], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~hats[31],
    \amp, Pseq([0.65, 0.25, 0.5, 0.25] * 0.25, inf) * 0.125
).play(~nT, quant: 2);
)

(
~s.stop;
~s = Pbind(
    \instrument, \samplerStereo,
    \dur, Pseq([Rest(0.98 * 0.5), 1.02 * 0.5], inf),
    // \buf, Pindex(~kicks, Pseq((0..~snares.size), inf))
    \buf, ~snares[15],
    \amp, Pseq([0.125], inf)
).play(~nT, quant: 2);
)



(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    r.free;
    r = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(71 + 24 + [0, 0.1],
            engine: 9,
            harm: 0.75,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 1.25);
        var trig2 = Impulse.ar(~nT.tempo * 8);
        var sig2 = MiPlaits.ar(68 + 24 + [0, 0.1],
            engine: 9,
            harm: 0.75,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.5, 0.95),
            trigger: trig2,
            decay: 0.1,
            lpg_colour: 0,
            mul: 1.25);
        sig = ~v.(sig2 + sig, 1000, 0, 3) * 4;
            sig = MiWarps.ar(
            sig, DelayN.ar(sig, 1, 1/32), lev1: 0.85, lev2: 0.85,
        algo: 4, timb: 0.5, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    }.play;
});
)
