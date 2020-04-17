(
{
    var freq = 110 * -24.midiratio;
    var sig = LFSaw.ar(freq * [1, 1]) * 0.75 + (SinOsc.ar(freq) * 0.1) + (LFSaw.ar(freq * 2 * [1, 1]) * 0.05);
    // BPF.ar(sig, 100);
    // sig;
    var stack = Pgeom(100, 1.5, 14).asStream.nextN(14).collect({|i, n| BPF.ar(sig, i) * SinOsc.kr(1 + (n * 0.25)).range(0.9, 1) * 0.1});
    // LPF.ar(sig, 900);

    var lfo2 = SinOsc.kr(0.1).range(0.2, 0.75);
    sig = HPF.ar(Splay.ar(stack), 4000) * 8;

    MiRings.ar(sig,
            0,
            voct: 50,
            struct: 0.15,
            bright: 0.25 + [0.0, 0.05],
            damp: lfo2 + [0.0, 0.05].reverse,
            pos: 0.7 + [0.0, 0.05],
            usetrigger: 0,
            bypass: 0) * 40;
}.play;
)
(
{
    var freq = 110 * 7.midiratio;
    var sig = LFSaw.ar(freq * [1, 1]) * 0.75 + (SinOsc.ar(freq) * 0.1) + (LFSaw.ar(freq * 2 * [1, 1]) * 0.05);
    // BPF.ar(sig, 100);
    // sig;
    var stack = Pgeom(100, 1.5, 14).asStream.nextN(14).collect({|i, n| BPF.ar(sig, i) * SinOsc.kr(1 + (n * 0.25)).range(0.9, 1) * 0.1});
    // LPF.ar(sig, 900);
    Splay.ar(stack) * 2;
}.play;
)
(
{
    var freq = 110 * 24.midiratio;
    var sig = LFSaw.ar(freq * [1, 1]) * 0.75 + (SinOsc.ar(freq) * 0.1) + (LFSaw.ar(freq * 2 * [1, 1]) * 0.05);
    // BPF.ar(sig, 100);
    sig * 0.5;
}.play;
)
s.record;
s.stopRecording;

Pgeom(100, 1.5, 30).asStream.nextN(30)[20]