s.boot;
s.quit;
p.pop;
(
t = TempoClock.new;
t.tempo_(50/60);
~guitare = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Signes-Vitaux-3/SuperCollider/0001\ 7-Audio.aif");
SynthDef(\guitare, {
    arg buf = ~guitare, rate = 1, spos = 0, pan = 1, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = PlayBuf.ar(2, ~guitare, rate * BufRateScale.ir(buf), startPos: spos * 7144448);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~dur = PatternProxy(Pn(0.25, inf));
~har = PatternProxy(Pn(0.257, inf));
~loc = PatternProxy(Pn(0, inf));
~shimPos = PatternProxy(Pn(~har - ~loc, inf));
~key = "Db1";
)

(
~intenseListen.free;
~intenseListen = OSCdef.new(
    \intense,
    {
        arg msg, time, addr, port;
        ~dur.source = Pn(msg[1], inf);
    },
    '/intensity'
);
)

(
~harListen.free;
~harListen = OSCdef.new(
    \harmonious,
    {
        arg msg, time, addr, port;
            "receiving har".postln;
            msg[1].postln;
        ~har.source = Pn(msg[1], inf);
    },
    '/har'
);
)

(
~locListen.free;
~locListen = OSCdef.new(
    \locacious,
    {
        arg msg, time, addr, port;
        ~loc.source = Pn(msg[1], inf);
    },
    '/loc'
);
)
(
~keyListen.free;
~keyListen = OSCdef.new(
    \keylistener,
    {
        arg msg, time, addr, port;
//         msg[1].postln;
        ~key = msg[1];
    },
    '/key'
);
)

~har.source = Pn(0.93, inf);
~key;
~har.asStream.next;
~shimPos.asStream.next;
~shimPos.source = Pn(~har - ~loc, inf);

~shimPos = PatternProxy(Pn(0.237, inf));

// Doux shimmer majeur
~shimPos.source = Pn(0.257, inf);
~shimPos.source = Pn(0.257 - 0.004, inf);
// Doux shimmer mineur
~shimPos.source = Pn(0.584, inf);
~shimPos.source = Pn(0.584 - 0.004, inf);


~shimPos.source = Pn(0.252, inf);
~shimPos.source = Pn(0.237, inf);
~shimPos.source = Pn(0.239, inf);
~shimPos.source = Pn(0.795 - 0.015, inf);

~shimPos.source = Pn(0.6775, inf);
0.585 - 0.008;


(
~shimmerC.stop;
~shimmerC = Pbind(
    \instrument, \guitare,
    \dur, 1 / 16,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.034].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \rel, 0.1,
    \atk, 0.7,
    \rate, [1] * -8.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, -8.midiratio,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, Pseq(Pgeom(12, 1.01, 160).asStream.nextN(160).mirror, inf),
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)
Pgeom(12, 1.01, 160).asStream.nextN(160).mirror[318];

(
~shimmerD.stop;
~shimmerD = Pbind(
    \instrument, \guitare,
    \dur, 1 / 16,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.041].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.5),
    \rel, 0.1,
    \atk, 0.7,
    \rate, [1] * -8.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 8 * 1,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)



(
~shimmerE.stop;
~shimmerE = Pbind(
    \instrument, \guitare,
    \dur, 1 / 16,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.055, 0.237 + 0.0535].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 0.5,
    \atk, 0.4,
    \rate, [1] * -8.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 7,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)


(
~shimmerF.stop;
~shimmerF = Pbind(
    \instrument, \guitare,
    \dur, 1,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.0535].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 8,
    \atk, 0.4,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, -12.midiratio,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 20,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)



(
~shimmerG.stop;
~shimmerG = Pbind(
    \instrument, \guitare,
    \dur, 2,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.237 + 0.535].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 6,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, -5].midiratio, inf),
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 20,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)


(
~shimmerH.stop;
~shimmerH = Pbind(
    \instrument, \guitare,
    \dur, 0.125,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.437 + 0.535].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 3,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, 7].midiratio.stutter(20), inf),
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 30,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)



(
~shimmerI.stop;
~shimmerI = Pbind(
    \instrument, \guitare,
    \dur, 0.125,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.437 + 0.4].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 3,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, 7, 0, -2].midiratio.stutter(20), inf),
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 10,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)




(
~shimmerJ.stop;
~shimmerJ = Pbind(
    \instrument, \guitare,
    \dur, 1,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.437 + 0.4].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 3,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, 7, 0, -2].midiratio.stutter(2), inf) * 0.5,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 20,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)


(
~shimmerK.stop;
~shimmerK = Pbind(
    \instrument, \guitare,
    \dur, 1,
    // En La majeur
    // Dmaj7, A, Dmaj7, Cm
    // IV, I, IV, iii
    \spos, Pseq([0.237, 0.2545, 0.237, 0.252].stutter(4 * 16), inf) + Pwhite(0.001, 0.002, inf),
    // \spos, ~har - ~loc + Pwhite(-0.0001, 0.0001, inf),
//     \rel, 1 / 128 * Pseq([Pgeom(0.5, 1.1, 4 * 16)], inf),
    \spos, Pseq([0.437 + 0.2].stutter(40) + 0.0125, inf) + (Pwhite(0.001, 0.002, inf) * 0.15),
    \rel, 3,
    \atk, 1,
    \rate, [1] * -12.midiratio  + Pwhite(0.001, 0.01, inf),
    \rate, 0.midiratio,
    \rate, Pseq([0, 7, 0, -2].midiratio.stutter(2), inf) * 0.5,
    \amp, Pseq([Pgeom(0.5, 1.065, 4 * 16)], inf) * 0.5,
    \amp, 20,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t);
)
20 * 0.125;
FreqScope.new(400, 200, 0, server: s);
FreqScope.scopeOpen;
FreqScope.scope;
~key;
rrand(1.0, 20);

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