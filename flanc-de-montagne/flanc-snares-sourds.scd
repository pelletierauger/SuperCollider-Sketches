c = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0001 7-Audio.aif");

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
    sig = LPF.ar(sig, lpf);
    Out.ar(out, sig);
}).add;
)


~nT = TempoClock.new(1.39).permanent_(true);


// ----------------------------------------------------------
// Les doux bruits qui créent un espace chaud et mystérieux.
// ----------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    x.free;
    x = {
        var t = Impulse.kr(~nT.tempo * 0.25);
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
    }.play;
});
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    y.free;
    y = {
        var t = Impulse.kr(~nT.tempo * 0.25);
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
    }.play;
});
~nT.sched(~nT.timeToNextBeat(quant: 2) + ~nT.beatDur * 1, {
    z.free;
    z = {
        var t = Impulse.kr(~nT.tempo * 0.25);
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
    }.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
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
~nT.sched(~nT.timeToNextBeat(quant: 1), {

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
).play(~nT, quant: [2, -0.2]);
~guitareD.stop;
~guitareD = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 2 / 3,
    \spos, Pseq([90.894], inf),
    \susT, 0.3,
    \amp, Pseq([2, 2] * 2, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
~guitareDB.stop;
~guitareDB = Pbind(
    \instrument, \samplerAbs,
    \buf, c,
    \dur, 1,
    \spos, Pseq([90.894], inf),
    \susT, 0.3,
    \rate, -5.midiratio,
    \amp, Pseq([2, 2] * 2, inf),
    \out, 0
).play(~nT, quant: [2, -0.2]);
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    ~synthLine.free;
    ~synthLine = {
        var t = Impulse.kr(~nT.tempo * 0.25);
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq([0, -3, -2, -5], inf));
        var sig = MiBraids.ar(
            pitch: 60 - 5 - 12 - 7 + note2 + [0, 0.01],
            timbre: 0.9,
            color: 0.1,
            model: 43,
            // trig: t,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        ) * env;
        sig = LPF.ar(sig, 400 + (SinOsc.kr(0.1).unipolar * 400) * [1, 0.75]);
        sig * 0.25 * 1 * [1, 3];
    }.play;
});
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
).play(~nT, quant: [1, -0.2]);
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
        sig * 0.25 * 8;
    }.play;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 1), {
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
        sig = MiBraids.ar(
            pitch: 72 - 24 + -2 + 2,
            timbre: decay * 3,
            color: 0.2,
            model: 34,
            trig: trig * trigGate * block,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 1
        )!2;

        sig = LPF.ar(sig, 2400) * 0.5 * 4;
    }.play(fadeTime: 0.01).register;
});
~nT.sched(~nT.timeToNextBeat(quant: 1) - 0.025, {

    if(~kick.isPlaying, {~kick.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});

    ~kick = {
        | trigGate = 1 |
        var trig, sig, block, decay, timbre, env;
        trig = Impulse.kr(~nT.tempo * 1.5 * 2);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 0], inf));
        decay = Demand.kr(trig, 0, Dseq([0.4, 0.4, 0.7].stutter(2), inf));
        env = EnvGen.kr(Env([0, 1, 0.5, 0], [0.001, 0.1, 2], [2, -8, 'lin']), trig * block * trigGate);

        sig = MiPlaits.ar(2 + 12,
            engine: 9,
            harm: 0.9,
            timbre: 1,
            morph: 0.0 + [0, 0.1],
            trigger: trig * block * trigGate,
            decay: decay + 0.324 + 0.03,
            lpg_colour: 0
        );
        sig = [sig[0][1], sig[1][1]];
        sig = LPF.ar(sig, 1700);
        sig * 0.25 * 4;
    }.play(fadeTime: 0.01).register;
});
)


// ----------------------------------------------------------
// Les billes sur les rayons des roues de vélo.
// ----------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    q.free;
    q = {
        var trig = Impulse.ar(~nT.tempo * 4);
        var sig = MiPlaits.ar(31 + 28 + -1 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.8;
    }.play;
    t.free;
    t =
    {
        var trig = Impulse.ar(~nT.tempo * 8);
        var sig = MiPlaits.ar(28 + 24 + 5 + -2 + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.8;
    }.play;
});
)