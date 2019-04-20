~eno = Buffer.read(s, "/Users/guillaumepelletier/Downloads/1975\ -\ Another\ Green\ World/03\ -\ St.\ Elmo\'s\ Fire.aiff");

~eno = Buffer.read(s, "/Users/guillaumepelletier/Downloads/1975\ -\ Another\ Green\ World/07\ -\ Another\ Green\ World.aiff");
~eno = Buffer.read(s, "/Users/guillaumepelletier/Downloads/1975\ -\ Another\ Green\ World/10\ -\ Golden\ Hours.aiff");
~eno = Buffer.read(s, "/Users/guillaumepelletier/Downloads/Selected\ Ambient\ Works\ Volume\ II\ -\ FLAC\ \(Soulseek\)/03.\ Aphex\ Twin\ -\ Rhubarb\ \(Selected\ Ambient\ Works\ Volume\ II\).aiff");
~eno = Buffer.read(s, "/Users/guillaumepelletier/Downloads/Selected\ Ambient\ Works\ Volume\ II\ -\ FLAC\ \(Soulseek\)/21.\ Aphex\ Twin\ -\ Lichen\ \(Selected\ Ambient\ Works\ Volume\ II\).aiff");
~eno = Buffer.read(s, "/Users/guillaumepelletier/Downloads/Selected\ Ambient\ Works\ Volume\ II\ -\ FLAC\ \(Soulseek\)/01.\ Aphex\ Twin\ -\ Cliffs\ \(Selected\ Ambient\ Works\ Volume\ II\).aiff");
~eno = Buffer.read(s, "/Users/guillaumepelletier/Movies/audio-nopeaks.wav");
~eno.numFrames;
~guitare.numChannels;
7144448/14400/2/60;
(
SynthDef(\accords, {
    arg buf = ~eno, spos = 0, rate = 1, pan = 0, amp = 1, rel = 2, atk = 0.1, out = 0, gate = 1;
    var sig, env, lfo;
//     env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    env = EnvGen.ar(Env.new([0.0, 1.0, 0.00001], [atk, rel], [\linear, \exponential],1), gate, doneAction: 2);
    sig = PlayBuf.ar(2, ~eno, rate * BufRateScale.ir(buf), startPos: spos, doneAction: 2);
    sig = sig * env;
    sig = sig * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

~enoPlay = Synth.new(\accords, [\out, 0, \amp, 2, \spos, 0]);
~enoPlay.set(\gate, 0);

FreqScope.new(400, 200, 0, server: s);

~bow = {SinOsc.ar(440) * 0.1}.play;
~bow.free;

~bow2 = {SinOsc.ar(880) * 0.1}.play;
~bow2.free;

~bow3 = {SinOsc.ar(880 * 2) * 0.1}.play;
~bow3.free;

~bow4 = {SinOsc.ar(880 * 4) * 0.1}.play;
~bow4.free;