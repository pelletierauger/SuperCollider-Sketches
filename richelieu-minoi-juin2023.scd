(   // sympathetic_string_quantized --> chords
{
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(1);
    var ii = i + Impulse.kr(2);
    var dem2 = Demand.kr(i, 0, Dseq([0.2, 0.9], inf));
    var d, d2, sig, bass, mix;
    var input = MiBraids.ar(
        pitch: [2, 1],
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 2,
        bits: 3,
        ws: 0.75
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    input = VadimFilter.ar(input, 2300, 0, 5) * 4;
    input = VAKorg35.ar(input, freq: 5000, res: 0, overdrive: 0.5);
    input = input * K2A.ar(i + DelayN.ar(i,1,1 * 0.5)).lag(0.125) * 16;
    d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(6), inf));
    d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(6), inf));
    // var sig, bass, mix;
    struct = d;
    sig = MiRings2.ar(
        input * 2, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
    sig = sig + (input[0]!2 * 0.1);
    // sig = sig + VadimFilter.ar(K2A.ar(i)!2 * 4, 3000, 0, 5);
    // sig.size.poll;
    bass = (MiPlaits.ar(~toMidi.("Ab2") + d2 + -12, 2,
        harm: 0.25, morph: 0.5, timbre: 0.25, decay: 0.92, trigger: i)[0] * 0.4!2);
    // bass = VadimFilter.ar(bass, 2000, 0, 1);
    // mix = MiWarps.ar(sig, bass, 0.5, 0.5, algo: 4, timb: 0.1);
    // sig = sig + bass * 0 + VadimFilter.ar(mix[0]!2 * 8, 1000, 0, 5);
    sig + bass * 1;
}.play(fadeTime: 0.1)
)



(   // sympathetic_string_quantized --> chords
{
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.6);
    var ii = i + Impulse.kr(2);
    var dem2 = Demand.kr(i, 0, Dseq([0.2, 0.9], inf));
    var d, d2, d3, sig, bass, mix;
    var input = MiBraids.ar(
        pitch: [2, 1],
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 22,
        bits: 3,
        ws: 0
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    input = VadimFilter.ar(input, 2300, 0, 5) * 4;
    // input = VAKorg35.ar(input, freq: 5000, res: 0, overdrive: 0.5);
    input = input * K2A.ar(i + CombC.ar(i,1,1/16, 6)).lag(0.125) * 16;
    input = input + (PinkNoise.ar(0.2!2)*0.1);
    d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(4), inf));
    d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(4), inf));
        d3 = Demand.kr(i, 0, Dseq(
        [0, 1], inf));
    // var sig, bass, mix;
    // input = input + (WhiteNoise.ar(1!2)*d3.lag(1)*0.02);
    struct = d;
    sig = MiRings2.ar(
        input * 2, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
    sig = sig + (input[0]!2 * 0.41);
    // sig = sig + VadimFilter.ar(K2A.ar(i)!2 * 4, 3000, 0, 5);
    // sig.size.poll;
    bass = (MiPlaits.ar(~toMidi.("Ab2") + d2 + -12, 2,
        harm: 0.25, morph: 0.5, timbre: 0.25, decay: 0.92, trigger: i)[0] * 0.4!2);
    // bass = VadimFilter.ar(bass, 2000, 0, 1);
    // mix = MiWarps.ar(sig, bass, 0.5, 0.5, algo: 4, timb: 0.1);
    // sig = sig + bass * 0 + VadimFilter.ar(mix[0]!2 * 8, 1000, 0, 5);
    sig + bass * 1;
}.play(fadeTime: 0.1)
)


(   // sympathetic_string_quantized --> chords
{
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.6);
    var ii = i + Impulse.kr(2);
    var dem2 = Demand.kr(i, 0, Dseq([0.2, 0.9], inf));
    var d, d2, d3, sig, bass, mix;
    var input = MiBraids.ar(
        pitch: [2, 1],
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 22,
        bits: 3,
        ws: 0
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    input = VadimFilter.ar(input, 2300, 0, 5) * 4;
    // input = VAKorg35.ar(input, freq: 5000, res: 0, overdrive: 0.5);
    input = input * K2A.ar(i + CombC.ar(i,1,1/16, 6)).lag(0.125) * 16;
    input = input + (PinkNoise.ar(0.2!2)*0.1);
    d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(4), inf));
    d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(4), inf));
        d3 = Demand.kr(i, 0, Dseq(
        [0, 1], inf));
    // var sig, bass, mix;
    // input = input + (WhiteNoise.ar(1!2)*d3.lag(1)*0.02);
    struct = d;
    sig = MiRings2.ar(
        input * 2, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
    sig = sig + (input[0]!2 * 0.1);
    // sig = sig + VadimFilter.ar(K2A.ar(i)!2 * 4, 3000, 0, 5);
    // sig.size.poll;
    bass = (MiPlaits.ar(~toMidi.("Ab4") + d2 + -12, 2,
        harm: 0.5, morph: 0.75, timbre: 0.5, decay: 0.9, trigger: i)[0] * 0.4!2);
    // bass = bass + (MiPlaits.ar(~toMidi.("Ab2") + d2 + -12, 2,
    // harm: 0.25, morph: 0.5, timbre: 0.25, decay: 0.92, trigger: i)[0] * 0.4!2);
    bass = VadimFilter.ar(bass, 2000, 0, 1);
    // mix = MiWarps.ar(sig, bass, 0.5, 0.5, algo: 4, timb: 0.1);
    // sig = sig + bass * 0 + VadimFilter.ar(mix[0]!2 * 8, 1000, 0, 5);
    sig + bass * 1;
}.play(fadeTime: 0.1)
)


[0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9]

// The custom UGen MiRings2 is a version of MiRings where the chord table has been
// changed in order to create this one chord progression with (somewhat) smooth
// voice leading.
// This is the new chord chart, taken from eurorack/rings/dsp/part.cc

/*float chords[kMaxPolyphony][11][8] = {
  {
    // { -12.0f, -0.01f,  0.0f,  0.01f,  0.02f, 11.99f, 12.0f, 24.0f }, // OCT
    { 0.0f,   1.0f,    2.0f,  3.0f,   4.0f,  5.0f,   6.0f,   7.0f }, // OCT
    // { -12.0f, -5.0f,  0.0f,  6.99f, 7.0f,  11.99f, 12.0f,  19.0f }, // 5
    {  -5.0f,  0.0f,  0.01f, 3.0f,  3.0f,  10.0f,  14.00f, 14.0f }, // 0.1
    {  -5.0f,  0.0f,  0.01f, 3.0f,  3.0f,  10.0f,  15.00f, 15.0f }, // 0.2
    {  -7.0f,  0.0f,  0.01f, 2.0f,  2.0f,  10.0f,  14.00f, 14.0f }, // 0.3
    {  -5.0f,  0.0f,  0.01f, 2.0f,  5.0f,  10.0f,  14.00f, 14.0f }, // 0.4
    {  -7.0f,  -4.0f, -4.01f, 0.0f, 3.0f,  5.0f,  14.00f, 14.0f }, // 0.5
    {  -7.0f,  -4.0f, -4.01f, 2.0f, 2.0f,  5.0f,  14.00f, 14.0f }, // 0.6
    {  -5.0f,  -5.0f, -2.01f, 2.0f, 2.0f,  5.0f,  14.00f, 14.0f }, // 0.7
    {  -9.0f,  -9.0f, -5.01f, -2.0f, 2.0f,  7.0f,  14.00f, 14.0f }, // 0.8
    {  -5.0f,  -5.0f, -2.01f, -2.0f, 3.0f,  7.0f,  14.00f, 14.0f }, // 0.9
    {  -4.0f,  -4.0f, -2.01f, 2.0f, 5.0f,  8.0f,  14.00f, 14.0f }, // 1
    // { -12.0f, -5.0f,  0.0f,  5.0f,  7.0f,  11.99f, 12.0f,  17.0f }, // sus4
    // { -12.0f, -5.0f,  0.0f,  3.0f,  7.0f,   3.01f, 12.0f,  19.0f }, // m
    // { -12.0f, -5.0f,  0.0f,  3.0f,  7.0f,   3.01f, 10.0f,  19.0f }, // m7
    // { -12.0f, -5.0f,  0.0f,  3.0f, 14.0f,   3.01f, 10.0f,  19.0f }, // m9
    // { -12.0f, -5.0f,  0.0f,  3.0f,  7.0f,   3.01f, 10.0f,  17.0f }, // m11
    // { -12.0f, -5.0f,  0.0f,  2.0f,  7.0f,   9.0f,  16.0f,  19.0f }, // 69
    // { -12.0f, -5.0f,  0.0f,  4.0f,  7.0f,  11.0f,  14.0f,  19.0f }, // M9
    // { -12.0f, -5.0f,  0.0f,  4.0f,  7.0f,  11.0f,  10.99f, 19.0f }, // M7
    // { -12.0f, -5.0f,  0.0f,  4.0f,  7.0f,  11.99f, 12.0f,  19.0f } // M
  },*/


~toMidi.("Ab2")

[0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9]

    0.1 {  -5.0f,  0.0f,  0.01f, 3.0f,  3.0f,  10.0f,  14.00f, 14.0f }, // 0.1
    0.3 {  -7.0f,  0.0f,  0.01f, 2.0f,  2.0f,  10.0f,  14.00f, 14.0f }, // 0.3
    0.4 {  -5.0f,  0.0f,  0.01f, 2.0f,  5.0f,  10.0f,  14.00f, 14.0f }, // 0.4
    0.5 {  -7.0f,  -4.0f, -4.01f, 0.0f, 3.0f,  5.0f,  14.00f, 14.0f }, // 0.5
    0.6 {  -7.0f,  -4.0f, -4.01f, 2.0f, 2.0f,  5.0f,  14.00f, 14.0f }, // 0.6
    0.7 {  -5.0f,  -5.0f, -2.01f, 2.0f, 2.0f,  5.0f,  14.00f, 14.0f }, // 0.7
    0.9 {  -5.0f,  -5.0f, -2.01f, -2.0f, 3.0f,  7.0f,  14.00f, 14.0f }, // 0.9



3, 2, 5, 3, 2, 2, 3
0, 0, 2, 0, -4, -2, -2

3, 2, 5, 3, 3, 2, 3
0, 0, 2, 0, 0, -2, -2
10, 10, 10, 14, 14, 14, 14

(   // sympathetic_string_quantized --> chords
x.free;
x = {
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.6);
    var ii = i + Impulse.kr(2);
    var dem2 = Demand.kr(i, 0, Dseq([0.2, 0.9], inf));
    var d, d2, d3, d4, d5, sig, bass, mid, mid2, mid3, mix;
    var input = MiBraids.ar(
        pitch: [2, 1],
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 22,
        bits: 3,
        ws: 0
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    input = VadimFilter.ar(input, 2300, 0, 5) * 4;
    // input = VAKorg35.ar(input, freq: 5000, res: 0, overdrive: 0.5);
    input = input * K2A.ar(i + CombC.ar(i,1,(1/0.6)/16/1.5, 6)).lag(0.125) * 16;
    input = input + (PinkNoise.ar(0.2!2)*0.1);
    d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(4), inf));
    d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(4), inf));
        d3 = Demand.kr(i, 0, Dseq(
        [3, 2, 5, 3, 2, 2, 3].stutter(4), inf));
            d4 = Demand.kr(i, 0, Dseq(
        [0, 0, 2, 0, -4, -2, -2].stutter(4), inf));
            d5 = Demand.kr(i, 0, Dseq(
        [10, 10, 10, 14, 14, 14, 14].stutter(4), inf));


    // var sig, bass, mix;
    // input = input + (WhiteNoise.ar(1!2)*d3.lag(1)*0.02);
    struct = d;
    sig = MiRings2.ar(
        input * 2, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
    sig = sig + (input[0]!2 * 0.41);
    // sig = sig + VadimFilter.ar(K2A.ar(i)!2 * 4, 3000, 0, 5);
    // sig.size.poll;
    bass = (MiPlaits.ar(~toMidi.("Ab2") + d2 + -12, 2,
        harm: 0.25, morph: 0.5, timbre: 0.25, decay: 0.92, trigger: i)[0] * 0.4!2);
    mid = MiBraids.ar(~toMidi.("Ab3") + d3, timbre: 0.25, color: 0.5, model: 4) * 0.08 ! 2 * [1, 0.75];
    mid2 = MiBraids.ar(~toMidi.("Ab3") + d4, timbre: 0.25, color: 0.5, model: 4) * 0.08 ! 2 * [0.75, 1];
    mid3 = MiBraids.ar(~toMidi.("Ab5") + d5, timbre: 0.5, color: 0.25, model: 4) * 0.08 ! 2 * [0.75, 1];
    // bass = VadimFilter.ar(bass, 2000, 0, 1);
    // mix = MiWarps.ar(sig, bass, 0.5, 0.5, algo: 4, timb: 0.1);
    // sig = sig + bass * 0 + VadimFilter.ar(mix[0]!2 * 8, 1000, 0, 5);
    bass + (mid + mid2 * 2 * 1) * 1;
}.play(fadeTime: 0.1)
)


(   // sympathetic_string_quantized --> chords
x.free;
x = {
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.6);
    var ii = i + Impulse.kr(2);
    var dem2 = Demand.kr(i, 0, Dseq([0.2, 0.9], inf));
    var d, d2, d3, d4, d5, sig, bass, mid, mid2, mid3, mix;
    var input = MiBraids.ar(
        pitch: [2, 1],
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 22,
        bits: 3,
        ws: 0
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    input = VadimFilter.ar(input, 2300, 0, 5) * 4;
    // input = VAKorg35.ar(input, freq: 5000, res: 0, overdrive: 0.5);
    input = input * K2A.ar(i + CombC.ar(i,1,(1/0.6)/16/1.5, 6)).lag(0.125) * 16;
    input = input + (PinkNoise.ar(0.2!2)*0.1);
    d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(4), inf));
    d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(4), inf));
        d3 = Demand.kr(i, 0, Dseq(
        [3, 2, 5, 3, 2, 2, 3].stutter(4), inf));
            d4 = Demand.kr(i, 0, Dseq(
        [0, 0, 2, 0, -4, -2, -2].stutter(4), inf));
            d5 = Demand.kr(i, 0, Dseq(
        [14].stutter(4), inf));


    // var sig, bass, mix;
    // input = input + (WhiteNoise.ar(1!2)*d3.lag(1)*0.02);
    struct = d;
    sig = MiRings2.ar(
        input * 2, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
    sig = sig + (input[0]!2 * 0.41);
    // sig = sig + VadimFilter.ar(K2A.ar(i)!2 * 4, 3000, 0, 5);
    // sig.size.poll;
    bass = (MiPlaits.ar(~toMidi.("Ab2") + d2 + -12, 2,
        harm: 0.25, morph: 0.5, timbre: 0.25, decay: 0.92, trigger: i)[0] * 0.4!2);
    mid = MiBraids.ar(~toMidi.("Ab5") + d3, timbre: 0.95, color: 0.5, model: 42) * 0.08 ! 2 * [1, 0.75];
    mid2 = MiBraids.ar(~toMidi.("Ab5") + d4, timbre: 0.95, color: 0.5, model: 42) * 0.08 ! 2 * [0.75, 1];
    mid3 = MiBraids.ar(~toMidi.("Ab5") + d5, timbre: 0.95, color: 0.5, model: 42) * 0.08 ! 2 * [0.75, 1];
    // bass = VadimFilter.ar(bass, 2000, 0, 1);
    // mix = MiWarps.ar(sig, bass, 0.5, 0.5, algo: 4, timb: 0.1);
    // sig = sig + bass * 0 + VadimFilter.ar(mix[0]!2 * 8, 1000, 0, 5);
    bass + ~v.(~v.(mid + mid2 * 2 * 4, 3000),1000,0,5) * 1;
}.play(fadeTime: 0.1)
)


(   // sympathetic_string_quantized --> chords
x.free;
x = {
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.6);
    var ii = i + Impulse.kr(2);
    var dem2 = Demand.kr(i, 0, Dseq([0.2, 0.9], inf));
    var d, d2, d3, d4, d5, sig, bass, mid, mid2, mid3, mix;
    var input = MiBraids.ar(
        pitch: [2, 1],
        timbre: dem2.lag(0.5) * 0.5,
        color: 0.0 + dem2.lag(0.5) + [0, 0.01],
        model: 1,
        resamp: 2,
        decim: 22,
        bits: 3,
        ws: 0
    );
    // sig = VadimFilter.ar(sig, 4000, 0, 1);
    input = VadimFilter.ar(input, 2300, 0, 5) * 4;
    // input = VAKorg35.ar(input, freq: 5000, res: 0, overdrive: 0.5);
    input = input * K2A.ar(i + CombC.ar(i,1,(1/0.6)/16/1.5, 6)).lag(0.125) * 16;
    input = input + (PinkNoise.ar(0.2!2)*0.1);
    d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(4), inf));
    d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(4), inf));
        d3 = Demand.kr(i, 0, Dseq(
        [3, 2, 5, 3, 2, 2, 3].stutter(4), inf));
            d4 = Demand.kr(i, 0, Dseq(
        [0, 0, 2, 0, -4, -2, -2].stutter(4), inf));
            d5 = Demand.kr(i, 0, Dseq(
        [14].stutter(4), inf));


    // var sig, bass, mix;
    // input = input + (WhiteNoise.ar(1!2)*d3.lag(1)*0.02);
    struct = d;
    sig = MiRings2.ar(
        input * 2, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
    sig = sig + (input[0]!2 * 0.41);
    // sig = sig + VadimFilter.ar(K2A.ar(i)!2 * 4, 3000, 0, 5);
    // sig.size.poll;
    bass = (MiPlaits.ar(~toMidi.("Ab2") + d2 + -12, 2,
        harm: 0.25, morph: 0.5, timbre: 0.25, decay: 0.92, trigger: i)[0] * 0.4!2);
    mid = MiBraids.ar(~toMidi.("Ab5") + d3, timbre: 0.95, color: 0.5, model: MouseX.kr(0,47).floor) * 0.08 ! 2 * [1, 0.75];
    mid2 = MiBraids.ar(~toMidi.("Ab5") + d4, timbre: 0.95, color: 0.5, model: MouseX.kr(0,47).floor) * 0.08 ! 2 * [0.75, 1];
    mid3 = MiBraids.ar(~toMidi.("Ab5") + d5, timbre: 0.95, color: 0.5, model: 41) * 0.08 ! 2 * [0.75, 1];
    // bass = VadimFilter.ar(bass, 2000, 0, 1);
    // mix = MiWarps.ar(sig, bass, 0.5, 0.5, algo: 4, timb: 0.1);
    // sig = sig + bass * 0 + VadimFilter.ar(mix[0]!2 * 8, 1000, 0, 5);
    bass + ~v.(~v.(mid + mid2 * 2 * 4, 3000),1000,0,5) * 1;
}.play(fadeTime: 0.1)
)