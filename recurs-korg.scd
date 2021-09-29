

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


s.options.memSize_(65536 * 4);
s.reboot;

b = ~samples.at('slide-slice');
(
{
  var start = LFNoise0.kr(1).range(0,BufDur.ir(b));
    var t = Impulse.kr(0.0625 * 8);
    var f = Demand.kr(t, 0, Dseq([0, -2, 2, -3].midiratio, inf));
    var env = EnvGen.kr(Env([0, 1, 0.25, 0], [0.025, 0.5, 4], [2, 'lin', 'lin']), t);
var cutoff = 100 + (4000 * env);
    var po = Demand.kr(t, 0, Dxrand((0..10)/100, inf));
    var in = LocalIn.ar(2);
    // sig = sig + (VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05) * 0.25);
    // sig = VadimFilter.ar(sig, 100, resonance: 0, type: 5);
    var sig = XPlayBuf.ar(2, b, rate: -7.midiratio, trigger: 1, startPos: 3.863, loopDur: 4, loop:1);
    // var sig = XPlayBuf.ar(2, b, rate: 1, trigger: 1, startPos: 3.863, loopDur: 4, loop:1);

    // sig = CombC.ar(sig, 1, 0.05, 3);
    in = VAKorg35.ar(in, freq: 1200, res: 0.1, overdrive: 0.5) * 0.15;
    sig = sig + (DelayC.ar(in, 1, 0.05) * 0.9);
    LocalOut.ar(sig);
/*    sig = VadimFilter.ar(
        input: sig,
        type: 5,
        freq: cutoff,
        resonance: (2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))) * 0.25
        //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
    ) * 8 * env.lag(0.1) * 4;*/
    // sig = VadimFilter.ar(sig, 10000, resonance: 0, type: 1);
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
    sig;
    // MiVerb.ar(sig, drywet: 1, damp: 0.7) * 4;
}.play;
)

4e-4



(
{
    var src = SoundIn.ar(0)!2; // stereo input
    var rev = Greyhole.ar(
        src,
        \dtime.kr(0.1),
        \damp.kr(0.1),
        \size.kr(1),
        \diff.kr(0.707),
        \fb.kr(0.1),
        \modDepth.kr(0.01),
        \modFreq.kr(2)
    );

    Mix([src, rev]) * 0.1;
}.play
)