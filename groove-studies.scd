(
w.free;
w = {
    var beat, trig, env, amp, fil, sig, harm, pitch;
    beat = Impulse.ar(0.82 * 8);
    trig = Demand.ar(beat, 0, Dseq([1, 0, 0, 1, 0, 0, 1, 0], inf));
    harm = Demand.ar(beat, 0, Dseq([2, 0, 0, 1, 0, 0, 1, 0] * 0.5, inf));
    pitch = Demand.ar(beat, 0, Dseq([0, 12].stutter(8), inf));
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
    sig = MiPlaits.ar(
        pitch: 25 + pitch,
        engine: 13,
        harm: harm,
        timbre: 0.15,
        morph: 0.8,
        trigger: trig,
        decay: 0.99,
        lpg_colour: 0
    );
    sig[1]!2 * 4;
}.play;
x.free;
v = Pseries(0, 1/8, 8).asStream.nextN(8);
x = {
    var beat, trig, env, amp, fil, sig, harm, pitch, morph;
    beat = Impulse.ar(0.82 * 2 * 4);
    trig = Demand.ar(beat, 0, Dseq([0, 0, 0, 0, 1, 0, 0, 0], inf));
    morph = Demand.ar(beat, 0, Dseq([2, 2].stutter(4) * 0.5, inf));
    harm = Demand.ar(beat, 0, Dseq([0.1, 0.2].stutter(4), inf));
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
    sig = MiPlaits.ar(
        pitch: 25 + 12,
        engine: 14,
        harm: harm,
        timbre: 0.95,
        morph: morph,
        trigger: trig,
        decay: 0.0199,
        lpg_colour: 0
    );
    sig[1]!2 * 1;
}.play;
)