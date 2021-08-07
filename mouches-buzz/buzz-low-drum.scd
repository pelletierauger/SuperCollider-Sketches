~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);

(
~lowDrum = {
    // ~nT.sched(~nT.timeToNextBeat(quant: 4), {
    // ~drum = {
    // ~leadSqueak.();

    if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
    ~rim = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo) * trigGate;
        var pat0 = [1, 0, 0, 0, 0, 1, 0, 1];
        var pat1 = [0, 0, 0, 0, 0, 0, 1, 0];
        var pat2 = [1, 1, 1, 1, 0, 0, 1, 0];
        var block0 = Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.ar(trig, 0, Dseq(pat2, inf));
        var dec = Demand.ar(trig, 0, Dseq(0.75!24 ++ (0.75!8), inf));
        // var pit = Demand.ar(trig, 0, Dseq(-12!16 ++ (0!16), inf));
        var dm = Demand.ar(trig * block2, 0, Dseq([0.7, 0.6], inf));
        var pit = max(0, ~pit) * -12;
        var sig = MiPlaits.ar(
            pitch: [ 48, 60, 60, 84 ] - 12 + ~pit + 12 - 12,
            engine: 9,
            harm: 0.4,
            timbre: [0.5, 1, 1, 0.5].rotate(0) * 1.25,
            morph: 0.125 - [0, 0.2, 0, 0],
                    morph: 0.5,
            trigger: trig * [block0, block1, block1, block2] * \Bl.kr(1),
            decay: 0.3 + [0.9, 0.6, 0.6, 0.7] * 0.75,
            lpg_colour: 0
        );
        var envBl = EnvGen.kr(Env([0, 0, 1], [0.5, 0.01]));
        var sig2 = [sig[1][1], sig[2][1]] * 0.75 * envBl;
        sig = [sig[0][1] * 2 + (sig[3][1] * 0.25)]!2 + sig2;
                sig = LPF.ar(sig, 2000);
        // sig = HPF.ar(sig, 4000) * 4;
        // sig = (sig * 0.75) + HPF.ar(sig, 200);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 3.6 * 1.5 * 0.3 * 0.35 * envGate;
        Out.ar(0, sig);
    }.play(fadeTime: 0.01).register;
};
    // ~drum.();
// });
// };
// ~appoDrum.();
)
~rim.set(\Bl, 0);
~rim.set(\Bl, 1);

(
~pit = 1;
~drums = Task {
    {
        ~drum.();
        8.wait;
        ~pit = ~pit * -1;
    }.loop;
}.start(~nT, quant: [4]);
)
~drums.stop;
~pit

(
~drums.stop;
if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
)


(
if(~rim.isPlaying, {~rim.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
~drums.stop;
if(~rimz.isPlaying, {~rimz.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});
[~lead, ~lead2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
[~billes6].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});});
~granulator.set(\trigGate, 0);
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~l.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
if(~crushedNoiseAw.isPlaying, {~crushedNoiseAw.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

)



// ------------------------------------------------------------------
// Nouvelles idées de sons percussifs
// ------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
                | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 2;
    }.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    b.free;
    b = {
        var t = Impulse.kr(~nT.tempo);
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 32], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 60 - 5 - 12,
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 1400 + (SinOsc.kr(0.1).unipolar * 1400));
        sig!2 * 0.25 * 0.5;
    }.play;
});
)

(
~k.set(\gate, 0, \fadeTime, 0.1);
b.set(\gate, 0, \fadeTime, 0.1);

)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~l.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~l = {
                | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 3) * trigGate;
        var block = Demand.kr(t, 0, Dseq([1, 0, 1].rotate(0), inf));
        // var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        // var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.6,
            model: 34,
            trig: t * block,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 0.5 * 1;
    }.play;
});
)


//----!!!!
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
                | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 1;
    }.play;
});
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~l.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~l = {
                | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 3) * trigGate;
        var block = Demand.kr(t, 0, Dseq([1, 0, 1].rotate(0), inf));
        // var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        // var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.6,
            model: 34,
            trig: t * block,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 0.5 * 1;
    }.play;
});
)





(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
                | trigGate = 1 |
        var envGate = EnvGate.new();
        var t = Impulse.kr(~nT.tempo * 0.5) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: Demand.kr(t, 0, Dseq([9, 4, 9, 2] / 10, inf)),
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6, 4], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 1;
    }.play;
});
)