s.boot;
~b1 = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Création musicale/Projets Ableton Live/Avec Caroline Project/Samples/Recorded/0002 7-Audio.aif");
~b1.numFrames;


~beats = Array.new;
~folder = PathName.new("/Users/guillaumepelletier/Desktop/Dropbox/Art/p5/Singing-Lines/SuperCollider/samples/percussions/");

1;
s.nextBufferNumber;
(
~folder.entries.do({
    arg path;
    ~beats = ~beats.add(Buffer.read(s, path.fullPath));
});
)
~beats[2].play;

(
SynthDef(\percu, {
    arg buf = ~beats[0], rate = 1, spos = 0, pan = 1, amp = 1, out = ~volumeBus;
    var sig, env, lfo;
    // env = EnvGen.kr(Env.new([0, 1, 0.5, 0], [0.0001, 0.15, 0.75]), doneAction: 2);
    sig = PlayBuf.ar(2, buf, rate * BufRateScale.ir(buf), startPos: 0, doneAction: 2);
    // sig = sig * env;
    sig = sig * amp * 2;
    sig = Balance2.ar(sig[0], sig[1], 0, 1);
    Out.ar(out, sig);
//     Out.ar(0, sig);
}).add;
)

(
SynthDef("kick", {arg out = 0, amp = 0.3, sinfreq = 60, glissf = 0.9, att = 0.01, rel = 0.45, pan = 0;
	var env, snd, ramp;
	env = Env.perc(att, rel, amp).kr(doneAction: 2);
	ramp = XLine.kr(
		start: sinfreq,
		end: sinfreq * glissf,
		dur: rel
	);
	snd = SinOsc.ar(freq: ramp, mul: env);
	snd = Pan2.ar(snd, pan);
	Out.ar(out, snd);
}).add;
)

~beat1Amp = PatternProxy(Pseq([1, 0, 1, 0], inf));
~beat1Amp.quant = 1;
~beat1Amp.source = Pseq([0, 0.5, 0.5, 0], inf);
~beat1Amp.source = Pseq([1, 0.5, 0.5, 0], inf);
~beat1Amp.source = Pseq([1, 0.5, 1, 0], inf);

~beat1Amp.source = Pseq([1, 0, 1, 0], inf);

~beat1.play(quant: 1);

(
~beat1.stop;
~beat1 = Pbind(
    \instrument, \percu,
    \dur, Pseq([1], inf),
    \spos, 1717440,
    \rate, Pseq([1, 1, 1, 1], inf),
    \amp, ~beat1Amp,
	\pan, Pwhite(-1, 1, inf),
    \buf, Pseq([~beats[0], ~beats[4], [~beats[0], ~beats[2]], ~beats[3]], inf),
    \out, [~volumeBus, 0]
).play(t, quant: 1);
)

(
~snare.stop;
~snare = Pbind(
    \instrument, \percu,
    \dur, Pseq([1/2], inf),
    \spos, 1717440,
    \rate, Pseq([2, 4], inf),
    \rate, Pseq([Pgeom.new(start: 1, grow: 1.5, length: 16)], inf),
    \amp, Pseq([0.5, 0.25], inf),
	\pan, Pwhite(-1, 1, inf),
    \buf, Pseq([~beats[2], ~beats[3]], inf),
    \out, [~volumeBus, 0]
).play(t, quant: 1);
)



(
~beat1.stop;
~beat1 = Pbind(
    \instrument, \percu,
    \dur, Pseq([Pseq([1, 0.5, 0.5], 2), Pseq([0.5], 2)], inf),
    \spos, 1717440,
    \rate, Pseq([1, 1, 1, 1], inf),
    \amp, ~beat1Amp,
	\pan, Pwhite(-1, 1, inf),
    \buf, Pseq([~beats[0], ~beats[4], ~beats[2], ~beats[3]], inf),
    \out, [~volumeBus, 0]
).play(t, quant: 1);
)


(
~beat2.stop;
~beat2 = Pbind(
    \instrument, \percu,
    \dur, Pseq([Rest(0.5), Pseq([1, 0.5], 8)], inf),
    \spos, 1717440,
    // \rate, Pseq([1], inf),
    \rate, Pseq([Pgeom.new(start: 1, grow: 1.5, length: 8)], inf),
    \amp, Pseq([Pgeom.new(start: 1.85, grow: 0.5, length: 4)], inf),
	\pan, Pwhite(-1, 1, inf),
    \buf, Pseq([~beats[2]], inf),
    \out, [~volumeBus, 0]
).play(t, quant: 1);
)


(
~beat3.stop;
~beat3 = Pbind(
    \instrument, \percu,
    // \dur, Pseq([1/3, 1/2, 1/3, 1/2, 1/3, 1/2, 1/4, 1/4], inf),
    \dur, Pseq([2, 1, 1], inf),
    \spos, 1717440,
    // \rate, Pseq([1], inf),
    \rate, Pseq([Pgeom.new(start: 1, grow: 1.5, length: 8)], inf),
    \amp, Pseq([Pgeom.new(start: 0.45, grow: 0.5, length: 4)], inf),
	\pan, Pwhite(-1, 1, inf),
    \buf, Pseq([~beats[2]], inf),
    \out, [~volumeBus, 0]
).play(t, quant: 1);
)

(
~beat4.stop;
~beat4 = Pbind(
    \instrument, \percu,
    \dur, Pseq([3, Pseq([0.125], 8)], inf),
    \spos, 1717440,
    // \rate, Pseq([1], inf),
    \rate, Pseq([Pgeom.new(start: 2, grow: 1.5, length: 8)], inf),
    \amp, Pseq([Pgeom.new(start: 0.35, grow: 0.5, length: 4)], inf),
	\pan, Pwhite(-1, 1, inf),
    \buf, Pseq([~beats[3]], inf),
    \out, [~volumeBus, 0]
).play(t, quant: 1);
)


(
~beat5.stop;
~beat5 = Pbind(
    \instrument, \percu,
    \dur, Pseq([Pseq([1/3, 1/2] * 1.5, 8)], inf),
    \spos, 1717440,
    // \rate, Pseq([1], inf),
    \rate, Pseq([Pgeom.new(start: 1.5, grow: 1.5, length: 8)], inf),
    \amp, Pseq([Pgeom.new(start: 1.85, grow: 0.5, length: 4)], inf),
	\pan, Pwhite(-1, 1, inf),
    \buf, Pseq([~beats[2]], inf),
    \out, [~volumeBus, 0]
).play(t, quant: 1);
)