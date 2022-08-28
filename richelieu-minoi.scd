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
    input = input * K2A.ar(i + DelayN.ar(i,1,1 * 0.5)).lag(2) * 16;
    d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(6), inf));
    d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(6), inf));
    // var sig, bass, mix;
    struct = d;
    sig = MiRings2.ar(
        input * 4, 0, ~toMidi.("Ab2"),
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
    sig + bass;
}.play(fadeTime: 0.1)
)