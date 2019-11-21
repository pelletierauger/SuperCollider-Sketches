
((2 to the power of 1/12) to the power of n)


(
var fr = 440 * 2.pow(1/7).pow();
)

440 * 2.pow(1/7).pow(7);
440 * 1.25;
3.pow(2).pow(2);


Synth.new(\ponddrop, [\freq, ~toFreq.(["F4", "F5"].choose) * 2 * [0, 2, 4, 5, 7, 9, 11, 12].choose.midiratio, \amp, 4.7, \out, ~reverbBus, \rel, 10, \pan, rrand(0.0, 2.0) - 1, \freqOsc, 20 * 0.25, \triMod, 0.5, \dec, [0.075, 0.1, 0.05].choose, \low, rrand(200, 800)]);


Synth.new(\ponddrop,
    [\freq, ~toFreq.(["F4", "F5"].choose) * 2 * [0, 2, 4, 5, 7, 9, 11, 12].choose.midiratio, \amp, 4.7, \out, ~reverbBus, \rel, 1, \pan, rrand(0.0, 2.0) - 1, \freqOsc, 20 * 0.25, \triMod, 0.5, \dec, [0.075, 0.1, 0.05].choose, \low, rrand(200, 800)]);


({|i| 440 * 2.pow(1/7).pow(i);}!7).scramble;
(
var n = 9;
var freq = ({|i| [880, 440, 220].choose * 2.pow(1/n).pow(i);}!n).scramble;
~oceanBlue.stop;
~oceanBlue = Pbind(
    \instrument, \ponddrop,
    \dur, Pseq([1], inf),
    \freq, Pseq(freq, inf),
    \atk, 0.15,
    \freqOsc, 2 * 0.25,
    \triMod, Pseq([0.5, 0.501] * 2, inf),
    \dec, 0.25,
    \amp, 7.7 * Pseq([1, 1.75], inf) * 0.5,
    \rel, 10,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, 0
).play(t, quant: [1]);
)



(
var n = 10;
(0..n-1).choose;
)


(
var n = 7;
var oct = ({|i| [0.5, 1, 2].choose;}!n).scramble;
var freq = ({|i| oct * 2.pow(1/n).pow((0..n-1).choose);}!8).scramble;
var baseFreq = Pseq([440 * 2.pow(1/n).pow(n * -1 - 5), 440 * 2.pow(1/n).pow(n * -1 - 3)].stutter(4), inf);
var shift = [0, 2];
var freq2 = ({|i| baseFreq * [0.5, 1, 2].choose * 4 * 2.pow(1/n).pow(i);}!n).scramble;
// Synth.new(\ponddrop, [\freq, freq[0] * 440, \amp, 6.7, \out, 0, \rel, 20, \pan, rrand(0.0, 2.0) - 1, \freqOsc, 20 * 0.25, \triMod, 0.5, \dec, [0.075, 0.1, 0.05].choose, \low, rrand(200, 800)]);
// Synth.new(\ponddrop, [\freq, freq[1] * 440, \amp, 6.7, \out, 0, \rel, 20, \pan, rrand(0.0, 2.0) - 1, \freqOsc, 20 * 0.25, \triMod, 0.5, \dec, [0.075, 0.1, 0.05].choose, \low, rrand(200, 800)]);
// Synth.new(\ponddrop, [\freq, freq[2] * 440, \amp, 6.7, \out, 0, \rel, 20, \pan, rrand(0.0, 2.0) - 1, \freqOsc, 20 * 0.25, \triMod, 0.5, \dec, [0.075, 0.1, 0.05].choose, \low, rrand(200, 800)]);

~oceanBlue.stop;
~oceanBlue = Pbind(
    \instrument, \pondchirp,
    \dur, Pseq([0.5 * 1].stutter(3) ++ 3.5, inf),
    \freq, baseFreq * Pseq(freq, inf),
    \atk, 0.025,
    \freqOsc, 2 * 0.25,
    \triMod, Pseq([0.5, 0.501] * 4, inf),
    \dec, 0.25 * 1,
    \amp, 7.7 * Pseq([1, 1.75], inf) * 0.5,
    \rel, 2,
    \pan, Pwhite(-0.5, 0.5, inf),
    \out, ~reverbBus
).play(t, quant: [1]);
~oceanBlue2.stop;
~oceanBlue2 = Pbind(
    \instrument, \pondchirp,
    \dur, Pseq([1], inf),
    \freq, Pseq(freq2, inf),
    \atk, 0.0015,
    \freqOsc, 2 * 0.25,
    \triMod, Pseq([0.5, 0.501] * 2, inf),
    \dec, 0.25 * 1,
    \dec, 0.25 * Pseq([1, 0.5], inf),
    \amp, 7.7 * Pseq([1, 1.75], inf) * 0.5,
    \rel, 10,
    \pan, Pwhite(-0.75, 0.75, inf),
    \out, ~reverbBus
).play(t, quant: [1]);
)

(
// Synth.new(\ponddrop, [\freq, freq[2] * 440, \amp, 6.7, \out, 0, \rel, 20, \pan, rrand(0.0, 2.0) - 1, \freqOsc, 20 * 0.25, \triMod, 0.5, \dec, [0.075, 0.1, 0.05].choose, \low, rrand(200, 800)]);
var freq = ({|i|
    var n = 12;
    var f = [440, 880].choose * 2.pow(1/n).pow((0..n-1).choose);
    Synth.new(\pondchirp, [\freq, f, \amp, 6.7, \out, 0, \rel, 20, \pan, rrand(0.0, 2.0) - 1, \freqOsc, 20 * 0.25, \triMod, 0.5, \dec, [0.075, 0.1, 0.05, 0.025, 0.22].choose * 0.5, \low, rrand(200, 800)]);
}!8);
)