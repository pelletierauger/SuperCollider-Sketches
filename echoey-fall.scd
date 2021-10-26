(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

        z.set(\gate, 0, \fadeTime, 0.1);
z = {
            var envGate = EnvGate.new();
    var t = Impulse.kr(~nT.tempo * 0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.05, 0.1], [-2, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq(
            [0, -2, -5, -4].stutter(2)
        , inf));
        var in = LocalIn.ar(2);
    var sig = MiPlaits.ar(
        pitch: 62 + note + 0 + [0, 0.01],
        engine: 6,
        harm: 0.5,
        timbre: 0.2,
        morph: 0.4
    ) * 0.5 * env;
    sig = MiBraids.ar(42 + note + [0, 0.1], timbre: 0.89, color: 0.5, model: 43) * env;
        // sig = [sig[0][0], sig[1][0]];
        sig = sig + (in * 0.45);
        // sig = CombC.ar(sig, 0.2, ~nT.tempo * 0.25 * 0.5, ~nT.beatDur * 8);
    // sig = LPF.ar(sig, 400) * 2;
    sig = VadimFilter.ar(sig, 3700, 0, 1) * 2;
        LocalOut.ar(DelayC.ar(VAKorg35.ar(sig, SinOsc.kr(0.1).range(500, 1500), 0.5, 0, 1), 1, ~nT.beatDur * 0.5));
        Out.ar(~reverbBus2, sig * 0.2 * envGate);
    Out.ar(0, sig * 2 * envGate);
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

        z.set(\gate, 0, \fadeTime, 0.1);
z = {
            var envGate = EnvGate.new();
    var t = Impulse.kr(~nT.tempo * 1);
    var env = EnvGen.kr(Env([0, 1, 0], [0.02, 0.2], [-8, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq(
        [0, -3, -5, -7, -12, -10, -8, -7] ++
        [0, -3, 4, 2, -12, -10, -8, -7]
        , inf));
    var sig = MiPlaits.ar(
        pitch: 62 + note + 0 + [0, 0.01],
        engine: 0,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = CombC.ar(sig, 0.2, 0.1, 2);
    // sig = LPF.ar(sig, 400) * 2;
    sig = VadimFilter.ar(sig, 700, 0, 1) * 2;
        Out.ar(~reverbBus2, sig * 0.2 * envGate);
    Out.ar(0, sig * 2 * envGate);
}.play;
});
)