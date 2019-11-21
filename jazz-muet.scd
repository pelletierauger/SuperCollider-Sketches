(
var key = ~toMidi.("D#4");
var c0 = key + [0, 3, 6, 11, 12 + 6, 12 + 3 + 12] + 0;
var c1 = key + [-5, 0, 4, 11, 12 + 4, 12 + 7 + 12] + 0;
var nn = c0 ++ c1;
~pia2.stop;
~pia2 = Pbind(
    \type, \playPiano,
    \dur, Pseq((0.2!3) ++ 0.5 ++ 2.4 ++ 0.5, inf),
    \num, Pseq(nn, inf) + Pseq(-12!1 ++ (0!5), inf) + Pseq([0, 0], inf)
).play(t);
/*~synth.stop;
~synth = Pbind(
    \instrument, \fm,
    \dur, Pseq([4], inf),
    \freq, ~toFreq.("D#6") * Pseq([[3, 6], [4, 7]].midiratio, inf) * [-12, -24].midiratio,
    \amp, 1,
    \rel, 7,
    \pan, Pwhite(-1.0, 1.0, inf) * 1,
    \out, ~reverbBus
).play(t);*/
/*~synth2.stop;
~synth2 = Pbind(
    \type, \playPiano,
    \dur, Pseq([0.05, 2 - 0.05], inf),
    \num, ~toMidi.("D#4") + Pseq([
        -3, 0, -3, 3,
        0, 4, -1, 4
    ].stutter(1) + 0, inf),
    \amp, Pseq([12, 9], inf) * 0.5,
    \rel, 3,
    \pan, Pwhite(-1.0, 1.0, inf) * 0.75,
    // \ti, Pseq([[1, 10], [0.25, 20]].stutter(1), inf),
    \out, ~reverbBus
).play(t);*/
)