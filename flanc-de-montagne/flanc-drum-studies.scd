~nT.tempo = 1.39;

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
        sig = sig * 0.75 * 1.2 * 4;
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
            decay: 0.72 + [0, 0.1] - 0.05 - 0.0,
            lpg_colour: 0
        );
        sig = [sig[0][1] * 0 + sig[1][1]]!2;
        sig = HPF.ar(sig, 400);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.75 * 1.2 * 0.5;
    }.play(fadeTime: 0.01).register;
});
)


// --------------------------------------------------------------------------------
// En 6/8.
// --------------------------------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~snare.isPlaying, {~snare.set(\trigGate, 0, \gate, 0, \fadeTime, 7)});

    ~snare = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2 * 1.5);
        var block0 = Demand.ar(trig, 0, Dseq([1, 0, 1, 1, 0, 1], inf));
        var block1 = Demand.ar(trig, 0, Dseq([0, 0, 1, 0, 0, 1], inf));
        var dem = Demand.ar(trig, 0, Dseq([0.1, -0.1].stutter(12), inf));
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
        sig = sig * 0.75 * 1.2 * 4;
    }.play(fadeTime: 0.01).register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 2), {
    if(~snare2.isPlaying, {~snare2.set(\trigGate, 0, \gate, 0, \fadeTime, 7)});

    ~snare2 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 2 * 1.5);
        var block0 = Demand.ar(trig, 0, Dseq([1, 0, 1, 0, 0, 1], inf));
        var block1 = Demand.ar(trig, 0, Dseq([0, 0, 0, 1, 0, 0], inf));
        var dem = Demand.ar(trig, 0, Dseq([0.1, -0.1].stutter(12), inf));
        var sig = MiPlaits.ar(
            pitch: 30 + 0,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: 0.45 - [0, 0.2] + dem,
            trigger: trig * [block0, block1] * trigGate,
            decay: 0.72 + [0, 0.1] - 0.05 - 0.0,
            lpg_colour: 0
        );
        sig = [sig[0][1] * 0 + sig[1][1]]!2;
        sig = HPF.ar(sig, 400);
        // sig = sig + HPF.ar((sig * 100).clip(-1, 1) * 0.05, 5000);
        sig = sig * 0.75 * 1.2 * 0.5 * 3;
    }.play(fadeTime: 0.01).register;
});
)

