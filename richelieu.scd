MiRings



(    // 2-op_FM - 'pos' controls feedback (no fb at 0.5)
{
    var input = Impulse.kr(6);
    var pitch = Latch.kr(WhiteNoise.kr(), input).range(24, 48).round;
    var brightness = LFNoise1.kr(0.5).range(0.2,0.9);
    var position = LFNoise1.kr(0.4).range(0,0.5);

    var out = MiRings.ar(input, pit: pitch, bright: brightness, pos: position, damp: 0.97, model: 3);

    Splay.ar(out, LFNoise2.kr(0.5).range(-0.5,0.5));
}.play
)


(   // sympathetic_string_quantized --> chords
{
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(1);
    var d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(6), inf));
    var d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(6), inf));
    var sig, bass, mix;
    struct = d;
    sig = MiRings2.ar(
        input, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
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


// Tiny Noise

(   // sympathetic_string_quantized --> chords
{
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(1);
    var ii = i + Impulse.kr(2);
    var input = Nes2Noise.ar(K2A.ar(ii), 0, 0, LFNoise0.kr(3!2, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)) * 0.25;

    var d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(6), inf));
    var d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(6), inf));
    var sig, bass, mix;
    struct = d;
    sig = MiRings2.ar(
        input, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
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


// Square


(   // sympathetic_string_quantized --> chords
{
    // var input = PinkNoise.ar(0.2!2);

    var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(1);
    var ii = i + Impulse.kr(2);
    // var input = Nes2Noise.ar(K2A.ar(ii), 0, 0, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.25;
    var input = Nes2Square.ar(K2A.ar(ii), 2, 1, 1, 10, 1, LFNoise0.kr([3,6], 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), 0.75, LFNoise0.kr(0.3 * [1], 100, 200)) * 0.25;

    var d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(6), inf));
    var d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(6), inf));
    var sig, bass, mix;
    struct = d;
    sig = MiRings2.ar(
        input, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
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



(   // sympathetic_string_quantized --> chords
{
    // var input = PinkNoise.ar(0.2!2);

    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(1);
    var ff = Demand.kr(i, 0, Dxrand([6, 8, 12, 16, 24, 32], inf));
    var ii = i + Impulse.kr(ff);
    // var bright = LFNoise2.kr(0.5).range(0.15, 0.6);
    var bright = Demand.kr(ii, 0, Dwhite(0, 0.45));
    var pos = Demand.kr(ii, 0, Dwhite(0, 0.45));
    var input = Nes2Noise.ar(K2A.ar(ii), 0, 0, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.25;

    var d = Demand.kr(i, 0, Dseq(
        [0.1, 0.3, 0.4, 0.5, 0.6, 0.7, 0.9].stutter(6), inf));
    var d2 = Demand.kr(i, 0, Dseq(
        [0, -2, 2, -4, -7, -5, -9].stutter(6), inf));
    var sig, bass, mix;
    struct = d;
    sig = MiRings2.ar(
        input, 0, ~toMidi.("Ab2"),
        struct, bright, 0.7, 0.125, model:4, poly: 1
    );
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


(   // sympathetic_string_quantized --> chords
{
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2") - -24, struct, 0.5, damp: 0.7, pos: 0.5, model:4, poly: 1);
    sig = VadimFilter.ar(sig, 100, 0, 5);
    // sig.size.poll;
    sig;
}.play
)