~cl = TempoClock.new(1).permanent_(true);






(
~cl.schedAbs(~cl.nextBar, {
x.free;
x = {
    var x = MouseX.kr(0, 1);
    var y = MouseY.kr(0, 1);
    var t = Impulse.kr(~cl.tempo * 4);
    var b = t * Demand.kr(t, 0, Dseq(
        [1, 0, 1, 1, 0, 1, 1, 0] ++
        [1, 0, 0, 1, 0, 0, 1, 0]
        , inf));
    var d = Demand.kr(b, 0, Dseq(Dseries(0, 1, 8), inf));
    var sig = MiBraids.ar(20 + [0, 24],
        timbre: 0.75,
        color: 0.75,
        model: 34,
        trig: b,
        resamp: [2, 0], decim: 10 - d, bits: 2, ws: 0.5 - (d * 0.05));
    var sig2 = sig[0];
    sig = (sig[0] * 1) + (sig[1] * 0.5);
    sig = VadimFilter.ar(sig, 4500, 0, 1) + (sig2 * 0.2);
    sig = sig * 0.2!2;
}.play;
});
)

(
~cl.schedAbs(~cl.nextBar, {
y.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
y = {
    | trigGate = 1 |
    var envGate = EnvGate.new();
    // var cutoff = SinOsc.kr(0.25).range(4000, 2000);
    var t = Impulse.kr(~cl.tempo * 0.25) * trigGate;
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.15, 0.2, 4 - 0.2] * 4, [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, -5, -4], inf));
    var in = MiBraids.ar(60 + note, timbre: 0.5 + (env * 0.5), color: env * 0.2, model: 6);
     var   cutoff = 100 + (2000 * env);
    var sig = VadimFilter.ar(
        input: in,
        type: 1,
        freq: cutoff + 0,
        resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 2 * 0.5 * envGate;
        sig = AnalogPhaser.ar(
            sig,
            SinOsc.ar(0.022),
            skew: SinOsc.kr(5.59),
            feedback: SinOsc.kr(0.005, 1pi).range(0.8,0.85),
            modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
            stages: 1
        );
    sig * 0.125 * 0.5;
    // LPF.ar(in, cutoff)!2;
}.play;
});
)
