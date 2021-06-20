~nT.tempo = 1.39;


// --------------------------------------------------------------------------------
// Percussions
// --------------------------------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 7)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4);
        var block0 = Demand.ar(trig, 0, Dseq([1, 0, 1, 0, 0, 1, 0, 0], inf));
        var block1 = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 1, 0, 1, 0], inf));
        var dem = Demand.ar(trig, 0, Dseq([0.1, -0.1].stutter(16), inf));
        var sig = MiPlaits.ar(
            pitch: 30 + 0,
            engine: 9,
            harm: 0.95,
            timbre: 0.5,
            morph: 0.45 - [0, 0.2] + dem,
            trigger: trig * [block0, block1] * trigGate,
            decay: 0.72 + [0, 0.1] - 0.05 - 0.0,
            lpg_colour: 0
        );
        sig = [sig[0][1] + sig[1][1]]!2;
        sig = HPF.ar(sig, 400);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.75 * 1.2 * 2;
    }.play(fadeTime: 0.01).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~snare2.isPlaying, {~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 7)});

    ~snare2 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4);
        var block0 = Demand.ar(trig, 0, Dseq([1, 0, 1, 0, 0, 1, 0, 0], inf));
        var block1 = Demand.ar(trig, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
        var dem = Demand.ar(trig, 0, Dseq([0.1, -0.1].stutter(16), inf));
        var sig = MiPlaits.ar(
            pitch: 30 + 0,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.2] + dem,
            trigger: trig * [block0, block1] * trigGate,
            decay: 0.82 + [0, 0.1] - 0.05 - 0.0,
            lpg_colour: 0
        );
        sig = [sig[0][1] * 0 + sig[1][1]]!2;
        sig = HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.75 * 1.2 * 0.5;
    }.play(fadeTime: 0.01).register;
});
)


// --------------------------------------------------------------------------------
// Une note boisée et feedbackée.
// --------------------------------------------------------------------------------



(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.1, {
    x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 1);
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
        var dem2 = Demand.ar(t, 0, Dseq([0.25, 0.5].stutter(1), inf));
        var dem3 = Demand.ar(t, 0, Dseq([0.5, 2].stutter(1), inf));
        var dem4 = Demand.ar(t, 0, Dseq([7, 7, 7, -5].stutter(1), inf));
        var dem5 = Demand.ar(t, 0, Dseq([3, 3, 3, -9].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 1 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
        var spos = 90.894;
        var buf = c;
    var sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: 0.5 * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        ) * env;
        // sig = [sig[1] + sig[0], sig[2] + sig[0]];
        // sig = sig!2;
    sig = sig + in;
        sig = LPF.ar(sig, 5000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.7, 0.5, 0.25 * [0.2501, 0.25], dem3) * 0.5;
    LocalOut.ar(sig);
        // sig = sig.clip(-1.0, 1.0) * 0.5;
        // sig = LPF.ar(sig, 3000);
        // sig = (HPF.ar(sig, 3000) * 3);
    sig * 8;
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.1, {
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 1);
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
        var dem2 = Demand.ar(t, 0, Dseq([-24, -29].stutter(4), inf));
        var dem3 = Demand.ar(t, 0, Dseq([1.0, 0.1].stutter(1), inf));
        var dem4 = Demand.ar(t, 0, Dseq([7, 7, 7, -5].stutter(1), inf));
        var dem5 = Demand.ar(t, 0, Dseq([3, 3, 3, -9].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 0.9 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
        var spos = 90.894;
        var buf = c;
    var sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: dem2.midiratio * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        ) * env;
        // sig = [sig[1] + sig[0], sig[2] + sig[0]];
        // sig = sig!2;
    sig = sig + in;
        sig = LPF.ar(sig, 5000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.7, 0.5, 0.125 * [0.26, 0.25], dem3) * 0.5;
    LocalOut.ar(sig);
        // sig = sig.clip(-1.0, 1.0) * 0.5;
        // sig = LPF.ar(sig, 3000);
        // sig = (HPF.ar(sig, 3000) * 3);
    sig * 8;
}.play;
});
)


// --------------------------------------------------------------------------------
// Nouvelles notes boisées et feedbackées.
// --------------------------------------------------------------------------------



(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.1, {
y.set(\mm, 0.125, \trigGate, 0, \gate, 0, \fadeTime, 8);
y = {
        | trigGate = 1, mm = 1 |
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 1) * trigGate;
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
        var dem2 = Demand.ar(t, 0, Dseq([-24, -29].stutter(4), inf));
        var dem3 = Demand.ar(t, 0, Dseq([0.6, 0.1, 1.0, 0.55].stutter(1) * 1, inf));
        var dem4 = Demand.ar(t, 0, Dseq([7, 7, 7, -5].stutter(1), inf));
        var dem5 = Demand.ar(t, 0, Dseq([3, 3, 3, -9].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 0.9 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
        var spos = 90.894;
        var buf = c;
    var sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: dem2.midiratio * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        ) * env;
        // sig = [sig[1] + sig[0], sig[2] + sig[0]];
        // sig = sig!2;
    sig = sig + in;
        sig = LPF.ar(sig, 5000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.7, 0.5, 0.125 * [0.26, 0.25], dem3) * 0.5;
    LocalOut.ar(sig);
        // sig = sig.clip(-1.0, 1.0) * 0.5;
        // sig = LPF.ar(sig, 3000);
        // sig = (HPF.ar(sig, 3000) * 3);
    sig * 8;
}.play;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.1, {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 0.25);
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
        var dem2 = Demand.ar(t, 0, Dseq([0.25, 0.5].stutter(1), inf));
        var dem3 = Demand.ar(t, 0, Dseq([0.25, 0.65].stutter(1), inf));
        var dem4 = Demand.ar(t, 0, Dseq([7, 7, 7, -5].stutter(1), inf));
        var dem5 = Demand.ar(t, 0, Dseq([3, 3, 3, -9].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
        var spos = 52.894;
        var buf = c;
    var sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: 1 * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        ) * env;
        // sig = [sig[1] + sig[0], sig[2] + sig[0]];
        // sig = sig!2;
    sig = sig + in;
        sig = LPF.ar(sig, 5000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.7, 0.5, 0.125 * [0.2501, 0.25], dem3) * 0.5;
    LocalOut.ar(sig);
        // sig = sig.clip(-1.0, 1.0) * 0.5;
        // sig = LPF.ar(sig, 3000);
        // sig = (HPF.ar(sig, 3000) * 3);
    sig * 8;
}.play;
});
)



// --------------------------------------------------------------------------------
// À la Jelinek.
// --------------------------------------------------------------------------------



(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.1, {
    x.set(\gate, 0, \fadeTime, 0.1);
    y.set(\gate, 0, \fadeTime, 0.1);
~ssy.set(\gate, 0, \fadeTime, 0.1);
~ssy = {
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 0.25);
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
        var dem2 = Demand.ar(t, 0, Dseq([0, -2].stutter(1), inf));
        var dem3 = Demand.ar(t, 0, Dseq([0.5, 2].stutter(1), inf));
        var dem4 = Demand.ar(t, 0, Dseq([7, 7, 7, -5].stutter(1), inf));
        var dem5 = Demand.ar(t, 0, Dseq([3, 3, 3, -9].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
    var sig = MiBraids.ar(
            pitch: 45 + 12 + [0, 3, 7] + dem2,
            timbre: 0.5,
            color: 0.0,
            model: 12,
            trig: 0,
            resamp: 1,
            decim: 32,
            bits: 6,
            ws: 1,
            mul: 1
        ) * env;
    sig = [sig[1] + sig[0], sig[2] + sig[0]];
        // sig = sig!2;
    sig = sig + in;
        sig = LPF.ar(sig, 2000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.7, 0.5, 0.25 * [0.2501, 0.25], dem3) * 0.5;
    LocalOut.ar(sig);
        // sig = sig.clip(-1.0, 1.0) * 0.5;
        // sig = LPF.ar(sig, 3000);
        // sig = (HPF.ar(sig, 3000) * 3);
    sig * 1;
}.play;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.1, {
    // x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 2);
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
        var dem2 = Demand.ar(t, 0, Dseq([0.25, 0.5].stutter(1), inf));
        var dem3 = Demand.ar(t, 0, Dseq([0.5, 4].wrapExtend(14) ++ [0.25, 0.25], inf));
        var dem4 = Demand.ar(t, 0, Dseq([7, 7, 7, -5].stutter(1), inf));
        var dem5 = Demand.ar(t, 0, Dseq([3, 3, 3, -9].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 0.5 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
        var spos = 100.894;
        var buf = c;
    var sig = PlayBuf.ar(
            numChannels: 2,
            bufnum: buf,
            rate: 1 * BufRateScale.ir(buf),
            trigger: t,
            startPos: spos * BufSampleRate.ir(buf)
        ) * env;
        // sig = [sig[1] + sig[0], sig[2] + sig[0]];
        // sig = sig!2;
    sig = sig + in;
        sig = LPF.ar(sig, 5000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.5, 0.5, 0.125 * [0.2501, 0.25], dem3) * 0.5;
    LocalOut.ar(sig);
        // sig = sig.clip(-1.0, 1.0) * 0.5;
        // sig = LPF.ar(sig, 3000);
        // sig = (HPF.ar(sig, 3000) * 3);
    sig * 8;
}.play;
});
)




(
~nT.sched(~nT.timeToNextBeat(quant: 2) - 0.2, {
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 0.5);
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 2 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
    var sig = MiBraids.ar(
            pitch: 45 + 0,
            timbre: 0.5,
            color: 0.0,
            model: 4,
            trig: 0,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1,
            mul: 1
        ) * env;
        sig = sig!2;
    sig = sig + in;
        // sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.7, 0.5, dem * [0.2501, 0.25], 4 * dem) * 0.5;
    LocalOut.ar(sig);
        sig = (HPF.ar(sig, 3000) * 32);
    sig * 2;
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var tem = ~nT.tempo;
    var t = Impulse.ar(~nT.tempo * 0.5);
        var dem = Demand.ar(t, 0, Dseq([0.5, 0.25].stutter(1), inf));
    var env = EnvGen.ar(Env([0, 1, 0], [0.005, 0.9 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.ar(t, 0, Dseq([-5, -12], inf));
    var in = LocalIn.ar(2);
    var sig = MiBraids.ar(
            pitch: 45 + 12,
            timbre: 0.5,
            color: 0.0,
            model: 4,
            trig: 0,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1,
            mul: 1
        ) * env;
        sig = sig!2;
    sig = sig + in;
        // sig = LPF.ar(sig, 4000);
    sig = HPF.ar(sig, 100);
    sig = CombL.ar(sig * 0.7, 0.5, dem * [0.2501, 0.25], 4 * dem) * 0.5;
    LocalOut.ar(sig);
        sig = (HPF.ar(sig, 3000) * 32);
    sig * 2;
}.play;
});
)