~nT = TempoClock.new(86.972 / 60 * 2).permanent_(true);

~nT.tempo;
~nT.tempo = 86.972 / 60 * 2;

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums3.isPlaying, {~drums3.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums3 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, a, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4 - 16) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dd = Demand.kr(trig2, 0, Dseq((0.25!1) ++ ([0].stutter(31 - 4 - 16)) ++ (0.25!4), inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([1, 2, 2, 6] * 12) - 0,
            engine: 9,
            harm: 0.75,
            timbre: 1,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - 0.5,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.9, 0.9, dec] * (0.25 + dd),
            lpg_colour: 0.5 + dd.lag(4)
        );
        var kickhat = sig[0][1] * 0 + (sig[3][1] * 0.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 0 * snareFix;
        sig = kickhat!2 + snare;
        sig = (sig * 10).wrap(-1, 1) * (1 - (sig.clip(-0.7, 0.7)));
        sig = VAKorg35.ar(sig, 1000, 0.5, 0.5, 0);
        // sig = Decimator.ar(sig, 1100, 4) * 0.25;
        sig = VadimFilter.ar(sig, 3000, 0, 1) * 0.25 * 0.25;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums3.isPlaying, {~drums3.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums3 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, a, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4 - 16) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dd = Demand.kr(trig2, 0, Dseq((0.25!1) ++ ([0].stutter(31 - 4 - 16)) ++ (0.25!4), inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([6] * 12) - 0,
            engine: 9,
            harm: 0.75,
            timbre: 1,
            morph: 0.45 - [0.4] - 0.5,
            trigger: [block2],
            decay: [dec] * (0.25 + dd),
            lpg_colour: 0.5 + dd.lag(4)
        );
        var kickhat = sig * 0.35;
        // var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        // var snare = [sig[1][1], sig[2][1]] * 0 * snareFix;
        sig = kickhat;
        sig = (sig * 10).wrap(-1, 1) * (1 - (sig.clip(-0.7, 0.7)));
        // sig = VAKorg35.ar(sig, 1000, 0.5, 0.5, 0);
        // sig = Decimator.ar(sig, 1100, 4) * 0.25;
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 0.25 * 0.25!2;
        sig = MiRings.ar(sig,
            pit: ~toMidi.("E1"), struct: 0.25, bright: dd.lag(2) + 0.25,
            model: 4
        ) * 8;
    }.play(fadeTime: 0.01).register;
});
)

~toNote.(76)



(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
~rattle = {
    | note = 0 |
    if(~rattleDrum.isPlaying, {~rattleDrum.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~rattleDrum = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, a, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(16 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dd = Demand.kr(trig2, 0, Dseq((0.25!1) ++ ([0].stutter(31 - 4 - 16)) ++ (0.25!4), inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([6] * 12) - 0,
            engine: 9,
            harm: 0.75,
            timbre: 1,
            morph: 0.45 - [0.4] - 0.5,
            trigger: [block2],
            decay: [dec] * (0.25 + dd),
            lpg_colour: 0.5 + dd.lag(4)
        );
        var kickhat = sig * 0.35;
        // var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        // var snare = [sig[1][1], sig[2][1]] * 0 * snareFix;
        sig = kickhat;
        sig = (sig * 10).wrap(-1, 1) * (1 - (sig.clip(-0.7, 0.7)));
        // sig = VAKorg35.ar(sig, 1000, 0.5, 0.5, 0);
        // sig = Decimator.ar(sig, 1100, 4) * 0.25;
        sig = VadimFilter.ar(sig, 1000, 0, 1) * 0.25 * 0.25!2;
        sig = MiRings.ar(sig,
            pit: ~toMidi.("E1") + note, struct: 0.25, bright: dd.lag(2) + 0.25,
            model: 4
        ) * 8;
    }.play(fadeTime: 0.01).register;
};
)

~rattle.()

(
~rattleTask = Task {
    var note = Pseq([0, -5], inf).asStream;
    var w = Pseq([16, 16], inf).asStream;
    {
        ~rattle.(note.next);
        w.next.wait;
    }.loop;
}.start(~nT, quant: [8]);
)
~rattleTask.stop;


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    y.set(\gate, 0, \fadeTime, 0.1);
    // if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    if(~drums3.isPlaying, {~drums3.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums3 = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 2) * trigGate;
        var a = Demand.kr(trig, 0, Dseq([0, 0, 0, 1].stutter(16), inf));
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, a, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, a, a] ++ [0, 0, 0, 0, 1, 1, 0, 0];
        var pat2 = ([1, 0, 1, 0].wrapExtend(32 - 4 - 16 - 4) ++ [1, 1, 1, 1, 1, 1, 1, 1]);
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var dd = Demand.kr(trig2, 0, Dseq((0.25!1) ++ ([0].stutter(31 - 4 - 16 - 8)) ++ (0.25!4), inf));
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8], inf));
        var sig = MiPlaits.ar(
            pitch: 28 + ([9, 9] * 12) - 0,
            engine: 9,
            harm: 0.75,
            timbre: 1,
            morph: 0.45 - [0.4] - 0.25,
            trigger: [block2],
            decay: [dec] * (0.25 + dd) * 0.85,
            lpg_colour: 0.5 + dd.lag(4)
        );
        var kickhat = sig * 0.35;
        // var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        // var snare = [sig[1][1], sig[2][1]] * 0 * snareFix;
        sig = kickhat;
        sig = (sig * 10).wrap(-1, 1) * (1 - (sig.clip(-0.7, 0.7)));
        // sig = VAKorg35.ar(sig, 1000, 0.5, 0.5, 0);
        // sig = Decimator.ar(sig, 1100, 4) * 0.25;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.25 * 0.25;
        sig = MiRings.ar(sig,
            pit: ~toMidi.("A3") + 7,
            struct: 0.25,
            bright: (dd.lag(2) * 0.25) + 0.125, damp: 0.075, pos: 0,

            model: 2
        ) * 4 * 8 * 8;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~drums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var d5 = Demand.kr(trig, 0, Dseq(Dseries(0, 1/64, 32), inf)).lag(0);
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var dec2 = Demand.kr(trig, 0, Dseq([0, -2].stutter(32), inf));
        var lin = EnvGen.kr(Env.circle([0.4, 0.3], [~nT.beatDur * 16, 0]));
        var sig = MiPlaits.ar(
            pitch: 28 + [0, 12, 12, 36 + 7] + -12 + 12,
            engine: 5,
            harm: 0.5 - lin,
            timbre: [1, 1, 0.8, 1] - 0.5,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - lin,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.8, 0.8, dec] * 0.75,
            lpg_colour: [0, 0.75, 0.75, 0],
            // morph_mod: d5 * -1
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 0.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.35 * 0.5;
    }.play(fadeTime: 0.01).register;
});
)




(
~drummy = {
    | note = 0|
    if(~wtDrums.isPlaying, {~wtDrums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~wtDrums = {
        | trigGate = 1 |
        var trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        var trig2 = Impulse.kr(~nT.tempo * 4) * trigGate;
        //          |     ;     |     ;         |     ;     |     ;
        var pat0 = [1, 0, 0, 0, 0, 0, 1, 0] ++ [0, 0, 1, 0, 0, 0, 0, 0];
        var pat1 = [0, 0, 0, 0, 1, 0, 0, 0] ++ [0, 0, 0, 0, 1, 0, 0, 0];
        var pat2 = [1, 0, 1, 0].wrapExtend(32 - 4) ++ [1, 1, 1, 1];
        var block0 = trig * Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.kr(trig2, 0, Dseq(pat2, inf));
        var d5 = Demand.kr(trig, 0, Dseq(Dseries(0, 1/64, 32), inf)).lag(0);
        var dec = Demand.kr(trig, 0, Dseq([0.7, 0.8] + 0.1, inf));
        var dec2 = Demand.kr(trig, 0, Dseq([0, -2].stutter(32), inf));
        var lin = EnvGen.kr(Env.circle([0.4, 0.3], [~nT.beatDur * 16, 0]));
        var sig = MiPlaits.ar(
            pitch: 28 + [0, 12, 12, 36 + 7] + -12 + 12 + note,
            engine: 5,
            harm: 0.5 - lin,
            timbre: [1, 1, 0.8, 1] - 0.5,
            morph: 0.45 - [0, 0.2, 0.1, 0.4] - lin,
            trigger: [block0, block1, block1, block2],
            decay: [0.9, 0.8, 0.8, dec] * 0.75,
            lpg_colour: [0, 0.75, 0.75, 0],
            // morph_mod: d5 * -1
        );
        var kickhat = sig[0][1] * 4 + (sig[3][1] * 0.35);
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        var snare = [sig[1][1], sig[2][1]] * 3 * snareFix;
        sig = kickhat!2 + snare;
        // sig = Decimator.ar(sig, 8100 * 2, 8) * 0.5;
        sig = VadimFilter.ar(sig, 7000, 0, 1) * 0.35 * 1;
    }.play(fadeTime: 0.01).register;
};
)



(
~drumTask.stop;
~drumTask = Task {
    var note = Pseq([0, -5], inf).asStream;
    var w = Pseq([16, 16], inf).asStream;
    if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    {
        ~drummy.(note.next);
        w.next.wait;
    }.loop;
}.start(~nT, quant: [8]);
)


(
~rattleTask.stop;
if(~rattleDrum.isPlaying, {~rattleDrum.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
if(~drums3.isPlaying, {~drums3.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
if(~drums2.isPlaying, {~drums2.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
if(~drums.isPlaying, {~drums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
~drumTask.stop;
if(~wtDrums.isPlaying, {~wtDrums.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
)
