s.options.numBuffers
s.options.numBuffers = 5000;

(
var samplesFolder, flatCount = 0;
~samples = ();
~samplesMono = Array.new(5000);
~samplesStereo = Array.new(5000);
~namesMono = [];
~namesStero = [];

samplesFolder = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/");
samplesFolder.folders.do({
    arg subFolder, i;
    var pathSym = ("f" ++ subFolder.folderName).asSymbol;
    ~samples.put(pathSym, ());
    subFolder.entries.do({
        arg subPath, si;
        var subPathSym = ("f" ++ subPath.fileNameWithoutExtension).asSymbol;
        var buf = Buffer.read(s, subPath.fullPath);
        var f = SoundFile.new;
        f.openRead(subPath.fullPath);
        if ((f.numChannels == 1), {
        ~samplesMono = ~samplesMono.add(buf);
        ~namesMono = ~namesMono.add([subFolder.folderName, subPath.fileNameWithoutExtension]);
        ~samples.at(pathSym).put(subPathSym, [buf, f.numChannels, ~samplesMono.size - 1]);        },
        {
        ~samplesStereo = ~samplesStereo.add(buf);
        ~namesStereo = ~namesStereo.add([subFolder.folderName, subPath.fileNameWithoutExtension]);
        ~samples.at(pathSym).put(subPathSym, [buf, f.numChannels, ~samplesStereo.size - 1]);        }
        );
        f.close;
        });
});
)

thisProcess.nowExecutingPath;

~samples.at(\fgretsch).at(\f017_openhat)[0].play;
~samples.at(\fgretsch).at(\f017_openhat)[2]
~samples.at(\fgretsch).at(\f019_ridecymbal).play;
~samples.at(\fgretsch).keys.do({|key|key.postln});
~samples.at(\f808bd).keys

.at(\f017_openhat).play;
~samplesFlat[1250].play
~namesFlat[1251]

~i = 20;
(
~samplesMono[~i].play;
~namesMono[~i].postln;
~i.postln;
~i = ~i + 1;
)

~samples.at(\fgretsch).at(\f017_openhat)[0].play;
~samples.at(\fgretsch).at(\f017_openhat)[1..2];
~samplesStereo[191].play;

~samples.at(\f808sd).at(\fSD1010)[0].play;
~samples.at(\f808sd).at(\fSD1010)[1..2];
~samplesMono[98].play;

(
SynthDef(\samplerMono, {
    arg buf = b, rate = 1, spos = 0, pan = 1, amp = 1, atk = 0.01, susT = 1, rel = 0.01, out = 0;
    var sig;
    // env = EnvGen.kr(Env.new([0, 1, 1, 0], [atk, susT, rel], ['lin', -8]), doneAction: 2);
    sig = PlayBuf.ar(
        1,
        buf,
        rate * BufRateScale.ir(buf),
        startPos: 0,
        doneAction: 2
    );
    sig = sig * amp;
    sig = Balance2.ar(sig, sig, pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~bassDrum.stop;
~bassDrum = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([0.5, 0.5, 0.5, 0.25, 0.25] * 1, inf),
    \amp, 0.1,
    \num, Pseq([30].stutter(1), inf),
    \buf, Pindex.new(~samplesMono, Pkey(\num), inf)
).play(t, quant: [2]);
)

(
~piz2.stop;
~piz2 = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([0.25] * 1, inf),
    \amp, Pseq([0, 0.1], inf),
    \num, Pseq([5].stutter(1), inf),
    \buf, Pindex.new(~samplesMono, Pkey(\num), inf)
).play(t, quant: [2]);
)

(
~snare.stop;
~snare = Pbind(
    \instrument, \samplerMono,
    \dur, Pseq([0.5] * 1, inf),
    \amp, Pseq([0, 0.1], inf),
    \num, Pseq([100].stutter(1), inf),
    \buf, Pindex.new(~samplesMono, Pkey(\num), inf)
).play(t, quant: [2]);
)


~samplesFlat
\017_openhat
\drums808bd
"\808bd"
"808bd".asSymbol

(
var samplesFolder = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Art/SuperCollider/Dirt-Samples-master/");
samplesFolder.folders;
samplesFolder.folders.do({
    arg path, i;
    path.folderName.postln;
});
)