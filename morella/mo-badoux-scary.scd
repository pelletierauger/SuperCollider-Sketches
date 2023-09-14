(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
x.free;
x = {
    | trigGate = 1 |
    var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
    var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
    var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle)*0.9+0.1;
    // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
    // var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
    var shift = 0.1;
    var note = 24 + ( [0, 6, 12, 18, 24, 30, 36] * 0.1)+24+0;
    var sig = MiBraids.ar(
        pitch: note ++ (note + shift)  ++ (note + shift + 1)+12,
        timbre: 0, color: 0.5, model: 14,
        resamp: 2, decim: 22, bits: 6, ws: 0
    );
    var splitSig = ~split.(sig.scramble);
    sig = Splay.ar(sig.scramble);
    // sig = ~split.(sig.scramble);
    sig = sig * Line.kr(0, 1, 1);
    sig = VadimFilter.ar(sig, 9500 * e + 150, 0, 1);
    splitSig = splitSig * Line.kr(0, 1, 3);
    splitSig = VadimFilter.ar(splitSig, 9500 * e + 150, 0, 1);
    sig = MiRings.ar(sig, pit: 24+0-12, struct: 0.25, bright:0.15, damp:0.17,
        pos: 0.25, model: 4
    );
    sig = sig + DelayC.ar(MiRings.ar(~v.(splitSig,3000,0,3)*0.125*0.25*0,pit:36-12)*1, 12, 12);
    Out.ar(0, sig * 0.4 * 0.1 * Line.kr(0, 1, 3));
}.play;
// });
)

(
~twn.free;
~twn = {
    var note = 46+48 + ((0..9)/10);

    var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle)*0.9+0.1;
    var sig = MiBraids.ar(note, timbre: 0.6, color: 0.54, model: 42);
    sig = ~v.(~split.(sig), 2000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,9000)*8.5*e;
    sig = ~v.(sig, (46+48).midicps,0,3);
}.play;
)


(
y.free;
y = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E2") * [1, 1.1] * ~lfo.(0.05,0.4,0.7) + 1 + 0,
        timbre: 0.95, color: 0.15, model: 13,
        resamp: 0, decim: 22, bits: 4, ws: 0
    );
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2")+(~lfo.(1)*1), struct,
        bright: 0.2, damp: 0.7, pos: 0.5, model:4, poly: 1
    );
    sig = VadimFilter.ar(sig, 500, 0, 5) * 4;
    // sig.size.poll;
    sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 2,
        algo: 3, timb: 0.4, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    sig = ~v.(~v.(sig, 1200),200,0,5) * 0.65;
    sig * 2 * EnvGen.kr(Env([0,0,1], [0.009,0.05]));
}.play;
)

(
y.free;
y = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E2") * [1, 1.1] * ~lfo.(0.05,0.4,0.7) + 1 + 0,
        timbre: 0.95, color: 0.15, model: 13
    );
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2")+(~lfo.(1)*1), struct,
        bright: 0.2, damp: 0.7, pos: 0.5, model:4, poly: 1
    );
    sig = VadimFilter.ar(sig, 500, 0, 5) * 4;
    // sig.size.poll;
        sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 2,
        algo: 3, timb: 0.4, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    sig * 2 * EnvGen.kr(Env([0,0,1], [0.009,0.05]));
}.play;
)