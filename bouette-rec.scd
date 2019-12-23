(
b = Buffer.alloc(s, 44100 * 6.0, 2); // a four second 2 channel Buffer;
SynthDef.new(\bouette, {
    arg freq = 440, amp = 1;
    // var op1;
    var f = freq;
    var envRate = f.linlin(0, 800, 2, 0.25);
    var env = EnvGen.kr(Env.new([0, 1, 0.75, 0], [0.01, 0.02, 6] * envRate, [0, 0, -9]), doneAction: 2);
    var env2 = Env.new([0, 1, 0.75, 0], [0.01, 0.02, 2] * envRate, [0, 0, -9]).kr;
    var op5 = SinOsc.ar(f * 8 * [1.01, 1.02]) * 0.25 * (1 - env);
    var op4 = SinOsc.ar(f * 4, op5) * 0.125;
    var op3 = SinOsc.ar(Line.kr(5, 25, 10), op4) * 2 * Line.kr(1, 4, 5);
    var op2 = SinOsc.ar(f * 2, op3) * 2 * env2;
    var op1 = SinOsc.ar(f * [1.001, 1.0], op2) * 0.5 * env;
    var recLine = XLine.kr(400, 1000, 6, doneAction: 2);
    RecordBuf.ar(op1, 0);
    Out.ar(0, op1 * amp);
}).add;
Synth.new(\bouette, [\freq, ~toFreq.("D#3")]);
)

b.bufnum;
b.play;

