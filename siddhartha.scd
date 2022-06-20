
~path = PathName.new("/Users/guillaumepelletier/Desktop/noodle.wav");

~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
        var sig = PlayBuf.ar(1, b, 2.midiratio, startPos: 0, loop: 1);
    // var sig = XPlayBuf.ar(2, b, 0.5, 1, 332950, loop: 1);
    // sig.size.poll;
    //     var dens = LFNoise1.kr(0.3).range(0.3, 0.45);

    // sig = sig * 3 + (disto * 0);
    // sig * 1;
    var disto;
    var clean = sig;
    sig = MiVerb.ar(sig * 3) * 2!2;
              disto = AnalogVintageDistortion.ar(
            input: sig!2,
            drivegain: [1, 0.9], bias: [0, 0.6], lowgain: 0.3, highgain: 0.3,
        shelvingfreq: [600, 500], oversample: 0
        ) * 0.25;
    disto = VadimFilter.ar(disto, 3500, 0, 1);
    // sig = clean * 1 + (disto * 0.2);
    // sig.size.poll;
    sig = sig * 0.25 + clean * 0.75;
    // sig * 0.5;
    sig;
}.play;
)


(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    z.free;
    z = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.0625 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([0, 5, 3, 7].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 1, 0], [2, 24], [-8, -8]), gate: t);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.025, inf));
        var note = 40 + 12 + d + ((0..3) * 6 * 0.025);
        var sig = MiBraids.ar(
            pitch: note ++ (note + shift)  ++ (note + shift + 1) - 0.49,
            timbre: 0.9, color: 0.75, model: 37,
            resamp: 0, decim: 16, bits: 3, ws: 0
        );
        sig = VadimFilter.ar(sig, 1500 * e + 200 * 0.5, 0, 1);
        // sig = [sig[0].sum, sig[1].sum];
        // sig.size.poll;
        sig = sig.scramble;
        sig = DelayN.ar(sig, 4, ((1..sig.size).reverse - 1) / 10 * 1);
        sig = Splay.ar(sig);
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        // sig.size.poll;
        sig = sig * Line.kr(0, 1, 1) * 8;
        Out.ar(0, sig * 0.4);
    }.play;
});
)