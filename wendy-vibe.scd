(   // sympathetic_string_quantized --> chords
y.free;
y = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E0") * [1, 1.1],
        timbre: 0.95, color: 0.15, model: 2
    );
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2")+(~lfo.(1)*1), struct, bright: 0.75, damp: 0.7, pos: 0.5, model:4, poly: 1);
    sig = VadimFilter.ar(sig, 100, 0, 5);
    // sig = VadimFilter.ar(sig, 3000, 0, 1);
    // sig.size.poll;
    sig * 0.5;
}.play
)


(   // sympathetic_string_quantized --> chords
x.free;
x = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E2") * [1, 1.1] * ~lfo.(0.05) + 1,
        timbre: 0.95, color: 0.15, model: 13
    );
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2")+(~lfo.(1)*1), struct,
        bright: 0.9, damp: 0.7, pos: 0.5, model:4, poly: 1
    );
    // sig = VadimFilter.ar(sig, 100, 0, 5);
    // sig.size.poll;
    sig;
}.play
)


(   // sympathetic_string_quantized --> chords
y.free;
y = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E2") * [1, 1.1] * ~lfo.(0.05) + 1 + 0,
        timbre: 0.95, color: 0.15, model: 13
    );
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2")+(~lfo.(1)*1), struct,
        bright: 0.2, damp: 0.7, pos: 0.5, model:4, poly: 1
    );
    sig = VadimFilter.ar(sig, 500, 0, 5) * 4;
    // sig.size.poll;
        sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 2,
        algo: 3, timb: 0.4, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    sig;
}.play
)