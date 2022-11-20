(
~hearCBD.free;
~hearCBD = {
    var sig = K2A.ar(In.kr(~cb, 2)) * 1;
    var d = Demand.ar(sig, 0, Dwrand([0, 5], [0.9, 0.1], inf));
    var d2 = Demand.ar(sig, 0, Dwrand([1.5, 1], [0.8, 0.2], inf));
    var d3 = Demand.ar(sig, 0, Dwrand([1, 0], [0.9, 0.1], inf));
    var sig2, sig3, algo, pos;
    sig = sig[0] + sig[1] * 1!2 * d3;
    sig = sig + (DelayN.ar(sig, 1, ~nT.beatDur * 0.125) * round(SinOsc.kr(d2).unipolar));
    sig = VadimFilter.ar(sig, 9000, 0, 5) * 8;
    pos = 0.05;
    sig = MiRings.ar(sig, pit: 40 + 8 - 12 + 1 + d, struct: 0.5, damp: 0.2, pos: pos, model: 1) * 64 * 4;
    sig = sig + (MiRings.ar(sig / 64 / 4, pit: 40 + 8 - 12 + 1 + d + 2, struct: 0.5, damp: 0.2, pos: pos, model: 1) * 64 * 4);
    sig = VadimFilter.ar(sig, 1000, 0, 5) * 2;
    algo = 2;
    sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig, 0.75, 0.75, algo: algo, timb: 0.9)[0]);
    sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig, 0.75, 0.75, algo: algo, timb: 0.9)[0]);
    sig = [sig2, sig3] * 0.25;
    sig = VadimFilter.ar(sig, 3000, 0, 1) * 4;
}.play;
)