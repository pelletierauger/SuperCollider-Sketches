(
~nT.sched(~nT.timeToNextBeat(quant: 2), {

    if(~vibMelo.isPlaying, {~vibMelo.set(\gate, 0, \fadeTime, 0.1)});

    ~vibMelo = {
        | trigGate = 1 |
        var ff = 42;
        var trig = Impulse.ar(~nT.tempo * 1) * trigGate;
        var note = Demand.ar(trig, 0, ff + 0 +
            Dseq([-7, -9, -7, -10].stutter(1), inf)
        + Dseq([0, 0].stutter(8), inf));
        var dem = Demand.ar(trig, 0, Dseq([0.4, 0.5].stutter(1), inf));
        var sig = MiPlaits.ar(note + [0, 0.1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig,
            decay: 0.1,
            lpg_colour: 0,
            mul: 3)[0];
        sig = (sig * 0.15) + MiRings.ar(sig,
            trig: 0,
            pit: note,
            struct: 0.9,
            bright: dem,
            damp: 0.65 - (dem * 0.125),
            pos: 2,
            bypass: 0);
        sig = sig * 0.25;
        sig!2;
    }.play(fadeTime: 0).register;
});
)


(
    [~vibMelo, ~vibra0, ~vibra1].do({|i| if(i.isPlaying,
    {i.set(\trigGate, 0, \gate, 0, \fadeTime, 4)}
)});
)


(
~sched = {
    |synth, clock, |
    a.postln;
    b.postln;
};
)

~sched.("ah", "bee")