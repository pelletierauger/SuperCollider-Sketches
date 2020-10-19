
(
~seq = [
    0, 0, 1, 0,     0, 0, 1, 0,     0, 0, 0, 0,     0, 0, 0, 0,
    1, 0, 0, 0,     1, 0, 0, 0,     0, 0, 1, 0,     0, 0, 0, 0,
    0, 0, 0, 1,     0, 0, 0, 0,     0, 0, 0, 0,     0, 1, 0, 1,
    0, 0, 0, 0,     0, 0, 0, 0,     0, 0, 0, 0,     0, 0, 0, 0,
    0, 0, 0, 0,     1, 0, 0, 0,     0, 0, 0, 0,     1, 0, 1, 0,
    1, 0, 0, 0,     0, 0, 0, 0,     1, 0, 0, 0,     1, 0, 1, 0,
    1, 0, 0, 0,     0, 0, 0, 0,     0, 0, 0, 0,     0, 0, 1, 0,
    0, 1, 0, 1,     0, 0, 0, 0,     0, 0, 0, 0,     1, 0, 0, 0
];
)



b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec l'AT2020 Project/Samples/Recorded/0001 7-Audio.aif");

(
SynthDef(\sampler, {
    arg buf = b, rate = 1, spos = 0, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0;
    var sig, env, lfo;
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: spos * BufFrames.ir(buf));
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig * 4);
}).add;
)

c = 0;

~positions = Array.rand(8, 0.0, 1.0);
~positions[7] = rrand(0.0, 1.0);
~amps = 1!8;
~amps[2] = 8
~amps.postln;
~positions.postln;

c = 0;
(
~scan = {
    8.do({
        |i|
        var y = (i * 16) + c;
        // y.postln;
        if (~seq[y] == 1, {
            Synth.new(\sampler, [\spos: ~positions[i], \rel, 4, \amp, ~amps[i]]);
        });
    });
    c = c + 1;
    if (c == 9, {c = 0});
    // c.postln;
    // (" "!(c*1) ++ "v").asString.postln;
    // "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0".postln;
};
)

({" "}!2).sum
c;
(
~scans = Task {
{~scan.(); 0.25.wait;}.loop;}.start;
)
~scans.stop;

// Première séquence :
(
~positions = [ 0.10706782341003, 0.20605504512787, 0.86131703853607, 0.79107689857483, 0.43234002590179, 0.85736894607544, 0.60245716571808, 0.26000499725342 ]
~amps = [ 1, 1, 8, 1, 2, 4, 1, 4 ];
)

~positions = [ 0.66083467006683, 0.31337773799896, 0.26111555099487, 0.10683631896973, 0.19146573543549, 0.77460038661957, 0.76850640773773, 0.80746841430664 ]


~positions = [ 0.30342924594879, 0.59963619709015, 0.58619022369385, 0.14623188972473, 0.16809546947479, 0.61783957481384, 0.62227833271027, 0.031043410301208 ]
