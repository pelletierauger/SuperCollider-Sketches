(
//init/cleanup
s.newBusAllocators;
~vbus = Bus.audio(s, 2);
s.freeAll;
~players.do(_.stop);

s.waitForBoot({

	//fm synth
	SynthDef(\fm, {
		arg freq=500, mRatio=1, cRatio=1,
		index=1, iScale=5, cAtk=4, cRel=(-4),
		amp=0.2, atk=0.01, rel=3, pan=0,
		out=0, fx=0, fxsend=(-25);
		var car, mod, env, iEnv;

		//index of modulation
		iEnv = EnvGen.kr(
			Env(
				[index, index*iScale, index],
				[atk, rel],
				[cAtk, cRel]
			)
		);

		//amplitude envelope
		env = EnvGen.kr(Env.perc(atk,rel,curve:[cAtk,cRel]),doneAction:2);

		//modulator/carrier
		mod = SinOsc.ar(freq * mRatio, mul:freq * mRatio * iEnv);
		car = SinOsc.ar(freq * cRatio + mod) * env * amp;

		car = Pan2.ar(car, pan);

		//direct out/reverb send
		Out.ar(out, car);
		Out.ar(fx, car * fxsend.dbamp);
	}).add;

	//reverb
	SynthDef(\reverb, {
		arg in=0, out=0, dec=4, lpf=1500;
		var sig;
		sig = In.ar(in, 2).sum;
		sig = DelayN.ar(sig, 0.03, 0.03);
		sig = CombN.ar(sig, 0.1, {Rand(0.01,0.099)}!32, dec);
		sig = SplayAz.ar(2, sig);
		sig = LPF.ar(sig, lpf);
		5.do{sig = AllpassN.ar(sig, 0.1, {Rand(0.01,0.099)}!2, 3)};
		sig = LPF.ar(sig, lpf);
		sig = LeakDC.ar(sig);
		Out.ar(out, sig);
	}).add;

	s.sync;

	Synth(\reverb, [\in, ~vbus]);

	s.sync;

	//array of sequencers
	~players = [
		//pad
		Pbind(
			\instrument, \fm,
			\dur, 1/6 * 32,
			\midinote, Pseq([
				[40,52,57,59,62],
				[40,55,57,59,64],
				[40,52,57,59,62],
				[33,45,57,59,64],
			],inf),
			\mRatio, 1,
			\index, 1.5,
			\iScale, Pseq([2,4],inf),
			\atk, 1/6 * 16,
			\rel, 1/6 * 24,
			\cAtk, 0,
			\cRel, 0,
			\amp, 0.027,
			\out, 0,
			\fx, ~vbus,
			\fxsend, -10,
		).play,
	];
});
)

//stop
~players.do(_.stop);

(
Synth.new(\fm, [
			\dur, 1/6 * 32,
            \freq, ~toFreq.("F4"),
			\mRatio, 1,
			\index, 1.5,
			\iScale, 2,
			\atk, 1/6 * 16,
			\rel, 1/6 * 24,
			\cAtk, 0,
			\cRel, 0,
			\amp, 0.27,
			\out, 0,
			\fx, ~vbus,
    \fxsend, -10]
);
)