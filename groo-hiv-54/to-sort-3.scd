(
var sw = 0.01;
~sPA.stop;
~sPA = Pbind(
    \instrument, \sampler,
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2] / 4, inf),
    \spos, 0,
    \atk, 0.001,
    \susT, 0.6,
    \rel, 0.001,
    \rate, Pseq([-5, -5, -5, -5, -4, -4].midiratio, inf),
    \amp, Pseq([2, 1, 1.5, 1, 1.75, 1.5], inf) * 1.4,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA].stutter(4) ++ [~softPluckB].stutter(2), inf)
).play(~nT, quant: [5, 0]);
~sPC.stop;
~sPC = Pbind(
    \instrument, Pseq([\samplerBeeFlip, \samplerBee], inf),
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2] / 4, inf),
    \spos, 0.047,
    \atk, 0.001,
    \susT, 1.1,
    \rel, 0.001,
    \rate, -2.midiratio,
    \amp, Pseq([2, 1, 2, 1, 2, 1], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
).play(~nT, quant: [5, -0.12]);
)



(
~kick.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2 + (t.beatDur * 0), {
    ~kick = {
        var trig, env, amp, fil, sig;
        trig = Impulse.ar((1 / ~nT.beatDur) * 1);
        fil = SinOsc.ar(0.5!2).range(1, 0);
        env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
        amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
        sig = MiPlaits.ar(42 - 24 - 12,
            engine: 14,
            harm: 1,
            timbre: env,
            morph: 0.9,
            trigger: trig,
            usetrigger: 1,
            decay: 0.6,
            lpg_colour: 0,
            mul: 2 * amp * 4);
        sig = sig[0]!2 * 0.5;
        sig = LPF.ar(sig, 2000);
    }.play(fadeTime: 0);
});
)
