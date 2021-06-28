~toMidi.("D3"); // 50

(
~nT.sched(~nT.timeToNextBeat(quant: 8), {

    if(~cor.isPlaying, {~cor.set(\trigGate, 0, \gate, 0, \fadeTime, 15)});
    ~cor = {
        | trigGate = 1 |
        var ds;
        var t = Impulse.kr(~nT.tempo / 4) * trigGate;
        var bl = Demand.kr(t, 0, Dseq([1, 1, 1, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 16], [2, -8, 'lin']), t * bl);

        var note0 = Demand.kr(t * bl, 0, Dseq([0, 1, -2], inf));
        var note1 = Demand.kr(t * bl, 0, Dseq([5, 5, 5], inf));
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
    }.play(fadeTime: 0.25).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * [1, 1, 2, 2] * 2) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 0.125 * 0.25 * 2) * trigGate;
        var dem = Demand.ar(trig2, 0, Dseq([0, -5], inf));
        var sig = MiPlaits.ar([62, 62, 59, 59] - 4 + 0 + dem + [0, 0.1, 0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        HPF.ar(sig, 2000) * 0.8 * 0.75;
    }.play.register;

    [~billes2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes2 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * [1, 1, 2, 2] * 2) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 0.125 * 0.25) * trigGate;
        var dem = Demand.ar(trig2, 0, Dseq([0, -5], inf));
        var sig = MiPlaits.ar([62, 62, 59, 59] - 4 + 12 + dem + [0, 0.1, 0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        HPF.ar(sig, 5000) * 0.8 * 0.75;
    }.play.register;
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~cymbal.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~cymbal = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 1 * 0.125) * trigGate;
        var note = Demand.kr(t, 0, Dseq([4, 4] * 32, inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * note], [2, -8, 'lin']), t);

        var note2 = Demand.kr(t, 0, Dseq([0, -5], inf));
        var sig = MiBraids.ar(
            pitch: 30 + 12 + 12 - 12 + note2 + [0, 0.1],
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
        sig * 0.25 * 16 * 4;
    }.play.register;
});
)


(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    f.free;
    f =    {
        var trig = Impulse.kr(~nT.tempo / 4);
        var dem = Demand.kr(trig, 0, Dseq([0, -2].stutter(2), inf));
        var sig = MiPlaits.ar(31 + 24 + 2 + dem,
            engine: 11,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 16);
        sig[0]!2;
    }.play;
    nil;
});
)

(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
~nT.sched(~nT.timeToNextBeat(quant: 2), {

    g.free;
    g =    {
        var trig = Impulse.kr(~nT.tempo / 4);
        var dem = Demand.kr(trig, 0, Dseq([0, -4].stutter(2), inf));

        var sig = MiPlaits.ar(31 + 24 + 2 - 7 + dem,
            engine: 11,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 16);
        sig[0]!2;
    }.play;
    nil;
});
)