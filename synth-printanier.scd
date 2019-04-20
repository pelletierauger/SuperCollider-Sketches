s.boot;


(
SynthDef.new(\fm, {
    arg out, freq = 220, lon = 3, amp = 1, pan = 0, atk = 0.02, rel = 20, ti = #[1, 10];
    var carrier, modulator, modulator2, modulator3, env, lin, lin2, lin3, lin4, lin5;
    freq = max(min(freq, 3520.00), 50);
    env = EnvGen.kr(Env.new([0, 1, 0.0001], [atk, rel], [\linear, \exponential]), doneAction: 2);
    carrier = LFSaw.ar([freq, freq + 0.1]) * 0.1;
    lin2 = XLine.kr(1.9, 4.001, 0.5);
    lin2 = 4;
    modulator = LFSaw.ar([freq * lin2, freq + 1 * lin2]) * 1;
    modulator2 = LFTri.ar([freq + 1 * 2.001, freq * 2.001]) * 1;
    modulator3 = LFTri.ar([freq + 1 * 4.001, freq * 4.001]) * 1;
    lin = XLine.kr(0.1, 1, 0.5);
    carrier = (carrier) + (carrier * modulator * lin);
    lin4 = XLine.kr(0.0001, 1, ti[0]);
    lin5 = XLine.kr(1, 0.0001, ti[1]);


    carrier = (carrier * modulator2 * modulator * lin5) + (carrier * modulator3 * modulator * lin4);
    carrier = carrier * env * amp;
    carrier = Balance2.ar(carrier[0], carrier[1], pan, 1);
    // lin2 = ;
    carrier = LPF.ar(carrier, XLine.kr(700, 10000, 7));
    Out.ar(out, carrier);
}).add;
)
440 * 52.midiratio;
Synth.new(\fm, [\freq, 440 * 52.midiratio, \amp, 8, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);

(
Synth.new(\fm, [\freq, 220 * 0.midiratio, \amp, 2, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\fm, [\freq, 220 * 2.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\fm, [\freq, 220 * 4.midiratio, \amp, 2, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\fm, [\freq, 220 * 7.midiratio, \amp, 1, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

(
Synth.new(\fm, [\freq, ~toFreq.("A1") * 0.midiratio, \amp, 1, \out, 0, \pan, rrand(-1.0, 1.0)]);
// Synth.new(\fm, [\freq, ~toFreq.("A3") * 14.midiratio, \amp, 1, \out, 0, \pan, rrand(-1.0, 1.0)]);
Synth.new(\fm, [\freq, ~toFreq.("A3") * 11.midiratio, \amp, 1, \out, 0, \pan, rrand(-1.0, 1.0)]);
Synth.new(\fm, [\freq, ~toFreq.("A3") * 4.midiratio, \amp, 2, \out, 0, \pan, rrand(-1.0, 1.0)]);
Synth.new(\fm, [\freq, ~toFreq.("A2") * 0.midiratio, \amp, 2, \out, 0, \pan, rrand(-1.0, 1.0)]);
Synth.new(\fm, [\freq, ~toFreq.("A2") * 7.midiratio, \amp, 1, \out, 0, \pan, rrand(-1.0, 1.0)]);
Synth.new(\fm, [\freq, ~toFreq.("A3") * 7.midiratio, \amp, 2, \out, 0, \pan, rrand(-1.0, 1.0)]);)

(
~synthy.stop;
~synthy = Pbind(\instrument, \fm,
    \dur, 3,
    \freq, 220 * Pseq([[0, 2, 4, 7], [0, 2, 5, 7], [-2, 2, 5, 7], [-3, 2, 4, 7]].midiratio, inf) * [1, 2] * 0.midiratio,
    \amp, 3,
    \rel, 10,
    \out, 0,
    \atk, 0.05,
    \pan, Pwhite(-0.75, 0.75, inf)
).play();
)

[0.01].stutter(3) ++ 3;
(
~synthy.stop;
~synthy = Pbind(\instrument, \fm,
    \dur, Pseq([0.01].stutter(3) ++ 3 - (0.01 * 3), inf),
    \freq, 220 * Pseq([
        0, 2, 4, 7,
        0, 2, 5, 7,
        -2, 2, 5, 7,
        -3, 2, 4, 7
    ].midiratio, inf) * [1, 2] * -2.midiratio,
    \amp, 3,
    \rel, 10,
    \out, 0,
    \atk, 0.05,
    \pan, Pwhite(-0.75, 0.75, inf)
).play();
)




(
~synthy.stop;
~synthy = Pbind(\instrument, \fm,
    \dur, Pseq([0.025].stutter(3) ++ 3 - (0.025 * 3), inf),
    \freq, 220 * Pseq([
        0, 2, 4, 7,
        0, 2, 5, 7,
        -2, 2, 5, 7,
        -3, 2, 4, 7
    ].midiratio, inf) * [1, 2] * 0.midiratio,
    \amp, 3,
    \rel, 10,
    \ti, Pseq([[1, 10], [0.8, 10]].stutter(4), inf),
    \out, 0,
    \atk, 0.05,
    \pan, Pwhite(-0.75, 0.75, inf)
).play();
)


(
~synthy.stop;
~synthy = Pbind(\instrument, \fm,
    \arp, Pseq([Pgeom(0.01, 1.2, 4)], inf).stutter(4),
    // \dur, Pseq([Pkey(\arp)].stutter(3) ++ 3 - (Pkey(\arp) * 3), inf),
    \dur, Pseq([Pkey(\arp)], inf) * 20,
    \freq, 220 * Pseq([
        0, 2, 4, 7,
        0, 2, 5, 7,
        -2, 2, 5, 7,
        -3, 2, 4, 7
    ].midiratio, inf) * [1, 2] * 0.midiratio,
    \amp, 3,
    \rel, 10,
    \out, 0,
    \atk, 0.05,
    \pan, Pwhite(-0.75, 0.75, inf)
).play();
)


Pseq([Pgeom(0.01, 1.2, 4)], inf).stutter(4).asStream;


~test = Pseq([Pgeom(0.01, 1.2, 4)], inf).stutter(4).asStream;
~test.next;