
~path = PathName.new("/Users/guillaumepelletier/Desktop/bonk.aiff");

~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);
Safety(s).disable

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
        var sig = PlayBuf.ar(2, b, 1, startPos: 0, loop: 1);
    sig = sig + MiRings.ar(sig, 0, 24, struct: 0.25, bright: 0.5, damp: 0.7, pos: 0.25, model: 0) * 0.1;
    VadimFilter.ar(sig, 20, 0, 5) * 4;
    // var sig = XPlayBuf.ar(2, b, 0.5, 1, 332950, loop: 1);
}.play;
)


XBufRead
(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
    var trig = Impulse.kr(2);
    var trig3 = trig * Demand.kr(trig, 0, Dseq([0, 1, 1, 1], inf));
    var trig4 = trig * Demand.kr(trig, 0, Dseq([1, 0, 0, 0], inf));
        var sig = XPlayBuf.ar(2, b, 0.5, trigger: trig4, startPos: 0, loop: -1);
        var sig1 = XPlayBuf.ar(2, b, 1, trigger: trig3, startPos: 0, loop: 0);
    var sig2 = MiBraids.ar(
        pitch: 42, timbre: 0.5, color: 0.5, model: 0,
        resamp:0, decim:0, bits:2, ws: 0.5
    );
    sig2 = VadimFilter.ar(sig2, 6000, 0, 1) * Amplitude.ar(sig);
    sig = MiWarps.ar(carrier: sig2!2, modulator: sig * 16, lev1: 0.5, lev2: 0.5,
        algo: 2, timb: 0.2, osc: 0, freq: 110, vgain: 1, easteregg: 0
    ) * 0.2 + (DelayN.ar(sig1, 1, 0.05) * 0.1);
    // VadimFilter.ar(sig, 500, 0, 5);
}.play;
)