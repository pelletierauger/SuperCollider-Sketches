(
var freq = 55 * 12.midiratio * [1, 1.01];
~grillons.free;
~grillons = {
    var f = 4;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 3;
    var trig = Impulse.ar(f);
    // var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.005, dec, 0.15 - 0.0625 - dec]), gate: trig);

    var dem = Demand.ar(trig, 0, Dseq([1, 2, 4, 8], inf));
    var modIndex = Line.ar(1, 2, 120);
    var lfo = SinOsc.ar(0.1).range(0.25, 1.0);
    var op4 = SinOsc.ar(freq * 0.5 * 4 * dem) * 70;
    var op3 = SinOsc.ar(freq * 2) * 17;
    var op2 = SinOsc.ar(freq * 16, op3 + op4 % 2pi) * lfo * 1;
    var op1 = SinOsc.ar(freq, op2 * modIndex % 2pi);
    var sig = op1 * 0.125 * env;
    // (sig * 0.1) + MiRings2.ar(sig, pit: 15);
    sig * 0.5;
}.play;
)

(
var freq = 55 * 12.midiratio * [1, 1.01];
~grillons2.free;
~grillons2 = {
    var f = 2;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 3;
    var trig = Impulse.ar(f);
    // var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.005, dec, 0.15 - 0.0625 - dec]), gate: trig);

    var dem = Demand.ar(trig, 0, Dseq(Pgeom(1, 2, 8).asStream.nextN(8), inf));
    var modIndex = Line.ar(1, 2, 120) * 0 + 0.9;
    var lfo = SinOsc.ar(0.1).range(0.25, 1.0);
    var op4 = SinOsc.ar(freq * 4 * 1 * dem) * 700;
    var op3 = SinOsc.ar(freq * 16) * 170;
    var op2 = SinOsc.ar(freq * 1, op3 + op4 % 2pi) * lfo * 1;
    var op1 = SinOsc.ar(freq, op2 * modIndex % 2pi);
    var sig = op1 * 0.125 * env;
    (sig * 0.1) + MiRings2.ar(sig, pit: freq * 0.25);
    // sig * 0.5;
}.play;
)