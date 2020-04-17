(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    {
    var lfo = SinOsc.kr(0.1).range(0.05, 0.1);
    var lfo2 = SinOsc.kr(0.1).range(0.2, 0.75);
    var lfo3 = SinOsc.kr(0.01).range(0.1, 0.9);
    var trig = Impulse.ar(1);
    var freq = EnvGen.ar(Env.step([69, 69 + 7, 69 + 12, 69 + 7].midicps, [5, 5, 5, 5] / 50, 3, 0));
    var freq2 = EnvGen.ar(Env.step([69, 69 + 7, 69 + 12, 69 + 7].midicps, [5, 5, 5, 5] / 50, 3, 0));
    var sig = LFSaw.ar(220 * [1.01, 1]) * 0.1;
        sig = sig + (LFSaw.ar(220 * [1, 1.01] * 7.midiratio) * 0.1);
        sig = sig + (LFSaw.ar(220 * [1, 1.001] * 14.midiratio) * lfo);
        sig = sig + (LFSaw.ar(freq * [1, 1.001]) * lfo);
        sig = sig + (LFSaw.ar(freq * [1, 1.001] * 2 * 7.midiratio) * lfo * 4);
        sig = sig + (LFSaw.ar(55 * [1.001, 1]) * 0.1);

	//var input = PinkNoise.ar(0.2);
	(sig * 0.00) + MiRings.ar(sig,
            0,
            voct: 50,
            struct: 0.15,
            bright: 0.2,
            damp: lfo2,
            pos: 0.8,
            usetrigger: 0,
            bypass: 0) * 40;
    }.play;
    nil;
});
)

69.midicps
440 * 0.midiratio