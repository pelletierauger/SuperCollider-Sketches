(
y.free;
y = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E2") * [1, 1.1] * ~lfo.(0.05, 0.5, 0.7) + 1 + 0,
        timbre: 0.95, color: 0.15, model: 13
    );
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E4")+(~lfo.(1)*1), struct,
        bright: 0.2, damp: 0.7, pos: 0.5, model:4, poly: 1
    );
    sig = VadimFilter.ar(sig, 1000, 0, 5) * 40;
    // sig.size.poll;
    sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 2,
        algo: 3, timb: 0.4, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    sig = MiRings.ar(sig, pit: ~toMidi.("C1"), struct: 0.5, bright: 0.2,
        damp: 0.9, pos: 0.5, model: 0
    ) + ~v.(sig*0.01,1000,0,5);
    sig * 2 * EnvGen.kr(Env([0,0,1], [0.009,0.05]));
}.play;
)

(
y.free;
y = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E2") * [1, 1.1] * ~lfo.(0.05,0.4,0.7) + 1 + 0,
        timbre: 0.95, color: 0.15, model: 13
    );
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2")+(~lfo.(1)*1), struct,
        bright: 0.2, damp: 0.7, pos: 0.5, model:4, poly: 1
    );
    sig = VadimFilter.ar(sig, 500, 0, 5) * 4;
    // sig.size.poll;
        sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 0.5,
        algo: 2, timb: 0.4, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.8;
    sig = ~v.(sig, 4000) + ~v.(sig*0.5, 1000,0,3);
    sig = ~v.(sig,1000,0,5)*4;
    sig * 8 * 8 * EnvGen.kr(Env([0,0,1], [0.009,0.05]));
}.play;
)

(
y.free;
y = {
    var input = PinkNoise.ar(0.2!2);
    var bright = LFNoise2.kr(0.5).range(0.15, 0.3);
    var struct = LFNoise0.kr(0.2).range(0,1);
    var i = Impulse.kr(0.125);
    var d = Demand.kr(i, 0, Dseq([0.1, 0.3, 0.4], inf));
    var sig;
    struct = 0;
    input = MiBraids.ar(~toMidi.("E3") * [1, 1.1] * ((0..10)/20+1) * ~lfo.(0.05 * ((0..10)/20+1),0.4,0.7) + 1 + 0,
        timbre: 0.95, color: 0.5, model: 13
    );
    input = ~split.(input) * 0.1;
    sig = MiRings2.ar(
        input, 0, ~toMidi.("E2")+(~lfo.(1)*1), struct,
        bright: 0.2, damp: 0.1, pos: 0.5, model:4, poly: 1
    );
    sig = VadimFilter.ar(sig, 500, 0, 5) * 4;
    // sig.size.poll;
        sig = MiWarps.ar(
        sig, sig, lev1: 0.5, lev2: 1,
        algo: 2, timb: 0.4, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 0.1;
    sig = ~v.(sig, 400,0, 5);
    // sig = MiVerb.ar(sig);
    sig * 0.75;
}.play;
)