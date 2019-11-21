((0.2!3) ++ 0.5 ++ 2.4 ++ 0.5).sum


(
var key = ~toMidi.("D#4");
var c0 = key + [-12 + 3, 3, 6, 11, 12 + 6, 12 + 3 + 12] + 0;
var c1 = key + [-12 + 4, 0, 4, 11, 12 + 4, 12 + 7 + 12] + 0;
var nn = c0 ++ c1;
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.2!3) ++ 0.5 ++ 2.4 ++ 0.5, inf),
    \num, Pseq(nn, inf) + Pseq(0!1 ++ (0!5), inf) + Pseq([-2, 7], inf)
).play(t);
~synth.stop;
~synth = Pbind(
    \instrument, \simplest,
    \dur, Pseq([4], inf),
    \freq, ~toFreq.("D#6") * Pseq([[3, 6 - 12], [4, 7 - 12]].midiratio, inf) * -2.midiratio * [0.25, 1],
    \amp, 1,
    \rel, 4,
    \pan, Pwhite(-1.0, 1.0, inf) * 0.75,
    \out, ~reverbBus
).play(t);
~synth2.stop;
~synth2 = Pbind(
    \instrument, \fm,
    \dur, Pseq([1], inf),
    \freq, ~toFreq.("A4") * Pseq([
        [1, 3], [0, 3],
        [1, 4], [1, 6]
    ].midiratio.stutter(2), inf),
    \amp, Pseq([12, 9], inf),
    \rel, 3,
    \pan, Pwhite(-1.0, 1.0, inf) * 0.75,
    // \ti, Pseq([[1, 10], [0.25, 20]].stutter(1), inf),
    \out, ~reverbBus
).play(t);
)
(
~synth2.stop;
~synth2 = Pbind(
    \instrument, \fm,
    \dur, Pseq([1], inf),
    \freq, ~toFreq.("A4") * Pseq([
        [1, 3], [0, 3],
        [1, 4], [1, 6]
    ].midiratio.stutter(2), inf),
    \amp, 2,
    \rel, 1,
    \pan, Pwhite(-1.0, 1.0, inf) * 0.75,
    \out, ~reverbBus
).play(t);
)