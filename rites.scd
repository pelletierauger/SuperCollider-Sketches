(
x.free;
x = {
    var t = Impulse.kr(4);
    var t2 = Impulse.kr(8);
    var d = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0], inf));
    var d2 = Demand.kr(t, 0, Dseq([10, 12].stutter(16) + \note.kr(0), inf));
    var d3 = t2 * Demand.kr(t2, 0, Dseq([0, 0, 0, 1, 1, 0, 1, 0], inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.001, 1], [0, -8]), t).lag(0.1);
    var sig = MiBraids.ar(~toMidi.("D2"), timbre: 0.95, color: 0.25, model: d2);
    var mix = \mix.kr(0).lag(0.4);
    sig = ~v.(sig, 7000 * e + 1000) * e;
    sig = sig * 0.4 + (MiBraids.ar(~toMidi.("D3"), timbre: 0.95, color: 0.75, model: 34, trig: \kick.kr(0) * d));
    sig = sig * 0.4 + (~v.(MiBraids.ar(~toMidi.("D5"), timbre: 0.125, color: 0.275, model: 33, trig: \drum.kr(0) * d3), 1000, 0, 5));
    sig = VAKorg35.ar(sig, 1000, 0.125, 0.125, 0);
    sig = (sig*mix) + (MiClouds.ar(
        inputArray: sig,       pit: 0,          pos: 0,
        size: 0.125,           dens: 0.0,       tex: \tex.kr(0.5),
        drywet: 0.1,           in_gain: 1,      spread: 1,
        rvb: 1,                fb: 0.75,        freeze: 0,
        mode: 1,               lofi: 0
    ) * (1 - mix));
    // sig ! 2;
}.play;
)

x.set(\tex, 0.25);
x.set(\tex, 0.125);
x.set(\note, 0);
x.set(\note, 9);
x.set(\note, 14);
x.set(\note, 19);
x.set(\mix, 0.25);
x.set(\mix, 1);
x.set(\drum, 1);
x.set(\kick, 1);