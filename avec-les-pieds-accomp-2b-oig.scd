(
g.free;
g = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(0.125!2 * 1.5);
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 1, 0], [1, 4]), trig);
    sig = MiPlaits.ar(
        pitch: 45,
        engine: 14,
        harm: 0.0,
        timbre: 0.4,
        morph: 0.95,
        trigger: trig,
        decay: 0.9,
        lpg_colour: 0
        ) * amp;
    HPF.ar(sig[0]!2, 800) * 16 * 8 * SinOsc.ar(6).range(0.5, 1);
}.play;
)


(
h.free;
h = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(0.125!2 * 1.5);
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 1, 0], [1, 4]), trig);
    sig = MiPlaits.ar(25 + 12 + 12 + 12 - 5 - 12 - 5 + 12 - 5,
        engine: 14,
        harm: 0,
        timbre: 0.4,
        morph: 0.95,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.4,
        lpg_colour: 0,
        mul: 2) * amp;
    HPF.ar(sig[0]!2, 800) * 4 * 16 * SinOsc.ar(12).range(0.5, 1);
}.play;
)

s.record;
s.stopRecording;