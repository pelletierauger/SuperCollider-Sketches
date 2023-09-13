// Bas, doux

(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
        var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
    // var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
    var shift = 0.1;
        var note = 24 + ( [0, 6, 12, 18, 24, 30, 36] * 0.1)+24+0;
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1)+12,
            timbre: 0, color: 0.5, model: 14,
        resamp: 2, decim: 22, bits: 6, ws: 0
        );
    sig = Splay.ar(sig.scramble);
    // sig = ~split.(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 9500 * e + 150, 0, 1);
    sig = MiRings.ar(sig, pit: 24+0, struct: 0.25, bright:0.15, damp:0.17,
        pos: 0.25, model: 4
    ) + DelayC.ar(sig*0.125*0, 12, 0);
        Out.ar(0, sig * 0.4);
    }.play;
// });
)

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
~twn2.free;
~twn2 =
{
    var note = 46+48+12+3 + ((0..9)/10);

        var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
    var sig = MiBraids.ar(note, timbre: 0.6, color: 0.54, model: 42);
    sig = ~v.(~split.(sig), 2000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,9000)*1.5*e*4;
}.play;
)

(
~twn3.free;
~twn3 = {
    var note = 46+12+24+24 + ((0..9)/10);

    var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
    var sp = 12;
    var t = Impulse.kr(sp);
    var d = Demand.kr(t, 0, Dstutter(Drand((0..8),inf), Dxrand((16..32),inf)));
    var d2 = Demand.kr(t, 0, Dstutter(Drand((0..8),inf), Dxrand((-10..-100),inf)));
    var e2 = EnvGen.kr(Env.perc(0.01,sp/1-0.01,1,d2),gate:t);
    var rr = Rand(0.92,0.96!note.size);
    var sig = MiBraids.ar(note, timbre: rr, color: 0.54, model: 2,
        resamp: 2, decim: d, bits: 6, ws: e2
    );
    sig = ~v.(~split.(sig),7000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,(~lerp.(18000*e2,8000,0.5))+10)*8.5*4*4*e2;
    sig = ~v.(sig, 8000,0,5)*4*2;
}.play;
)