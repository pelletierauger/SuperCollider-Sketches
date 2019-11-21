(
var key = ~toMidi.("D#4");
var c0 = key + [0, 3, 6, 9] + 3 + 12 + 3;
var nn = c0;
~pia3.stop;
~pia3 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.05!4, 1),
    \num, Pseq(nn, inf)
).play(t);
)
(
var key = ~toMidi.("D#4");
var c0 = key + [-12, 4, 14, 10].reverse + -5 + 12;
var nn = c0;
~pia3.stop;
~pia3 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.05!4, 1),
    \num, Pseq(nn, inf)
).play(t);
)
(
var key = ~toMidi.("D#4");
var c0 = key + [-12, 3, 6, 9].reverse + 3 + 12 + 3 - 14;
var nn = c0;
~pia3.stop;
~pia3 = Pbind(
    \type, \playPiano,
    \dur, Pseq(0.05!4, 1),
    \num, Pseq(nn, inf)
).play(t);
)

(
Synth.new(\fm, [\freq, 220 * -2.midiratio, \amp, 12, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\fm, [\freq, 220 * 5.midiratio, \amp, 12, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

(
Synth.new(\fm, [\freq, 220 * -3.midiratio, \amp, 12, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\fm, [\freq, 220 * 3.midiratio, \amp, 12, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)

(
Synth.new(\fm, [\freq, 440 * -2.midiratio, \amp, 8, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\fm, [\freq, 440 * 6.midiratio, \amp, 8, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)
(
Synth.new(\fm, [\freq, 220 * 0.midiratio, \amp, 8, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
Synth.new(\fm, [\freq, 220 * 3.midiratio, \amp, 8, \out, 0, \rel, 5, \pan, rrand(-0.5, 0.5)]);
)