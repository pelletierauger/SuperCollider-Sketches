(
~kick.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.3 + (t.beatDur * 0), {
    ~kick = {
        var trig, env, amp, fil, sig;
        trig = Impulse.ar((1 / ~nT.beatDur) * 1);
        fil = SinOsc.ar(0.5!2).range(1, 0);
        env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
        amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.1, 0.9]), trig);
        sig = MiPlaits.ar(42 - 12 - 5,
            engine: 13,
            harm: 0.85,
            timbre: env,
            morph: 0.5,
            trigger: trig,
            usetrigger: 1,
            decay: 0.99,
            lpg_colour: 0,
            mul: 2 * amp * 4);
        sig = sig[0]!2 * 2;
        sig = HPF.ar(sig, 100);
    }.play(fadeTime: 0);
});
)

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~nT.sched(~nT.timeToNextBeat(quant: 4) + 0.3 + (t.beatDur * 0), {
    ~pul2 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36 + 24,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.8,
            lpg_colour: 0,
            mul: 3);
        /*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        // sig = LPF.ar(sig, 10000);
        sig = HPF.ar(sig, 200);
        sig = sig * 0.8;
        sig[1]!2;
    }.play(fadeTime: 0);
});
)