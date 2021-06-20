(
w.set(\gate, 0, \fadeTime, 0.1);
w = {
    var t = Impulse.kr(0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.85, 7 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -10] + 1, inf));
    var sig = PlayBuf.ar(2, ~out.bufnum, rate: (note - 0.75).midiratio, trigger: t);
    // var sig2 = PlayBuf.ar(2, ~out.bufnum, rate: (-4 - 0.75).midiratio, trigger: t);
    // sig = sig + [sig2[1], sig2[0]];
    sig = sig * 0.75 * env;
        sig = LPF.ar(sig, 200 + (17500 * env));
    sig = LPF.ar(sig, SinOsc.ar(0.125).range(400, 18000));
    sig = AnalogTape.ar(
        input: sig,
        bias: 0.85,
        saturation: 0.95,
        drive: 0.85,
        oversample: 4,
        mode: 0
    );
/*    sig = sig + (AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.95,
        bias: 2,
        lowgain: -9.dbamp,
        highgain: -1.dbamp,
        shelvingfreq: 600,
        oversample: 4,
        ) * 0.025);*/
    sig;
}.play;
)