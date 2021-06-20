
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * [1, 1, 2, 2]) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 0.125 * 0.25) * trigGate;
        var dem = Demand.ar(trig2, 0, Dseq([0, -5], inf));
        var sig = MiPlaits.ar([62, 62, 59, 59] - 6 + 0 + dem + [0, 0.1, 0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        HPF.ar(sig, 2000) * 0.8 * 3;
    }.play.register;

    [~billes2].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes2 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * [1, 1, 2, 2]) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 0.125 * 0.25) * trigGate;
        var dem = Demand.ar(trig2, 0, Dseq([0, -5], inf));
        var sig = MiPlaits.ar([62, 62, 59, 59] - 6 + 12 + dem + [0, 0.1, 0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        sig = [sig[0] + sig[2], sig[1] + sig[3]];
        HPF.ar(sig, 5000) * 0.8 * 3;
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
        sig * 0.25 * 16 * 2;
    }.play.register;
});
)
