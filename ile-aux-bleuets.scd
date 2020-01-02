(
SynthDef.new(\sine, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, env, lfo, op2, op3;
    rel = min(max(rel, 0.001), 10);
    lfo = SinOsc.kr(3);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    op3 = SinOsc.ar(freq * 4);
    op2 = SinOsc.ar(freq * 0.5);
    sig = SinOsc.ar([freq, freq + 0.1], op2 * 0.25) * 0.1;
    sig = sig * env * amp * lfo;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)
(
SynthDef.new(\sineFlip, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 1;
    var sig, env, lfo, op2, op3;
    rel = min(max(rel, 0.001), 10);
    lfo = SinOsc.kr(3);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    op3 = SinOsc.ar(freq * 4);
    op2 = SinOsc.ar(freq * 0.5);
    sig = SinOsc.ar([freq, freq + 0.1]) * 0.1;
    sig = sig * env * amp * lfo;
    sig = Balance2.ar(sig[1], sig[0], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~chords.stop;
~chords = Pbind(
    \instrument, Pseq([\sine, \sineFlip], inf),
    \dur, Pseq([0.1, 0.1, 0.1, 4 - 0.3], inf),
    \freq, ~toFreq.("D3") *
    Pseq([16, 0, 11, 7].wrapExtend(8) ++ // DMaj7
        [17, 2, 12, 8].wrapExtend(4) ++  // Em7b5
        ([17, 2, 12, 8] + 2).wrapExtend(4) ++ // F#m7b5
        [17, 5, 12, 8].wrapExtend(4) // Gm
        , inf).midiratio,
    \amp, 1.5,
    \rel, 3
).play(~t1, quant: [2]);
)

(
~chords.stop;
~chords = Pbind(
    \instrument, \sine,
    \dur, Pseq([0.1, 0.1, 0.1, 4 - 0.3], inf),
    \freq, ~toFreq.("D3") *
    Pseq([16, 0, 11, 7].wrapExtend(8) ++ // DMaj7
        [17, 2, 12, 8].wrapExtend(4) ++  // Em7b5
        ([17, 2, 12, 8] + 2).wrapExtend(4) ++ // F#m7b5
        [17, 5, 12, 8].wrapExtend(4) // Gm
        , inf).midiratio,
    \amp, 1.5,
    \rel, 3
).play(~t1, quant: [2]);
~pizBas.stop;
~pizBas = Pbind(
    \instrument, \pizzicato_bas,
    \dur, Pseq([0.5], inf),
    \freq, ~toFreq.("D4") *
    Pseq([16, 0, 11, 7].wrapExtend(16) ++ // DMaj7
        [17, 2, 12, 8].wrapExtend(8) ++  // Em7b5
        ([17, 2, 12, 8] + 2).wrapExtend(8) ++ // F#m7b5
        [17, 5, 12, 8].wrapExtend(8) // Gm
        , inf).midiratio,
    \amp, Pseq(Pgeom(1, 0.9, 4).asStream.nextN(4) * 0.75, inf) * 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5)
).play(~t1, quant: [2]);
/*~pizMelo.stop;
~pizMelo = Pbind(
    \instrument, \sine,
    \dur, Pseq([0.5, 0.25, 0.75, 1.25 - 0.75] * 2, inf),
    \freq, ~toFreq.("D4") *
    Pseq([4, 2, 0, 0].wrapExtend(8) ++
        [5, 4, 2, 2].wrapExtend(4) ++
        ([21, 20, 19, 19]- 12).wrapExtend(4) ++
        [3, 2, 0, 0].wrapExtend(4)

        , inf).midiratio,
    \amp, 3.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5),
    \rel, 0.5
).play(~t1, quant: [2, 0.5]);*/
)

(
~pizMelo2.stop;
~pizMelo2 = Pbind(
    \instrument, \pizzicato_haut,
    \dur, Pseq([0.5, 0.25, 0.75, 1.25 - 0.75], inf),
    \freq, ~toFreq.("D6") *
    Pseq([4, 2, 0, 0].wrapExtend(16) ++
        [5, 4, 2, 2].wrapExtend(8) ++
        ([21, 20, 19, 19]- 12).wrapExtend(8) ++
        [3, 2, 0, 0].wrapExtend(8)

        , inf).midiratio,
    \amp, 1.5,
    \mult, 1.85 - (Pkey(\amp, inf) * 2.5),
    \rel, 0.5
).play(~t1, quant: [2, -0.25]);
)



(
~chords.stop;
~chords = Pbind(
    \instrument, \sine,
    \dur, Pseq([0.1, 0.1, 0.1, 4 - 0.3], inf),
    \freq, ~toFreq.("D4") *
    Pseq(
        [-1, 2, 5, 9].wrapExtend(8) ++ // DMaj7
        [-3, 2, 5, 9].wrapExtend(8) ++  // Em7b5
        [-1, 2, 7, 11].wrapExtend(4) ++  // Em7b5
        ([-1, 2, 7, 10]).wrapExtend(4)
        , inf).midiratio,
    \amp, 3.5,
    \rel, 3
).play(~t1, quant: [2]);
~pizMelo.stop;
~pizBas.stop;
)