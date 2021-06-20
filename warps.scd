// first Test: internal sawtooth
{MiWarps.ar(osc: 3, freq: 71, mul: 0.5)}.play;


// algo:0 -- simple xfade between carrier and modulator
(
{
    var timb = SinOsc.kr(0.2).range(0, 1);
    var out = MiWarps.ar(SinOsc.ar(200), SinOsc.ar(500), lev1: 0.4, lev2: 0.2, algo: 0, timb: timb);
    out[0]!2
}.play;
)


// LEV1 and LEV2 are clipped internally between 0 and 1
// at around 0.6 saturation saturation becomes audible
(
{
    var lev1 = SinOsc.kr(0.31, 0, 0.8);
    var lev2 = SinOsc.kr(0.5, 0, 0.8);
    var car = SinOsc.ar(400);
    var mod = SinOsc.ar(300);
    var out = MiWarps.ar(car, mod, lev1: lev1, lev2: lev2, algo: 0, timb: 0.5, mul: 0.5);
    out[0]!2
}.play;
)



// SECOND OUTLET
// second output carries the sum of carrier and modulator
(
{
    var timb = SinOsc.kr(0.2).range(0, 1);
    var out = MiWarps.ar(SinOsc.ar(200), SinOsc.ar(500), lev1: 0.4, lev2: 0.2, algo: 0, timb: timb);
    out[1]!2
}.play;
)


// if internal oscillator is used: second output holds carrier
(
{
    var out = MiWarps.ar(osc: 2, freq: 250, mul: 0.5);
    out[1]!2
}.play;
)


// internal osc: sine, triangle, saw
(
{
    var trig = Impulse.kr(2);
    var internal = TIRand.kr(1, 3, trig); // three different wave shapes
    var out = MiWarps.ar(osc: internal, freq: 100);
    out[1]!2 * 0.5;
}.play;
)


// internal osc:
// in vocoder mode (algo 6-8), the waveshapes are: sawtooth, pulse and low-pass filtered noise
(
{
    var trig = Impulse.kr(2);
    var internal = TIRand.kr(1, 3, trig); // three different wave shapes
    var out = MiWarps.ar(osc: internal, freq: 100, algo: 6);
    out[1]!2 * 0.5;
}.play;
)

(
{
    var lev1 = SinOsc.kr(0.33).range(0,0.9);
    var extCar = SinOsc.ar(70);
    var out = MiWarps.ar(extCar, 0, lev1: lev1, osc: 1, freq: 100);
    out[1]!2 * 0.7;
}.play;
)



// algo:0 -- simple xfade between carrier and modulator
(
{
    var timb = SinOsc.kr(0.2).range(0, 1);
    var out = MiWarps.ar(SinOsc.ar(200), SinOsc.ar(300), lev1: 0.5, lev2: 0.77, algo: 0, timb: timb);
    out[0]!2 * 0.7;
}.play;
)

// algo:0 -- do the same, but using the internal osc (replacing the external carrier)
// note: lev1 (gain/saturation) settings don't apply to the internal osc!
(
{
    var timb = SinOsc.kr(0.2).range(0, 1);
    var out = MiWarps.ar(0, SinOsc.ar(300), lev2: 0.77, algo: 0, timb: timb, osc: 1, freq: 200);
    out[0]!2 * 0.7;
}.play;
)



// algo:1 -- cross-fold carrier and modulator
(
{
    var trig = Impulse.kr(4);
    var pit = TIRand.kr(40, 52, trig);
    var carrier = SinOsc.ar(pit.midicps);
    var mod = SinOsc.ar((pit+7).midicps);
    var colour = LFNoise1.kr(0.3).range(0, 0.5);

    var out = MiWarps.ar(carrier, mod, lev1: 0.5, lev2: 0.4, algo: 1, timb: colour);
    out[0]!2 * 0.5;
}.play;
)


// algo:1 -- cross-fold with carrier only + decay env (think: LPG)
(
{
    var trig = Impulse.kr(5);
    var decay = LFTri.kr(0.1).range(0.1, 1.0);
    var env = Decay.kr(trig, decay, 0.8);
    var pit = TIRand.kr(30, 42, trig);
    var carrier = SinOsc.ar(pit.midicps);
    var colour = LFNoise1.kr(0.3).range(0, 0.2);

    var out = MiWarps.ar(carrier, lev1: env, algo: 1, timb: colour);
    out[0]!2 * 0.5;
}.play;
)


(  // algo:2 -- analog RM with internal osc (tri)
{
    var timb = SinOsc.kr(0.1).range(0, 1);
    var out = MiWarps.ar(0, SinOsc.ar(220 * 7.midiratio), lev2: 0.6, algo: 2, timb: timb, osc: 2, freq: 75);
    out[0]!2 * 0.5;
}.play;
)


(  // algo:3 -- digital RM with internal osc (tri)
{
    var timb = SinOsc.kr(0.1).range(0, 1);
    var out = MiWarps.ar(0, SinOsc.ar(125), lev2: 0.6, algo: 3, timb: timb, osc: 2, freq: 75);
    out[0]!2 * 0.5;
}.play;
)


(  // algo:4 -- XOR with internal osc (saw)
{
    var timb = SinOsc.kr(0.3).range(0, 1);
    var out = MiWarps.ar(0, SinOsc.ar(125), lev2: 0.6, algo: 4, timb: timb, osc: 3, freq: 75);
    out[0]!2 * 0.5;
}.play;
)


(  // algo:5 -- COMPARATOR with internal osc (sin)
{
    var timb = SinOsc.kr(0.3).range(0, 1);
    var out = MiWarps.ar(0, SinOsc.ar(125), lev2: 0.6, algo: 5, timb: timb, osc: 1, freq: 75);
    out[0]!2 * 0.5;
}.play;
)


(   // scan through all cross-modulation algos
{
    var algo = SinOsc.kr(0.1).range(0, 5.5);
    var timbre = SinOsc.kr(0.297, 0, 0.5, 0.5);
    var out = MiWarps.ar(0, SinOsc.ar(100), lev2: 0.6, algo: algo, timb: timbre, osc: 1, freq: 150);
    out[0] !2 * 0.5;
}.play
)

b = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
{PlayBuf.ar(1, b, BufRateScale.kr(b), loop:1)!2}.play;


(
{
    var trig = Impulse.kr(0.7);
    var pit = TIRand.kr(24, 36, trig);
    var algo = LFTri.kr(0.1).range(5.6, 8);
    var timbre = LFNoise1.kr(0.3).range(0.2, 0.8);
    var mod = PlayBuf.ar(1, b, BufRateScale.kr(b), loop:1);

    var out = MiWarps.ar(0, mod, lev2: 0.8, algo: algo, timb: timbre, osc:2, freq:pit.midicps);
    out[0] ! 2 * 0.5;
}.play
)
// easter egg (freqshifter) with internal oscillator
(
{
    var alg = LFTri.kr(0.1).range(0.25,0.75);
    var fb = 0.5;
    var drywet = 1;
    var mix = 0.5; // mix upper and lower side bands
    var mod = PlayBuf.ar(1, b, BufRateScale.kr(b), loop:1);
    var out = MiWarps.ar(0, mod, fb, drywet, alg, mix, osc: 3, easteregg: 1);
    out[1]!2 * 0.5;
}.play;
)

// easter egg (freqshifter) with external carrier
(
{
    var freq = LFTri.kr(0.1).range(1, 440);
    var fb = 0.5;
    var drywet = 1;
    var mix = 0.5; // mix upper and lower side bands
    var mod = PlayBuf.ar(1, b, BufRateScale.kr(b), loop:1);
    var out = MiWarps.ar(SinOsc.ar(freq), mod, fb, drywet, 0, mix, osc: 0, easteregg: 1);
    out[1]!2 * 0.5;
}.play;
)

b.free