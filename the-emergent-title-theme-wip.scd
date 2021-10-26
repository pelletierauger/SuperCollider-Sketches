// 2021-08-19 continuing work on 'theme music' for my channel

// setup

s.options.memSize_(2.pow(20)); // generous memory allocation
// s.options.inDevice_("Windows WDM-KS : Speakers (Conexant HD Audio output)");
// s.options.outDevice_("Windows WDM-KS : Mikrofonarray (Conexant HD Audio capture)");

~out = 0;
t = TempoClock(72/60).permanent_(true); // tempo clock @ 72 bpm

// chord progression
(~prog = ChordSymbol.noteProgression([
	\Cm, \Eb, \Em, \G_d
]);)

// cutoff "evolution" series
~cutoffseries = Array.series(9, 4000, 1000).mirror1;

// bus dictionary
(~makeBuses = {
	s.newBusAllocators;
	~bus = Dictionary.new;
	~bus.add(\reverb -> Bus.audio(s,2)); // reverb bus
	~bus.add(\delay -> Bus.audio(s, 2)); // delay bus
};)

// make groups
(~makeNodes = {
	s.bind({
		~src = Group.new;
		~efx = Group.after(~src);
		~delSynth = Synth(\allpass, [\in, ~bus[\delay], \out, ~bus[\reverb]], ~efx);
		~reverbSynth = Synth(\reverb, [\in, ~bus[\reverb], \out, ~out], ~efx, addAction:\addToTail);
	});
};)

// cleanup
/*~cleanup = {
	s.newBusAllocators;
	s.newBufferAllocators;
	ServerBoot.removeAll;
	ServerTree.removeAll;
	ServerQuit.removeAll;
};*/

// register functions
// ServerBoot.add(~makeBuses);
// ServerTree.add(~makeNodes);
// ServerQuit.add(~cleanup);

// s.waitForBoot({
~makeBuses.();
~makeNodes.();
// s.sync;

	///////////////// effect synthdefs ////////////////////////////////

(	SynthDef(\reverb, {
		var sig;
		sig = JPverb.ar(
			In.ar(\in.ir(~bus[\reverb]), 2),
			\rtime.kr(6),
			\damp.kr(0.75),
			\size.kr(4.5),
			\earlyDiff.kr(0.8),
			\modDepth.kr(0.12),
			\modFreq.kr(2),
			\low.kr(1),
			\mid.kr(0.9),
			\high.kr(0.8)
		);
		sig = sig * \revAmp.kr(0.5);
		Out.ar(\out.kr(~out), sig);
	}).add;

	SynthDef(\allpass, {
		var sig;
		sig = In.ar(\in.kr(~bus[\delay]), 2);
		sig = AllpassL.ar(
			sig,
			\maxdel.kr(0.5),
			\delay.kr(0.25),
			\decay.kr(0.75),
			\delAmp.kr(0.8)
		);
		Out.ar(\out.kr(~bus[\reverb]), sig)
	}).add;

	////////////////////// Instruments ///////////////////////////////

	SynthDef(\stringpad, {
		arg dry = 1;
		var sig, env;
		env = Env.asr(\atk.ir(0.5), 1, \rel.ir(1.5), \curve.ir(-2)).kr(2, \gate.kr(1));
		sig = 5.collect{
			VarSaw.ar(
				\freq.kr(220) * LFNoise1.kr(0.2).bipolar(\detune.kr(0.125)).midiratio,
				{rrand(0.0, 0.05)},
				{rrand(0.001, 0.02)}
			)
		};
		sig = BLowPass.ar(sig, \cutoff.kr(4200, \cutlag.kr(0.5)), \rq.kr(0.8));
		sig = sig * env * \amp.kr(-12.dbamp, 0.2);
		sig = Splay.ar(sig);
		Out.ar(\out.ir(~out), sig * dry);
		Out.ar(\fx.ir(~bus[\reverb]), sig * (1-dry))
	}).add;

	SynthDef(\piano, {
		arg dry = 1;
		var sig, env;
		env = Env.perc(\atk.ir(0.001), \rel.ir(1), 1, \curve.ir(-6)).kr(2);
		sig = SinOsc.ar(\freq.kr(440));
		sig = sig.blend(sig.distort, \blend.kr(0.25));
		sig = sig * env * \amp.kr(-12.dbamp);
		sig = Pan2.ar(sig, \pan.kr(0));
		Out.ar(\out.ir(~out), sig * dry);
		Out.ar(\fx.ir(~bus[\reverb]), sig * (1-dry))
	}).add;

	~chordbuf = Buffer.allocConsecutive(4, s, 3);

	~prog.do({
		arg n, i;
		~chordbuf[i].loadCollection(n);
	});

	SynthDef(\arp, {
		arg dry = 1, buf = ~chordbuf[0];
		var sig, env, freq, arp, deg;
		env = Env.perc(\atk.kr(0.01), \rel.kr(8)).kr(2);
		arp = LFSaw.kr(\arpfreq.kr(2), \iphase.kr(1)).range(0,\span.kr(1)) * BufFrames.kr(buf);
		deg = DegreeToKey.kr(buf, arp) + (\octave.kr(6)*12);
		freq = deg.midicps.lag(0.125);
		sig = VarSaw.ar(freq, \phase.kr(0.0), \width.kr(0.4), \amp.kr(0.1));
		sig = HPF.ar(sig, 250);
		sig = sig * env;
		sig = Pan2.ar(sig, \pan.kr(0));
		Out.ar(\out.kr(~out), sig * dry);
		Out.ar(\fx.kr(~bus[\reverb]), sig * (1 - dry))
	}).add;
)

~bus
/////////////////////////// Patterns ////////////////////////////////////
(
~background = Pbind(
	\instrument, \stringpad,
	\midinote, Pseq([
		~prog[0]+[48, 60, 48],
		~prog[1]+[60, 48, 48],
		~prog[2]+[60, 60, 48],
		~prog[3]+[48, 60, 48]
	], inf),
	\dur, 4,
	\atk, 0.6,
	\rel, Pkey(\dur) * 0.8,
	\amp, -36.dbamp,
	\dry, 0.3,
	\cutoff, Pseq(~cutoffseries, inf),
	\fx, ~bus[\reverb],
	\group, ~src
);

~bass = Pbind(
	\instrument, \stringpad,
	\midinote, Pseq([
		~prog[0][0],
		~prog[1][0],
		~prog[2][0],
		~prog[3][1]
	]+36,inf),
	\rel, Pkey(\dur) * 0.75,
	\cutoff, 3200,
	\dry, 0.5,
	\amp, -32.dbamp,
) <> ~background;

~piano = Pbind(
	\instrument, \piano,
	\midinote, Pseq([
		\, 67, 79, 67, 79, 67, 79
	], inf),
	\dur, Pseq([
		Pn(0.25, 4),
		Pn(1/3, 3)
	], inf),
	\amp, Pseq([\, -24, -22, -24, -22, -24, -24].dbamp, inf),
	\dry, 0.5,
	\group, ~src
);
)

(
~main = Ppar([
	~bass,
	~background,
	~piano
], inf).play(t, quant:1);
)

t.schedAbs(t.nextBar, {~main.stop; nil});

(
~bubbles = Pbind(
	\instrument, \arp,
	\dur, 2,
	\buf, Pseq([
		\, ~chordbuf[0],
		\, ~chordbuf[1],
		\, ~chordbuf[2],
		\, ~chordbuf[3]
	], inf),
	\arpfreq, Pwhite(1.0, 4),
	\octave, Prand((5..7), inf),
	\iphase, Pwhite(0.1, 1.9pi),
	\atk, 0.3,
	\dry, 0.8,
	\span, Prand([1,2], inf),
	\pan, Pwhite(-1.0, 1.0),
	\amp, -22.dbamp,
	\group, ~src,
	\fx, ~bus[\reverb],
	\out, ~bus[\delay]
);
)

~bub = 3.collect{~bubbles.play(t)};
~bub.stop;

(
~main2 = Ppar([
	~bass,
	~background,
	~piano,
	~bubbles
], inf).play(t, quant:1);
)
t.schedAbs(t.nextBar, {~main2.stop; nil});

// intro
(
~introstr = Pbind(
	\midinote, Pseq([
		~prog[0]+[48, 60, 48],
	], inf)
) <> ~background;

~introbass = Pbind(
	\midinote, Pseq([
		~prog[0][0]
	]+36,inf)
) <> ~bass;

~intropiano = Pbind(
	//\midinote, Pseq([67], inf),
	\midinote, 79,
	//\dur, Pseq([], inf)
) <> ~piano;

/*~introbubbles = Pbind(

) <> ~bubbles;*/
)

(
~intro = Ppar([
	~introstr,
	~introbass,
	~intropiano
], inf).play(t, quant:1);
)

t.schedAbs(t.nextBar, {~intro.stop; nil});

// next time: fix routing of the bubbles, come up with an interesting rhythm for the "piano"; make an intro pattern for bubbles; put it all together

//////////////////////// kthxbye ////////////////////////////////////////
s.quit;
