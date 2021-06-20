~buf.play;
~buf.numChannels

(  // algo:2 -- analog RM with internal osc (tri)
{
    var timb = SinOsc.kr(0.1).range(0, 1);
    var in = PlayBuf.ar(2, ~buf.bufnum, loop: 1) * 14;
    var out = MiWarps.ar(0, in, lev1: 0.1, lev2: 0.1, algo: 4, timb: timb, osc: 1, freq: 220);
    out[0]!2 * 0.5 * 0.1;
}.play;
)

MiRings

(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    var in = PlayBuf.ar(2, ~buf.bufnum, rate: 1, loop: 1) * 15;
    MiRings.ar(
        in: in,
        pit: 60,
        struct: 0.95,
        bright: 0.5,
        damp: 0.5,
        pos: 0.1,
        model: 5,
        poly: 1,
        intern_exciter: 0,
        easteregg: 0
    );
}.play;
)