
~path = PathName("/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0001 7-Audio.aif");
c = Buffer.read(s, ~path.fullPath);


~path.pathOnly.openOS;
"/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/".openOS

(
SynthDef(\samplerAbs, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
SynthDef(\samplerAbsLPF, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0, lpf = 4000;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufSampleRate.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    sig = VadimFilter.ar(sig, lpf, 0, 1);
    Out.ar(out, sig);
}).add;
)


~nT = TempoClock.new(1.39).permanent_(true);
~nT.tempo = 1.39;
~nT.tempo = 1.2;
~nT.tempo = 1.1;

// -----------------------------------------------------------------------
// Les doux bruits qui créent un espace chaud et mystérieux.
// -----------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~douxBruit0.isPlaying, {~douxBruit0.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~douxBruit0 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 36,
            timbre: 0.5,
            color: 0.7 + [0, 0.01],
            model: 42,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        ) * env;
        sig * 0.25;
    }.play.register;
});
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~douxBruit1.isPlaying, {~douxBruit1.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~douxBruit1 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 36 + 12 + 12,
            timbre: 0.5,
            color: 0.7 + [0, 0.01],
            model: 42,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig * 0.125;
    }.play.register;
});
~nT.sched(~nT.timeToNextBeat(quant: 2) + ~nT.beatDur * 1, {
    if(~douxBruit2.isPlaying, {~douxBruit2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
    ~douxBruit2 = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.25) * trigGate;
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2 - 0.2].reverse, [2, 'lin', 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10] + 2, inf));
        var sig = MiBraids.ar(
            pitch: 36 + 12 + 12 + 2,
            timbre: 0.5,
            color: 0.7 + [0, 0.01],
            model: 42,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig * 0.125;
    }.play.register;
});
)

[~douxBruit0, ~douxBruit1, ~douxBruit2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 10)});});


// -----------------------------------------------------------------------
// Les percussions, 3 dans les mains, 2 dans les pieds.
// -----------------------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 6), {
    if(~kick2.isPlaying, {~kick2.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block, decay;
        trig = Impulse.kr(~nT.tempo * 4);
        block = Demand.kr(trig, 0, Dseq([
            1, 0, 0, 0,
            1, 0, 0, 0,
            // 1, 0, 1, 0,
            // 0, 0, 1, 0
        ], inf));
        decay = Demand.kr(trig * block, 0, Dseq([
            0.2, 0.2, 0.2, 0.3//, 0.2
        ].stutter(1), inf));
        sig = MiPlaits.ar(2 + 12,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: 0.0 + [0, 0.1],
            trigger: trig * block * trigGate,
            decay: decay + 0.635,
            lpg_colour: 0
        );
        sig = [sig[0][1], sig[1][1]];
        sig = LPF.ar(sig, 1800) * 0.5 * 4 * 1;
    }.play(fadeTime: 0.01).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 6), {

    if(~kick.isPlaying, {~kick.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block, decay, timbre;
        trig = Impulse.kr(~nT.tempo * 1.5 * 2);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 0], inf));
        timbre = Demand.kr(trig, 0, Dseq([0.4, 0.4, 0.7].stutter(2), inf));

        sig = MiBraids.ar(
            pitch: 72 - 24 + -2 + 2,
            timbre: timbre,
            color: 0.2,
            model: 34,
            trig: trig * trigGate * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        );
        sig = LPF.ar(sig, 1700);
        sig!2 * 0.25 * 8 * 2;
    }.play(fadeTime: 0.01).register;
});
)


// ----------------------------------------------------------
// Guitares et synthés qui s'ajoutent aux doux bruits.
// ----------------------------------------------------------


(
~guitareC.stop;
~guitareC = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 1,
    \spos, Pseq([88.802, 91.203], inf),
    \susT, 1,
    \rate, 0.5,
    \amp, Pseq([2, 2] * 4, inf),
    \out, 0
).play(~nT, quant: [6, -0.2]);
)

(
var o = \rest;
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 1 / 3,
    \spos, Pseq([89.977, 90.3, 90.9, 91.212], inf),
    \rate, Pseq(([0, 0, 0, -1] - 12).midiratio, inf),
    \susT, Pseq([0.3, 0.8] * 12.midiratio, inf),
    \amp, Pseq([
        1, o, 1, o, 1, o,
        o, o, 1, o, 1, 1
    ] * 1.5 * 3 * 0.5, inf),
    \out, 0
).play(~nT, quant: [3, -0.2]);
~guitareDB.stop;
~guitareDB = Pbind(
    \instrument, \samplerAbsLPF,
    \buf, c,
    \dur, 1,
    \spos, Pseq([90.894], inf),
    \susT, 0.3,
    \rate, -9.midiratio,
    \amp, Pseq([2, 2] * 1, inf),
    \lpf, 8000,
    \out, 0
).play(~nT, quant: [3, -0.2]);
)



(
~guitareE.stop;
~guitareE = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, Pseq([Rest(0.75), 1.25], inf),
    \spos, Pseq([8.489, 16.986].stutter(2), inf),
    \rate, 0.midiratio,
    \susT, 3,
    \amp, Pseq([2, 2] * 2, inf),
    \out, 0
).play(~nT, quant: [6, -0.2]);
)



(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
    d.free;
    d = {
        var t = Impulse.kr(~nT.tempo * 2 * 0.125);
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq([0, -5], inf));
        var sig = MiBraids.ar(
            pitch: 36 + 12 + 12 - 12 + note2 + [0, 0.1],
            timbre: 0.9 + [-0.05, 0.05],
            color: 0.2,
            model: 35,
            trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 400 + (SinOsc.kr(0.1).unipolar * 400));
        sig * 0.25 * 1;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 3), {
    if(~kick2.isPlaying, {~kick2.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~kick2 = {
        | trigGate = 1 |
        var trig, sig, block, decay;
        trig = Impulse.kr(~nT.tempo * 4) * trigGate;
        block = Demand.kr(trig, 0, Dseq([
            1, 0, 1, 0,
            1, 0, 0, 0,
            // 1, 0, 1, 0,
            // 0, 0, 1, 0
        ], inf));
        decay = Demand.kr(trig * block, 0, Dseq([
            0.2, 0.2, 0.2, 0.3//, 0.2
        ].stutter(1), inf));
        sig = MiBraids.ar(
            pitch: 72 - 24 + -2 + 2,
            timbre: decay * 3,
            color: 0.2,
            model: 34,
            trig: trig * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        )!2;

        sig = LPF.ar(sig, 2400) * 0.5 * 2;
    }.play(fadeTime: 0.01).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 3) - 0.025, {

    if(~kick.isPlaying, {~kick.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block, decay, timbre, env;
        trig = Impulse.kr(~nT.tempo * 3);
        block = Demand.kr(trig, 0, Dseq(
            [1, 0, 1, 0, 1, 0] ++ [0, 0, 1, 0, 1, 1], inf));
        decay = Demand.kr(trig * block, 0, Dseq(
            [0.4, 0.4, 0.7] ++ [0.4, 0.7, 0.7], inf));
        env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.001, 0.05, 0.1], [2, -8, 'lin']), trig * block * trigGate);

        sig = MiPlaits.ar(2 + 12,
            engine: 9,
            harm: 0.9,
            timbre: 0.5,
            morph: 0.15 + [0, 0.1],
            trigger: trig * block * trigGate,
            decay: decay + 0.1 + 0.0,
            lpg_colour: 0
        );
        sig = [sig[0][1], sig[1][1]];
        sig = LPF.ar(sig, 5700);
        sig * 0.5 * 1;
    }.play(fadeTime: 0.01).register;
});
)


// ----------------------------------------------------------
// Le vibraphone.
// ----------------------------------------------------------



(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~nT.sched(~nT.timeToNextBeat(quant: 6) - (~nT.beatDur / 2), {
    [~vibra0].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
    ~vibra0 = {
        | trigGate = 1 |
        var trig = Impulse.ar(1 / (~nT.beatDur * 4)) * trigGate;
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5, -2, 3].stutter(1), inf));
        var note2 = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5].stutter(1), inf));
        var sig = MiPlaits.ar(note + [0, 0.1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = (sig * 0.15) + MiRings.ar(sig,
            trig: 0,
            pit: note,
            struct: 0.9,
            bright: 0.4 - ((note2 - ff - 12) * 0.2 * 0.5),
            damp: 0.65 + ((note2 - ff - 12) * 0.2 * 0.25),
            pos: 2,
            bypass: 0);
        sig = sig * 0.125 * 0.5;
    }.play(fadeTime: 0).register;
});

~nT.sched(~nT.timeToNextBeat(quant: 6) - (~nT.beatDur / 2), {
    ~vibra1.set(\gate, 0, \fadeTime, 0.5);
    ~vibra1 = {
        | trigGate = 1 |
        var trig = Impulse.ar(1 / (~nT.beatDur * 4)) * trigGate;
        var note = Demand.ar(trig, 0, 30 + 12 + Dseq([0, -5, -2, -7].stutter(1), inf));
        var sig = MiPlaits.ar(note + [0, 0.1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = (sig * 0.15) + MiRings.ar(sig,
            trig: 0,
            pit: note - 12,
            struct: 0.9,
            bright: 0.4,
            damp: 0.65,
            pos: 2,
            bypass: 0);
        sig = sig * 0.125;
    }.play(fadeTime: 0.01).register;
});
)




// ----------------------------------------------------------
// Les billes sur les rayons des roues de vélo.
// ----------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 6), {

    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes0 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var sig = MiPlaits.ar(31 + 28 + -1 + 4 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.2;
    }.play.register;

   ~billes1 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 8) * trigGate;
        var sig = MiPlaits.ar(28 + 24 + 5 + -2 + 4 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.1;
    }.play.register;
});
)