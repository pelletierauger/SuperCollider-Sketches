~toMidi.("D4")

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    [~billes3].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes3 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * [1] * 2) * trigGate;
        var trig2 = Impulse.ar(~nT.tempo * 0.125 * 0.25 * 2) * trigGate;
        var dem = Demand.ar(trig, 0, Dseq([0, 1, 2, 2].stutter(8), inf));
        var sig = MiPlaits.ar(62 + 12 + dem,
            engine: 11,
            harm: 0.25,
            timbre: 0.25,
            morph: SinOsc.kr(0.1).range(0.75, 0.8) - 0.1,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 1,
            mul: 1.25)[0];
        // sig = LPF.ar(sig, 2500) * 0.8 * 0.75 * 3;

        sig = sig!2 * 1;
        sig;
    }.play.register;
});
)