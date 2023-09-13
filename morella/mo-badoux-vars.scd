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
    ) + DelayC.ar(~v.(sig,3000,0,5)*0.5*1, 12, 12);
    Out.ar(0, sig * 0.4);
}.play;
// });
)



// Bas, doux

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
    sig = Splay.ar(sig.scramble);
    // sig = ~split.(sig.scramble);
    sig = sig * Line.kr(0, 1, 1);
    sig = VadimFilter.ar(sig, 9500 * e + 150, 0, 1);
    sig = MiRings.ar(sig, pit: 24+0, struct: 0.25, bright:0.15, damp:0.17,
        pos: 0.25, model: 4
    ) + DelayC.ar(MiRings.ar(~v.(sig,3000,0,5)*0.5,pit:36)*4, 12, 12);
    Out.ar(0, sig * 0.4);
}.play;
// });
)




(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
x.free;
x = {
    | trigGate = 1 |
    var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
    var t2 = Impulse.kr(Demand.kr(Impulse.kr(1),0,Dwhite(4,64)));
    var d2 = Demand.kr(t2, 0, Drand([-1,1],inf)).lag(0.001);
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
    sig = Splay.ar(sig.scramble);
    // sig = ~split.(sig.scramble);
    sig = sig * Line.kr(0, 1, 1);
    sig = VadimFilter.ar(sig, 9500 * e + 150, 0, 1);
    sig = MiRings.ar(sig, pit: 24+0, struct: 0.25, bright:0.15, damp:0.17,
        pos: 0.25, model: 4
    ) + DelayC.ar(XFade2.ar(~v.(sig,3000,0,5)*0.5*4,MiRings.ar(~v.(sig,3000,0,5)*0.5,pit:36)*4,pan:d2), 12, 12);
    Out.ar(0, sig * 0.4);
}.play;
// });
)

XFade2