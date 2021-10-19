(
[~billes].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

~billes = {
    | trigGate = 1 |
    var trig = Impulse.ar(~nT.tempo * [2, 4]) * trigGate;
    var sig = MiPlaits.ar(
        pitch: [62, 59].stutter(2) + [0, 0.1].wrapExtend(4),
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
        trigger: trig.stutter(2),
        decay: 1,
        lpg_colour: 1
    );
    sig = [sig[0] + sig[2], sig[1] + sig[3]];
    VadimFilter.ar(sig, 2000, 0.25, 5) * 1.6;
}.play.register;
)