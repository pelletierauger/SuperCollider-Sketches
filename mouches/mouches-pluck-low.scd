~toMidi.("D4")

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes3].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes3 = {
        | trigGate = 1 |
        var tempo = ~nT.tempo * 2;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(swungTempo * [1] * 1) * trigGate;
        var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig, 0, Dseq([0, 1, 2, 2].stutter(8), inf));
        var sig = MiPlaits.ar(62 + 12 - 24 + dem,
            engine: 11,
            harm: 0.95,
            timbre: 0.25,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            trigger: trig * Demand.ar(trig, 0, Dseq(
                (1!9 ++ (0!7)), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25)[0];
        // sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;

        sig = sig!2 * 1;
        // sig;
                Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005));

    }.play.register;

    [~billes4].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes4 = {
        | trigGate = 1 |
        var tempo = ~nT.tempo * 1;
        var basePulse = Impulse.ar(tempo) * trigGate;
        var swing = [2, 4] / 3;
        var swungTempo = Demand.ar(basePulse, 0, Dseq(swing * tempo, inf));
        var trig = Impulse.ar(tempo * [3] * 1) * trigGate;
        var block = Demand.ar(trig, 0, Dseq([1, 1, 0], inf));
        // var trig2 = Impulse.ar(swungTempo * 0.125 * 0.25 * 1) * trigGate;
        var dem = Demand.ar(trig * block, 0, Dseq([0, -2, -5, -5].stutter(8), inf));
        var sig = MiPlaits.ar(62 + 12 - 5 - 24 + dem + [0.1, 0],
            engine: 11,
            harm: 0.95,
            timbre: 0.125,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
    trigger: trig * block * Demand.ar(trig, 0, Dseq(1!13 ++ (0!11), inf)),
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25
        );
        sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;

        sig = sig * 1;
        // sig;
                Out.ar(~bu, sig * XLine.ar(0.001, 1, 0.005));

    }.play.register;
});
)

(
[~rim, ~billes3, ~billes4].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise1.set(\relGate, 1, \gate, 0, \fadeTime, 15);
~crushedNoise2.set(\relGate, 1, \gate, 0, \fadeTime, 15);
)