(
var freq = 55 * 12.midiratio * [1, 1.01];
~grillon.free;
~grillon = {
    var f = 0.5;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 32;
    var trig = Impulse.ar(f);
    // var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.0625, dec, 2.75 - 0.0625 - dec]), gate: trig);

    var modIndex = Line.ar(1, 2, 120);
    var lfo = SinOsc.ar(0.1).range(0.25, 1.0);
    var op4 = SinOsc.ar(freq * 0.0625 * 0.5) * 4007;
    var op3 = SinOsc.ar(freq * 16) * 4017;
    var op2 = SinOsc.ar(freq * 1, op3 + op4 % 2pi) * lfo * 1;
    var op1 = SinOsc.ar(freq, op2 * modIndex % 2pi);
    var sig = op1 * 0.125 * env;
    // (sig * 0.1) + MiRings2.ar(sig, pit: 15);
    sig * 0.25;
}.play;
)

(
var freq = 55 * 24.midiratio * [1, 1.01];
~grillon2.free;
~grillon2 = {
    var f = 0.25;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 32;
    var trig = Impulse.ar(f);
    // var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.0625, dec, 4.75 - 0.0625 - dec]), gate: trig);

    var modIndex = Line.ar(1, 2, 120);
    var lfo = SinOsc.ar(0.1).range(0.25, 1.0);
    var op4 = SinOsc.ar(freq * 0.125) * 1700;
    var op3 = SinOsc.ar(freq * 2, op4 % 2pi) * 7;
    var op2 = SinOsc.ar(freq * 1, op3 % 2pi) * lfo * 1;
    var op1 = SinOsc.ar(freq, op2 * modIndex % 2pi);
    var sig = op1 * 0.125 * env;
    // (sig * 0.1) + MiRings2.ar(sig, pit: 15);
    sig * 1;
}.play;
)

(
~grillon3.free;
~grillon3 = {
    var f = 0.25;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 32;
    var trig = Impulse.ar(f);
    var dem = Demand.ar(trig, 0, Dseq([0, -2, 0, 2].midiratio, inf));
    var freq = 55 * 36.midiratio * -2.midiratio * dem * [1, 1.01];
    // var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.0625, dec, 4.75 - 0.0625 - dec]), gate: trig);

    var modIndex = Line.ar(1, 2, 120);
    var lfo = SinOsc.ar(0.1).range(0.25, 1.0);
    var op4 = SinOsc.ar(freq * 0.125) * 1700;
    var op3 = SinOsc.ar(freq * 4, op4 % 2pi) * 7;
    var op2 = SinOsc.ar(freq * 2, op3 % 2pi) * lfo * 1;
    var op1 = SinOsc.ar(freq, op2 * modIndex % 2pi);
    var sig = op1 * 0.125 * env;
    // (sig * 0.1) + MiRings2.ar(sig, pit: 15);
    sig * 1;
}.play;
)



// -------------

(
var freq = 55 * 12.midiratio * [1, 1.01];
~grillon.free;
~grillon = {
    var f = 0.25;
    var fr = f.reciprocal;
    var dec = 0.0125 * 0.5 * 32;
    var trig = Impulse.ar(f);
    // var trig2 = Impulse.ar(f * 0.25);
    var env = EnvGen.ar(Env.new([0, 1, 0.125, 0], [0.5, dec, 2.75 - 0.0625 - dec]), gate: trig);

    var modIndex = Line.ar(1, 2, 120);
    var lfo = SinOsc.ar(0.1).range(0.25, 1.0);
    var op4 = SinOsc.ar(freq * 0.0625 * 0.5) * 4007;
    var op3 = SinOsc.ar(freq * 16) * 4017;
    var op2 = SinOsc.ar(freq * 1, op3 + op4 % 2pi) * lfo * 1;
    var op1 = SinOsc.ar(freq, op2 * modIndex % 2pi);
    var sig = op1 * 0.125 * env;
    // (sig * 0.1) + MiRings2.ar(sig, pit: 15);
    (sig * 0.2) + (MiVerb.ar(BPF.ar(sig, 2300) * 1, time: 0.9) * 1);
}.play;
)