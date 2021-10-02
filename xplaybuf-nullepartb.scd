b = ~samples.at('slide-slice');

b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0003 4-Audio.aif")
(
~sup.free;
~sup = {
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(128);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 4], [2, 'lin', 'lin']), t);
var cutoff = 100 + (4000 * env);
    var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var in = LocalIn.ar(2);
    // sig = sig + (VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05) * 0.25);
    // sig = VadimFilter.ar(sig, 100, resonance: 0, type: 5);
    // var sig = XPlayBuf.ar(2, b, rate: 0 .midiratio, trigger: 1, startPos: 131.527, loopDur: 4, loop:1);

        var sig = XPlayBuf.ar(2, b, rate: 0.midiratio, trigger: 1, startPos: 131.527, loopDur: 4, loop:1);
// var sig = XPlayBuf.ar(2, b, rate: 1, trigger: 1, startPos: 3.863, loopDur: 4, loop:1);

    // sig = CombC.ar(sig, 1, 0.05, 3);
    // in = VAKorg35.ar(in, freq: 1200, res: 0.1, overdrive: 0.5) * 0.15;
    // sig = sig + (DelayC.ar([in[1], in[0]], 1, 0.05) * SinOsc.kr(0.1).range(0.2, 0.9));
    // LocalOut.ar(sig);
/*    sig = VadimFilter.ar(
        input: sig,
        type: 5,
        freq: cutoff,
        resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env.lag(0.1) * 4;*/
    sig = VadimFilter.ar(sig, 12000, resonance: 0, type: 1);
/*    sig = sig + Greyhole.ar(
        sig,
        \dtime.kr(0.1),
        \damp.kr(0.9),
        \size.kr(1),
        \diff.kr(0.907),
        \fb.kr(0.9),
        \modDepth.kr(0.5),
        \modFreq.kr(5)
    );*/
    // rev;
    sig * 4;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)



b = ~samples.at('slide-slice');

b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0003 4-Audio.aif")
(
~slurps.free;
~slurps = {
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.5);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 4], [2, 'lin', 'lin']), t);
var cutoff = 100 + (4000 * env);
    var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var in = LocalIn.ar(2);
    // sig = sig + (VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05) * 0.25);
    // sig = VadimFilter.ar(sig, 100, resonance: 0, type: 5);
    // var sig = XPlayBuf.ar(2, b, rate: 0 .midiratio, trigger: 1, startPos: 131.527, loopDur: 4, loop:1);
    var z = 7;
        var sig = XPlayBuf.ar(2, b, rate: 0.midiratio, trigger: 1, startPos: 131.527 + 1 + z, loopDur: 0.5, loop:1, fadeTime: 0.5);
// var sig = XPlayBuf.ar(2, b, rate: 1, trigger: 1, startPos: 3.863, loopDur: 4, loop:1);
        sig = sig + DelayC.ar(
        XPlayBuf.ar(2, b, rate: 0.midiratio, trigger: 1, startPos: 131.527 + 7 + z, loopDur: 0.5, loop:1, fadeTime: 0.5),
        1, 0.25);

    // sig = CombC.ar(sig, 1, 0.05, 3);
    // in = VAKorg35.ar(in, freq: 1200, res: 0.1, overdrive: 0.5) * 0.15;
    // sig = sig + (DelayC.ar([in[1], in[0]], 1, 0.05) * SinOsc.kr(0.1).range(0.2, 0.9));
    // LocalOut.ar(sig);
/*    sig = VadimFilter.ar(
        input: sig,
        type: 5,
        freq: cutoff,
        resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env.lag(0.1) * 4;*/
    sig = VadimFilter.ar(sig, 12000, resonance: 0, type: 1);
/*    sig = sig + Greyhole.ar(
        sig,
        \dtime.kr(0.1),
        \damp.kr(0.9),
        \size.kr(1),
        \diff.kr(0.907),
        \fb.kr(0.9),
        \modDepth.kr(0.5),
        \modFreq.kr(5)
    );*/
    // rev;
    sig * 32 * 4;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)