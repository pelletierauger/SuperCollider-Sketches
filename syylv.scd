p.use({~melo = {[9, 4, 7, 16, 19, 4, 7, 9].midiratio.reverse.scramble * 0.5}});
p.use({~sylv.free;});
p.use({~sylv.play;});
p.use({~sylv2.free;});
// p.use({~melo[0].postln;});



t.beatDur;
t.beatDur!9;
(
~sylv.free;
~sylv = {
    arg fmFreq = 0.502, gate = 1, atk = 4, rel = 10;
    var fund = 87.31 * 4 * -2.midiratio;
    var levels = Control.names(\levels).kr(([9, 4, 7, 16, 19, 7, 9].scramble ++ 7).midiratio * 0.5);
//     var levels = [9, 4, 7, 16, 19, 4, 7, 9].midiratio.reverse.scramble * 0.5;
    var env = EnvGen.ar(Env(levels, (0.3)!8, curve: \step, loopNode: 0), Impulse.kr(0.1));
    var envRel = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    var envf = EnvGen.ar(Env([0, 4, 0, 1], 0.25!3), Impulse.kr(0.5));
    var envAmp = EnvGen.ar(Env([0, 1, 0], 0.25!2), Impulse.kr(4 * 8 * 2));
    var filFreq = 900 + (SinOsc.ar(0.25, 0, 0.5, 0.5) * 800);
    // envf.plot;
    var sig = SinOsc.ar([fund + 0.1 * env * 0.5, fund * env * 0.5]);
    sig = sig * LFTri.ar(fund * env * fmFreq + envf);
    sig = sig * LFTri.ar(fund * env) * 0.4 * 1.5;
    sig = sig * envAmp * envRel;
    sig = LPF.ar(sig, filFreq);
    Out.ar(0, sig + (GVerb.ar(sig * 0.5)) * 1);
}.play();
)
([0, 1, 2, 3, 4].scramble ++ 3);
s.peakCPU;
~sylv.free;
~sylv.set(\gate, 0);
~sylv.setn(\levels, [9, 4, 7, 16, 19, 4, 7, 9].midiratio.scramble * 0.5 * 1);
~sylv.setn(\levels, ([9, 4, 7, 16, 19, 7, 9].scramble ++ 7).midiratio * 0.5 * 1);
~sylv.setn(\levels, ([9, 4, 7, 16, 19, 7, 9].scramble ++ 7).midiratio * 0.5 * 2);
~arr = {[0, 4, 0, 1] * 1};
~melo = {[9, 4, 7, 16, 19, 4, 7, 9].midiratio.reverse.scramble * 0.5};