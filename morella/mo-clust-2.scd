// ----------------------------------------------------------------------------
// Fantomatique, le meilleur
// ----------------------------------------------------------------------------

(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.125*0.125) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 3, 7].stutter(1), inf));
        var e = EnvGen.kr(Env.sine(dur: 24, level: 0.125).circle);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + ((0..3) * 6 * 0.025)+6;
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49 + ~lfo.(3,0,1),
            timbre: 0.29, color: 0.75, model: 37,
            resamp: 0, decim: 16, bits: 3, ws: 0
        );
        sig = VadimFilter.ar(sig, 7500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
        sig = Splay.ar(sig.scramble);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
// });
)
Env([0, 1, 0], [8, 24], [6, -8]).plot
Env.sine(dur: 1, level: 1).plot

(
~split = {
    | sig |
    var a = (sig.size / 2 - 1).floor;
    var b = (sig.size / 2).floor;
    var c = (sig.size - 1);
    var spanA = (0..a);
    var spanB = (b..c);
    [sig[spanA].sum, sig[spanB].sum];
};
)
~split.([0,1,2,3,4,5,6,7])

(
~twn.free;
~twn =
{
    var note = 46+48+12 + ((0..9)/10);

        var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
    var sig = MiBraids.ar(note, timbre: 0.6, color: 0.54, model: 42);
    sig = ~v.(~split.(sig), 2000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,9000)*1.5*e*4;
}.play;
)


(
~twn.free;
~twn =
{
    var note = 46+48+12 + ((0..9)/10);

        var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
    var sig = MiBraids.ar(note, timbre: 0.6, color: 0.54, model: 42,
        resamp: 2, decim: 32, bits: 3, ws: 0
    );
    sig = ~v.(~split.(sig), 2000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,9000)*8.5*e;
}.play;
)

(
~twn.free;
~twn =
{
    var note = 46+48+12 + ((0..9)/10);

        var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
    var t = Impulse.kr(3);
    var d = Demand.kr(t, 0, Drand((0..32), inf));
    var sig = MiBraids.ar(note, timbre: 0.6, color: 0.54, model: 42,
        resamp: 2, decim: d, bits: 3, ws: 0
    );
    sig = ~v.(~split.(sig), 2000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,9000)*8.5*e;
}.play;
)
(
~twn.free;
~twn =
{
    var note = 46+48+24;
    var sig = MiBraids.ar(note+[0,0.1], timbre: 0.8, color: 0.9, model: 42);
    ~v.(sig, 5000,0,5)* 0.125*0.5 * 1}.play;
)
((0..9)/10).size
(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.free;
    y = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.125*0.125) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 3, 7].stutter(1), inf));
        var e = EnvGen.kr(Env.sine(dur: 24, level: 0.125).circle);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + ((0..3) * 6 * 0.025)+0;
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49 + ~lfo.(3,0,1),
            timbre: 0.29, color: 0.75, model: 37,
            resamp: 0, decim: 16, bits: 3, ws: 0
        );
        sig = VadimFilter.ar(sig, 7500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
        sig = Splay.ar(sig.scramble);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
// });
)




(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    o.free;
    o = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.125*0.125) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 3, 7].stutter(1), inf));
        var e = EnvGen.kr(Env.sine(dur: 24, level: 0.125).circle);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 24 + d + ((0..3) * 6 * 0.025)+18;
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49 + ~lfo.(3,0,1),
            timbre: 0.29, color: 0.75, model: 37,
            resamp: 0, decim: 16, bits: 3, ws: 0
        );
    var cut = (sig.size/2).floor - 1;
    var end = sig.size - 1;
        sig = VadimFilter.ar(sig, 7500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
    end.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
    // sig = Splay.ar(sig.scramble);
    sig = [sig[0..5], sig[6..11]];
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1);
        Out.ar(0, sig * 0.4);
    }.play;
// });
)


(
a = [0,1,2,3,4,5,6,7,8,9];
a[4..6]
)