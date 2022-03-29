
(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 0.5), {
    ~nesNoi.set(\gate, 0, \fadeTime, 0.1);
    ~nesNoi = {
        var t = Impulse.kr(~nT.tempo * 1);
        var d = Demand.kr(t, 0, Dseq([0, 1], inf));
        var sig = Nes2.ar(
            trig: t,
            d0: 2r00100111,
            d2: d,
            smask: 2r00001000
        ).dup * 1;
        sig * 0.2 * Line.kr(0, 1, ~nT.beatDur * 32);
        // sig;
    }.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 0.5), {
    ~nesNoi.set(\gate, 0, \fadeTime, 0.1);
    ~nesNoi = {
        var t = Impulse.kr(~nT.tempo * 1);
        var d = Demand.kr(t, 0, Dseq([0, 1] + 2, inf));
        var sig = Nes2.ar(
            trig: t,
            d0: 2r00100111,
            d2: d,
            smask: 2r00001000
        ).dup * 1;
        sig * 0.1;
        // sig;
    }.play;
});
)



DWhite

{Nes2.ar(Impulse.kr(3), d0:2r00000100, d2:MouseX.kr(0, 15), smask:2r00001000)}.play
{Nes2.ar(Impulse.kr(3), d0:2r00100111, d2:Line.kr(0, 15, 3), smask:2r00001000)}.play



(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 2), {
    z.set(\gate, 0, \fadeTime, 0.1);
    z = {
        var cutoff = SinOsc.kr(1).range(4000, 2000);
        var t0 = Impulse.kr(~nT.tempo * 2);
        var t = t0 * Demand.kr(t0, 0, Dseq(
            [
       //       |     ;     |     ;
                1, 0, 0, 0, 0, 0, 1, 0,
                0, 0, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 1, 0,
                0, 0, 1, 0, 1, 0, 0, 1
        ], inf));
        var dem = Demand.kr(t, 0, Dseq((0.125)!3 ++ (0.75!1), inf));
        var dem2 = Demand.kr(t, 0, Dseq((0)!3 ++ (1000!1), inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.05, 1.5], [-8, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([0, -2, 2, -5].rotate(2).reverse, inf));
        var in = MiBraids.ar(
            48, timbre: 0.75, color: 0.5, model: 34, trig: t,
            resamp: 0, decim: 16, bits: 5, ws: 1 - env.lag(0.5) * 0.125
        );
        cutoff = 5 + (8000 * env.lag(0.5));
        VadimFilter.ar(
            input: in,
            freq: cutoff,
            resonance: 0,
            type: 1
        ) * 2!2 * 0.4;
    }.play(fadeTime: 0);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 0), {
    ~nesNoi.set(\gate, 0, \fadeTime, 0.1);
    ~nesNoi = {
        var t = Impulse.kr(~nT.tempo * 1);
        var d = Demand.kr(t, 0, Dseq([0, 1], inf));
        var d2 = Demand.kr(t, 0, Dseq([
            2r10000000, 2r10000010

        ], inf));
        var sig = Nes2.ar(
            trig: t,
            // a0: 2r00000000,
            d0: 2r00100111,
            d2: d2,
            smask: 2r00001000
        ).dup * 1;
        sig = sig * 0.2 * Line.kr(0, 1, ~nT.beatDur * 32);
        sig = VadimFilter.ar(sig, 2000, 0, 1);
        // sig;
    }.play;
});
)

2r10000000 + 2r00000010


(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 0), {
    ~nesNoi2.set(\gate, 0, \fadeTime, 0.1);
    ~nesNoi2 = {
        var t = Impulse.kr(~nT.tempo * 1);
        var d = Demand.kr(t, 0, Dseq([0, 1], inf));
        var d2 = Demand.kr(t, 0, Dseq([
            2r10000001, 2r10000010

        ], inf));
        var sig = Nes2.ar(
            trig: t,
            // a0: 2r00000000,
            d0: 2r00100110,
            d2: d2,
            smask: 2r00001000
        ).dup * 1;
        sig = sig * 0.8 * Line.kr(0, 1, ~nT.beatDur * 32);
        sig = VadimFilter.ar(sig, 2000, 0, 1);
        // sig;
    }.play;
});
)



// Sprinkler
(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 0), {
    ~nesNoiB.set(\gate, 0, \fadeTime, 0.1);
    ~nesNoiB = {
        var t = Impulse.kr(~nT.tempo * 2);
        var d = Demand.kr(t, 0, Dseq([1, 1], inf));
        var sig = Nes2.ar(
            trig: t,
            d0: 2r00100111,
            d2: d,
            smask: 2r00001000
        ).dup * 1;
        sig * 0.2 * Line.kr(0, 1, ~nT.beatDur * 32);
        // sig;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 0), {
    ~nesNoi.set(\gate, 0, \fadeTime, 0.1);
    ~nesNoi = {
        var t = Impulse.kr(~nT.tempo * 2);
        var d = Demand.kr(t, 0, Dseq([0, 1], inf));
        var d2 = Demand.kr(t, 0, Dseq([
            2r10000110, 2r10000001,
            2r10000010, 2r10000001,
            2r10000100, 2r10000001,
            2r10000010, 2r10000001
        ], inf));
        var sig = Nes2.ar(
            trig: t,
            d0: 2r00100110,
            d2: d2,
            smask: 2r00001000
        ).dup * 1;
        sig = VadimFilter.ar(sig, 2500, 0, 1);
        sig * 0.1 * Line.kr(0, 1, ~nT.beatDur * 32);
        // sig;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 0), {
    ~nesNoi.set(\gate, 0, \fadeTime, 0.1);
    ~nesNoi = {
        var t = Impulse.kr(~nT.tempo * 1);
        var d = Demand.kr(t, 0, Dseq([0, 1], inf));
        var d2 = Demand.kr(t, 0, Dseq([
            2r10000110, 2r10000001,
            2r10000010, 2r10000001,
            2r10000100, 2r10000001,
            2r10000010, 2r10000001
        ].rotate(2), inf));
        var sig = Nes2.ar(
            trig: t,
            d0: 2r00100110,
            d2: d2 + 12,
            smask: 2r00001000
        ).dup * 1;
        sig * 0.4 * Line.kr(0, 1, ~nT.beatDur * 32);
        // sig;
    }.play;
});
)