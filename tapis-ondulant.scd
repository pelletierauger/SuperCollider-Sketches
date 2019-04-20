play{a = PMOsc;b= SinOsc;d=440; a.ar(b.kr(0.1,d),d/2+b.kr(d*0.01,pi ),1,a.ar(4,2,1,0,a.ar(d*0.01,2,1)),b.kr(0.1)) ! 2}

or you can duplicate any parameter to have a different sound in each side (here with d) :

play{a = PMOsc;b= LFTri;d=440 * [1,1.001]; a.ar(b.kr(0.1,d),d/2+b.kr(d*0.01,pi ),1,a.ar(4,2,1,0,a.ar(d*0.01,2,1)),b.kr(0.1))}



play({ PMOsc.ar(Line.kr(600, 900, 5), 600, 3, 0, 0.1) }); // modulate carfreq

play({ PMOsc.ar(300, Line.kr(600, 900, 5), 3, 0, 0.1) }); // modulate modfreq

{SinOsc.ar(1, mul: 0.5, add:0.5) * 10}.plot(2);
(
// Clean
~f = {
    var modif = 1.midiratio * 0.midiratio;
    var note1 = ~toFreq.(["F1", "F2"].choose) * modif;
    var note2 = ~toFreq.(["F3", "F4"].choose) * 4.midiratio * modif;
    var note3 = ~toFreq.(["F3", "F4"].choose) * 7.midiratio * modif;
    var note4 = ~toFreq.(["F3", "F4"].choose) * 11.midiratio * modif;
    var note5 = ~toFreq.("F3") * 14.midiratio * modif;
    var mu = 1;
    // var mu = {1 + SinOsc.ar(1, mul: 0.5, add:0.5) * 0.015};
    var delay = 0.125 * 4;
    var max = 20;
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
    4;
};
)
(
// Dirty
~f = {
    var modif = 1.midiratio * 12.midiratio;
    var note1 = ~toFreq.(["F1", "F2"].choose) * modif;
    var note2 = ~toFreq.(["F3", "F4"].choose) * 4.midiratio * modif;
    var note3 = ~toFreq.(["F3", "F4"].choose) * 7.midiratio * modif;
    var note4 = ~toFreq.(["F3", "F4"].choose) * 11.midiratio * modif;
    var note5 = ~toFreq.("F3") * 14.midiratio * modif;
    // var mu = 1;
    var mu = {1 + SinOsc.ar(0.1, mul: 0.5, add:0.5) * 0.01};
    var delay = 0.125 * 4;
    var max = 20;
    var fmOsc = LFSaw;
    var t = Routine({
        play({ fmOsc.ar([note1, note1+1], 0, 0.1) * PMOsc.ar([note1, note1+1], note1 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note2, note2+1], note2 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note3, note3+1], note3 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ fmOsc.ar([note4, note4+1] * 1.001, 0, 0.1) * PMOsc.ar([note4, note4+1], note3 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ fmOsc.ar([note5, note5+1] * 1.001, 0, 0.1) * PMOsc.ar([note5, note5+1], note3 * mu, Line.ar(0,max,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
    }).play;
    4;
};
)

r = Pseq([~toFreq.(Pseq(["F#1", "A3", "C#3", "E3", "F#3"], inf))], inf).asStream;

(
~f = {
    var note1 = ~toFreq.(["F#1", "F#2"].choose);
    var note2 = ~toFreq.(["A3", "A4"].choose);
    var note3 = ~toFreq.(["C#3", "C#4"].choose);
    var note4 = ~toFreq.(["E3", "E4"].choose);
    var note5 = ~toFreq.(["F#3, F#4"].choose);
var mu = 1;
        var delay = 0.125;
var t = Routine({
        play({ PMOsc.ar([note1, note1+1], note1 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note2, note2+1], note2 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note3, note3+1], note3 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note4, note4+1], note3 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note5, note5+1], note3 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
    }).play;
4;
};
)


(
~f = {
/*    var note1 = ~toFreq.(["F#1", "F#2"].choose);
    var note2 = ~toFreq.(["B3", "B4"].choose);
    var note3 = ~toFreq.(["C#3", "C#4"].choose);
    var note4 = ~toFreq.(["Eb3", "Eb4"].choose);
    var note5 = ~toFreq.(["F#4, F#5"].choose);*/
        var note1 = ~toFreq.(["F#1"].choose);
    var note2 = ~toFreq.(["B3", "B4"].choose);
    var note3 = ~toFreq.(["C#4", "C#3"].choose);
    var note4 = ~toFreq.(["Eb4"].choose);
    var note5 = ~toFreq.(["F#4"].choose);
var mu = 2;
    var delay = 0.5;
var t = Routine({
        play({ PMOsc.ar([note1, note1+1], note1 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note2, note2+1], note2 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note3, note3+1], note3 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note4, note4+1], note3 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
        delay.wait;
        play({ PMOsc.ar([note5, note5+1], note3 * mu, Line.ar(0,20,8), 0, XLine.ar(0.1,0.0001, 8, 1, 0, 2)) });
    }).play;
4;
};
)

TempoClock.default.sched(0.1, {~f.()});
TempoClock.default.clear;

SinOsc.kr(0.5, 0, 0.5, 1) * 5

(
e = Env.linen(2, 5, 2);
Routine.run({
    loop({
        play({
            LinPan2.ar(EnvGen.ar(e) *
                PMOsc.ar(2000.0.rand,800.0.rand, Line.kr(0.0, 12.0.rand,9),0,0.1), 1.0.rand2)});
        2.wait;
    })
}))