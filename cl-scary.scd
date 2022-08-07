
~path2 = PathName.new("/Users/guillaumepelletier/Desktop/bonk.aiff");

~path.pathOnly.openOS

~b2 = Buffer.read(s, ~path2.fullPath);
Safety(s).disable

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
    var trig = Impulse.kr(~cl.tempo);
    var trig3 = trig * Demand.kr(trig, 0, Dseq((1!1) ++ (0!3), inf));
    var delTrig = DelayN.kr(trig, 1, 0.025 + (~cl.beatDur * 0.5));
    var sig = PlayBuf.ar(2, ~b2, 0.5, trigger: trig3, startPos: 0, loop: 0, fadeTime: 0.5);
    var click = (K2A.ar(delTrig) * 0.75!2);
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, ~cl.beatDur - 0.025 * 2], [2, -8, 'lin']), delTrig);
    // MiWarps.ar(carrier: sig, modulator: K2A.ar(e), lev1: 0.5, lev2: 0.5,
    //     algo: 5, timb: 0.25, osc: 0, freq: 110, vgain: 1, easteregg: 0
    // ) * 0.1;
    MiRings.ar(WhiteNoise.ar()!2 * e * 0.01,
        pit: ~toMidi.("A2") + 0, struct: 0.25, bright: 0.5,
        damp: 0.7, pos: 0.25, model: 2
    ) * 2 + (sig * 0.5);
}.play;
)