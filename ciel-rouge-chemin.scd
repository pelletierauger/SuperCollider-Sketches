(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur/32), {
    v.set(\trigGate, 0, \gate, 0, \fadeTime, 30);
v = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b  = t * Demand.kr(t, 0, Dseq([1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0], inf));
    var b2 = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0], inf));
    var b3 = t * Demand.kr(t, 0, Dseq([1, 1, 1, 1, 0, 1, 1, 1], inf));
    var b4 = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], inf));
    var b5 = t * Demand.kr(t, 0, Dseq([1, 0, 1, 1], inf));
    var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
    var melo2 = Demand.kr(b, 0, Dseq([0, -2].stutter(20), inf));
    var melo = Demand.kr(b, 0, Dseq([0].mirror2, inf) + Dseq([0,3].stutter(20), inf)) + melo2;
    var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
    var e = EnvGen.kr(Env([0,1,0],[0.02, 1], [0, -12]), gate: b);
    var e2 = EnvGen.kr(Env([0,1,0],[0.01, 1], [0, -8]), gate: b3);
    var e4 = EnvGen.kr(Env([0,1,0],[0.01, 0.4], [0, -8]), gate: b4);
    var e5 = EnvGen.kr(Env([0,1,0],[0.02, 0.7], [0, -8]), gate: b5);
    var melo5 = Demand.kr(b5, 0, Dseq([7, 3, 2, 7, 3, 2, 12, 10, 7, 12, 19, 15], inf)) + melo2;
    var sig = MiBraids.ar(
        pitch: 79 + [melo + -12, melo2 - 24 - 24],
        timbre: 0.275*e.lag(0.01), color: [0.125,0.2], model: [14, 14]
    ) * [0.25,1];
    var bass = ~v.(sig[1],1000) * 2;
    var drums = MiBraids.ar(
        pitch: 79 - 36 + melo2,
        timbre: 0.75, color: 0.25, model: 34, trig: b2
    ) * 4;
    var tsch = PinkNoise.ar(e4*4);
    var squeak;
    tsch = tsch + CombC.ar(tsch, 1, ~nT.beatDur/4*3*[1,1.01], 6) ! 2;
    bass = ~v.(bass, 2000 * [e2] + 100);
    bass = [bass, DelayC.ar(bass, 0.5, 0.01)] * 0.5;
    sig = ~v.(sig, 3000 * [e*e,e2] + 10);
    sig = ~v.(sig, 1000, 0, 5) * 4;
    squeak = (~v.(MiBraids.ar(
        pitch: 79 + [melo5 - 0],
        timbre: 0.75*e5.lag(0.01), color: 0.5, model: 14
    ), 4000 * e5, 0, 1)*e5*2!2);
    squeak = squeak + CombC.ar(squeak, 1, ~nT.beatDur/4*3*[1,1.01], 3) * 0.7;
    // sig = sig + squeak;
    sig = MiVerb.ar(sig[0]+(tsch*0)+squeak, time: 0.3, drywet: 0.05) + (sig[0]!2)+squeak;
    sig = sig * 1 + bass * 0.1 * 2 +(tsch*0) * dd.lag(0.05);
}.play(fadeTime: 0);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur/32), {
    v.set(\trigGate, 0, \gate, 0, \fadeTime, 30);
    v = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1]));
        var t = tr[1] * dd;
        var b  = t * Demand.kr(t, 0, Dseq([1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0], inf));
        var b2 = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0], inf));
        var b3 = t * Demand.kr(t, 0, Dseq([1, 1, 1, 1, 0, 1, 1, 1], inf));
        var b4 = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], inf));
        var b5 = t * Demand.kr(t, 0, Dseq([1, 0, 1, 1], inf));
        var m = Demand.kr(t, 0, Dseq([0.35, 0.4], inf));
        var melo2 = Demand.kr(b, 0, Dseq([0, -2].stutter(20), inf));
        var melo = Demand.kr(b, 0, Dseq([0].mirror2, inf) + Dseq([0,3].stutter(20), inf)) + melo2;
        var m2 = Demand.kr(t, 0, Dseq([0.5, 0.1], inf));
        var e = EnvGen.kr(Env([0,1,0],[0.02, 1], [0, -12]), gate: b);
        var e2 = EnvGen.kr(Env([0,1,0],[0.01, 1], [0, -8]), gate: b3);
        var e4 = EnvGen.kr(Env([0,1,0],[0.01, 0.4], [0, -8]), gate: b4);
        var e5 = EnvGen.kr(Env([0,1,0],[0.02, 0.7], [0, -8]), gate: b5);
        var melo5 = Demand.kr(b5, 0, Dseq([7, 3, 2, 7, 3, 2, 12, 10, 7, 12, 19, 15], inf)) + melo2;
        var sig = MiBraids.ar(
            pitch: ~key + [melo + -12, melo2 - 24 - 24],
            timbre: 0.275*e.lag(0.01), color: [0.125,0.2], model: [14, 14]
        ) * [0.25,1];
        var bass = ~v.(sig[1],1000) * 2;
        var drums = MiBraids.ar(
            pitch: ~key - 36 + melo2,
            timbre: 0.75, color: 0.25, model: 34, trig: b2
        ) * 4;
        var tsch = PinkNoise.ar(e4*4);
        var squeak;
        tsch = tsch + CombC.ar(tsch, 1, ~nT.beatDur/4*3*[1,1.01], 6) ! 2;
        bass = ~v.(bass, 2000 * [e2] + 100);
        bass = [bass, DelayC.ar(bass, 0.5, 0.01)] * 0.5;
        sig = ~v.(sig, 3000 * [e*e,e2] + 10);
        sig = ~v.(sig, 1000, 0, 5) * 4;
        squeak = (~v.(MiBraids.ar(
            pitch: ~key + [melo5 - 0],
            timbre: 0.95, color: 0.5*e5.lag(0.01), model: 19
        ), 3000 * e5, 0, 5)*e5*2!2);
        squeak = squeak + CombC.ar(squeak, 1, ~nT.beatDur/4*3*[1,1.01], 3) * 0.7;
        // sig = sig + squeak;
        squeak = ~v.(squeak, Line.kr(10,20000,~nT.beatDur*32));
        sig = MiVerb.ar(sig[0]+(tsch*0)+squeak, time: 0.3, drywet: 0.05) + (sig[0]!2)+squeak;
        sig = sig * 1 + bass * 0.1 * 2 +(tsch*0) * dd.lag(0.05);
    }.play(fadeTime: 0);
});
)
