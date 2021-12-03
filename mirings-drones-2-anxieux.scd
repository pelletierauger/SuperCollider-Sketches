(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    v.free;
    v =    {
        var f = 29 + 24 - 12;
        // var
        var lfo = SinOsc.kr(0.1).range(0.05, 0.1);
        var lfo2 = SinOsc.kr(0.1).range(0.2, 0.75);
        var lfo3 = SinOsc.kr(0.01).range(0.1, 0.9);
        var trig = Impulse.ar(0.5);
        var freq = EnvGen.ar(Env.step([f, f + 7, f + 12, f + 7].scramble.midicps, [5, 5, 5, 5] / 25, 3, 0));
        var freq2 = EnvGen.ar(Env.step([f, f + 7, f + 12, f + 7].scramble.midicps, [5, 5, 5, 5] / 25, 3, 0));
        var sig = LFSaw.ar(f * 2 * [1.01, 1]) * 0.1;
        sig = sig + (LFSaw.ar(f * 2 * [1, 1.01] * 3.midiratio) * 0.1);
        sig = sig + (LFSaw.ar(f * 2 * [1, 1.001] * 14.midiratio) * lfo);
        sig = sig + (LFSaw.ar(freq * [1, 1.001]) * lfo);
        sig = sig + (LFSaw.ar(freq * [1, 1.001] * 2 * 3.midiratio) * lfo * 4);
        // sig = sig + (LFSaw.ar(55 * [1.001, 1]) * 0.1);

        //var input = PinkNoise.ar(0.2);
        MiRings.ar(sig,
            0,
            // voct: 50,
            pit: 29 + 12,
            struct: 0.15,
            bright: 0.2 + SinOsc.kr(0.1).range(0, 0.1),
            damp: lfo2,
            pos: 0.8,
            // usetrigger: 0,
            bypass: 0, model: 4) * 0.125 * 1;
    }.play;
});
)
v.free;
69.midicps
440 * 0.midiratio