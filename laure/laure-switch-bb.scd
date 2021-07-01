(
~n = 0;
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 4), {
    ~guitareC.stop;
    ~guitareW.stop;
    w.set(\gate, 0, \fadeTime, 0.1);
});
~drum = {
    // ~nT.sched(~nT.timeToNextBeat(quant: 4), {
    var vel = rrand(0.65, 0.95);

    ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4);
        var j = [0, 1].choose;
        var wh = 1!1 ++ (1!15);
        //         |            |           |           |
        var pat0 = [1, 0, 0, 0, 0, 0, j, 0, 0, 0, 1, 1, 0, 0, 0, 0] * wh;
        //         |            |           |           |
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0] * wh;
        var pat2 = [1, 0];
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var sig = MiPlaits.ar(
            pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
            engine: 9,
            harm: [0.95, 0.5, 0.5, 0.95].rotate(2),
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0, 0],
            trigger: trig * [block0, block1, block1, block2] * trigGate,
            decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * vel,
            lpg_colour: 0
        );
        var mu = 1;
        var sig2 = [sig[1][1], sig[2][1]] * 1.5 * mu;
        sig = [sig[0][1] * 2 * mu + (sig[3][1] * 0.25)]!2 + sig2;
        // sig = HPF.ar(sig, 2000);
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 0.5 * 0.8;
    }.play(fadeTime: 0.01).register;
    (~n.asString ++ ", vel:" + vel).postln;
    ~n = ~n + 1;
    nil;
    // });
    ("timeToNextBeat: " ++ ~nT.timeToNextBeat.asString).postln;
};
if(~cor.isPlaying, {~cor.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});

~nT.sched(~nT.timeToNextBeat(quant: 8) - (~nT.beatDur * 1.5), {

    if(~cor.isPlaying, {~cor.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});
    ~cor = {
        | trigGate = 1, damp = 1, freeze = 0 |
        var ds;
        var t = Impulse.kr(~nT.tempo / 4) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.5, 16], [2, -8, 'lin']), t * bl);

        var note0 = Demand.kr(t * bl, 0, Dseq([0, 1, -2], inf));
        var note1 = Demand.kr(t * bl, 0, Dseq([5, 5, 5], inf));
        var note2 = Demand.kr(t * bl, 0, Dseq([0, 0, 0.5], inf));
        var sig = MiBraids.ar(
            pitch: 50 + 12 + ([note0, note1] ++ ([note0, note1] - 12)),
            timbre: [0.9, 0.7].stutter(2),
            color: 0.1 + (1 - env.pow(2) * note2),
            model: 14,
            resamp: 0,
            decim: 10,
            bits: 0,
            ws: 1
        ) * env * [1, 0.25].stutter(2);
        sig = [sig[0] + (sig[2] * 1), sig[1] + (sig[3] * 1)];
        // sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400) + (note2.lag(1) * 2000));
        // sig = sig * SinOsc.kr(6).range(0.25, 1);
        sig = MiVerb.ar(
            inputArray: sig,
            time: 0.9,
            drywet: 1,
            damp: 1 - env.pow(2),
            freeze: freeze,
            diff: 0.8
        ) * 8;
        sig = LPF.ar(sig, 500 + (env.pow(2) * 500));
        /*   ds = Decimator.ar(sig, 10000, 2) * 1;
        ds = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
        sig = sig + (ds * 4);*/
        sig * 0.5;
    }.play(fadeTime: 0.01).register;
});
)



(
~n = 0;
~drum = {
    ~nT.sched(~nT.timeToNextBeat(quant: 8), {
        var vel = rrand(0.85, 0.95);
        ~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
        ~snare = {
            | trigGate = 1 |
            var trig = Impulse.ar(~nT.tempo * 2);
            var j = [0, 1].choose;
            var wh = 1!1 ++ (1!15);
            //         |            |           |           |
            var pat0 = [1, 0, 0, 0, 0, 0, j, 0, 0, 0, 1, 1, 0, 0, 0, 0] * wh;
            //         |            |           |           |
            var pat1 = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0] * wh;
            var pat2 = [1, 0];
            var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
            var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
            var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
            var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
            var sig = MiPlaits.ar(
                pitch: 30 + [0, 0, 0, 24] + 24 - [24, 12, 12, 12] + 0,
                engine: 9,
                harm: [0.95, 0.5, 0.5, 0.95].rotate(0),
                timbre: 1,
                morph: 0.45 - [0, 0.2, 0, 0],
                trigger: trig * [block0, block1, block1, block2] * trigGate,
                decay: 0.0 + [0.9, 0.6, 0.6, 0.7] * vel,
                lpg_colour: 0
            );
            var mu = 1;
            var sig2 = [sig[1][1], sig[2][1]] * 1.5 * mu;
            sig = [sig[0][1] * 2 * mu + (sig[3][1] * 0.25)]!2 + sig2;
            // sig = HPF.ar(sig, 2000);
            // sig = (sig * 0.75) + HPF.ar(sig, 200);
            // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
            sig = sig * 3.6 * 0.5 * 0.8;
        }.play(fadeTime: 0.01).register;
        (~n.asString ++ ", vel:" + vel).postln;
        ~n = ~n + 1;
        nil;
    });
    ("timeToNextBeat: " ++ ~nT.timeToNextBeat.asString).postln;
};
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    if(~cor.isPlaying, {~cor.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});
    ~cor = {
        | trigGate = 1 |
        var ds;
        var t = Impulse.kr(~nT.tempo / 8) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 16], [2, -8, 'lin']), t * bl);

        var note0 = Demand.kr(t * bl, 0, Dseq([0, 0, -4], inf));
        var note1 = Demand.kr(t * bl, 0, Dseq([5, 3, 3], inf));
        var sig = MiBraids.ar(
            pitch: 50 + 0 + ([note0, note1] ++ ([note0, note1] - 12)),
            timbre: [0.9, 0.7].stutter(2),
            color: 0.1,
            model: 4,
            resamp: 0,
            decim: 10,
            bits: 0,
            ws: 1
        ) * env * [1, 0.25].stutter(2);
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
        // sig = sig * SinOsc.kr(6).range(0.25, 1);
        sig = (LPF.ar(MiVerb.ar(sig, 0.9, 1) * 8, 500));
        /*   ds = Decimator.ar(sig, 10000, 2) * 1;
        ds = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
        sig = sig + (ds * 4);*/
        sig * 0.25 * 4;
    }.play.register;
});
~guitareC.stop;
~guitareC = Pbind(
    \instrument, Pseq([\crushedNoHPF, \crushedNoHPF], inf),
    \dur, Pseq([0.75, 1.25] * 4, inf),
    \pitch, 12,
    \color, Pseq([0.8, 0.95] / 2, inf),
    \atk, 0.01,
    \susTime, Pseq([1.5, 0.25] / 1, inf),
    \rel, 0.001,
    \amp, Pseq([1, 3] * 2, inf),
    \out, 0
).play(~nT, quant: [8, -0.4]);
)