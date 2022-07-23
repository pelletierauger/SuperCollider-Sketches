~nT = TempoClock.new(3).permanent_(true);
~nT.tempo;
~nT.tempo = 3;

(
~nT.sched(~nT.timeToNextBeat(quant: 3), {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var t0 = Impulse.kr(~nT.tempo * 1) * trigGate;
        var t = t0 * Demand.kr(t0, 0, Dseq([1, 0, 0, 1, 0, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2;
        sig = LPF.ar(sig, 4400);
        sig * 2 * 1.5;
    }.play;
});

~nT.sched(~nT.timeToNextBeat(quant: 3), {
    ~k2.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k2 = {
        | trigGate = 1 |
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var envGate = EnvGate.new();
        var t0 = Impulse.kr(~nT.tempo * 1) * trigGate;
        var t = t0 * Demand.kr(t0, 0, Dseq([0, 0, 1, 0, 1, 0], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        var note = Demand.kr(t, 0, Dseq([-6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 24 + 12 + Demand.kr(t, 0, Dseq([0, -1].stutter(4), inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6], inf)),
            ws: 1
        );
        var snareFix = EnvGen.kr(Env([0, 0, 1], [~nT.beatDur * 2 - 0.01, 0.01]));
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]))!2 * snareFix;
        sig = VadimFilter.ar(sig, 2400, 0, 5) * 1;
        y = Demand.kr(t0, 0, Dwhite(0.9, 1, inf)).lag(0.1);
        x = SinOsc.kr(~nT.tempo * 1).unipolar * 0.5 + 0.2;
        sig = MiRings.ar(
            sig, pit: 36 + -24 + 2, struct: x, damp: y, bright: 0.5, pos: x, model: 4);
        sig * 2 * 16 * 4 * Line.kr(0, 1, 20);
    }.play;
});
)