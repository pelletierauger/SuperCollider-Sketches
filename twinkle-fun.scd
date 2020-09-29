~key = "Db0";
rrand(1.0, 20);
~toFreq.(~key)
(
// Clear synth
~twinkleCluster = {
if (~dur.asStream.next > 0.005, {
    var key = ~key;
    var modif = 0.midiratio * 0.midiratio;
    var note1 = ~toFreq.(key) * [0, 12].midiratio.choose * modif;
    var note2 = ~toFreq.(key) * [24, 36].midiratio.choose * 4.midiratio * modif;
    var note3 = ~toFreq.(key) * [24, 36].midiratio.choose * 7.midiratio * modif;
    var note4 = ~toFreq.(key) * [24, 36].midiratio.choose * 11.midiratio * modif;
    var note5 = ~toFreq.(key) * 24.midiratio * 14.midiratio * modif;
//     var mu = 1;
    var mu = [1, 2].wchoose([0.9, 0.1]);
    // var mu = {1 + SinOsc.ar(1, mul: 0.5, add:0.5) * 0.015};
    var delay = 0.125 * 1;
    var max = rrand(1.0, 20);
    var t = Routine({
        play({ PMOsc.ar([note1, note1+1], note1 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note2, note2+1], note2 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note3, note3+1], note3 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note4, note4+1], note3 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note5, note5+1], note3 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
    }).play;
    });
    4;
};
)

(
var note = (~toFreq.(~key) * 12 * (-36 - 5).midiratio)!2 * [1, 1.001];
var max = 120.0;
var dur = 32;
// { PMOsc.ar([note, note + 1], note * 1, Line.ar(0, max, 8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) }.play;
{
    var mod = SinOsc.ar(note * 1) * Line.ar(0, max, dur);
    var car = SinOsc.ar(note, mod % 2pi) * XLine.ar(0.1,0.0001, dur, 1, 0, 2);
    LPF.ar(car, 600) * 8;
    // car;
}.play;
)



(
var note = (~toFreq.(~key) * 12 * (-36 + 24 + -12).midiratio)!2 * [1, 1.001];
var max = 60.0;
var dur = 16;
// { PMOsc.ar([note, note + 1], note * 1, Line.ar(0, max, 8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) }.play;
{
    var op3 = SinOsc.ar(note) * SinOsc.kr(3).range(0.25, 1);
    var op2 = SinOsc.ar(note * 1, op3 % 2pi) * Line.ar(0, max, dur);
    var op1 = SinOsc.ar(note, op2 % 2pi) * XLine.ar(0.1,0.0001, dur, 1, 0, 2);
    LPF.ar(op1, 600) * 8;
    // op1;
}.play;
)
~dur.next;
~f.();

~test = Pkey(~dur).asStream.next.postln;
~test.next.postln;
~test = ~dur.asStream.next.postln;

TempoClock.default.sched(0.1, {~f.()});
TempoClock.default.clear;

(
~twinkleClusters = Task {
{~twinkleCluster.(); 4.wait;}.loop;}.start;
)
~twinkleClusters.stop;