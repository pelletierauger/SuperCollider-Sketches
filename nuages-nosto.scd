(
{
    var t = Impulse.kr(1);
    var e = EnvGen.kr(Env([1, 0, 1], [0.1, 0.9]), t);
    var d = Demand.kr(t, 0, Dwhite(1000, 7000, inf));
    var lfo = SinOsc.kr(0.1).range(0, 5);
    var s = MiBraids.ar(
        pitch: 45, timbre: 0.0 + e * 0.01 * lfo, color: 0.25,
        model: 40, trig: 0, resamp: 2, decim: 10, bits: 4) * 1!2;
    VadimFilter.ar(s, d.lag(1) * 0.2, 0.25, 1);
}.play;
)