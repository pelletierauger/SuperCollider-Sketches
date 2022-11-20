(
~hearCB.free;
~hearCB = {
    var sig = K2A.ar(In.kr(~cb, 2)) * 1;
    sig = sig[0] + sig[1] * 1!2;
    sig = sig + (DelayN.ar(sig, 1, ~nT.beatDur * 0.125) * round(SinOsc.kr(~nT.tempo * 1.5).unipolar));
    sig = VadimFilter.ar(sig, 7000, 0, 1) * 1;
    MiRings.ar(sig,
        pit: 40 + 8 - 12 - 12 + [0, 0.1], struct: 0.75, damp: 0.1, pos: 0.3, model: 1) * 1;
}.play;
)


(
~hearCBD.free;
~hearCBD = {
    var sig = K2A.ar(In.kr(~cb, 2)) * 1;
    sig = sig[0] + sig[1] * 1!2;
    sig = sig + (DelayN.ar(sig, 1, ~nT.beatDur * 0.125) * round(SinOsc.kr(~nT.tempo * 1.5 * 0.5).unipolar));
    sig = VadimFilter.ar(sig, 9000, 0, 5) * 8;
    MiRings.ar(sig, pit: 40 + 8 - 12 + 5, struct: 0.5, damp: 0.1, pos: 0.3, model: 1) * 64 * 4;
}.play;
)
