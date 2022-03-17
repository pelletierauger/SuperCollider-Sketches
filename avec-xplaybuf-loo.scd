

(
var samplesFolder;

~samples = ();
samplesFolder = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Samples/");
samplesFolder.entries.do({
    arg path, i;
    ~samples.put(path.fileNameWithoutExtension.asSymbol, Buffer.read(s, path.fullPath));
    path.fileName.postln;
});
~samples;
)

b = ~samples.at('slide-slice');
(
~sli.free;
~sli = {
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.25);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 4], [2, 'lin', 'lin']), t);
var cutoff = 100 + (4000 * env);
    // var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var po = Demand.kr(t, 0, Dseq([1.533, 2.533] + 0.5, inf));
    var sig = XPlayBuf.ar(2, b, rate: [1, 0.5], trigger: t, startPos: po, loopDur: 0.25, loop:1);
    sig = [sig[0][0] + sig[1][1], sig[0][1] + sig[1][0]];
    sig = VadimFilter.ar(
        input: sig,
        type: 1,
        freq: 4000,
        resonance: 0.25
        // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 1;
    sig * 4;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)

4e-4