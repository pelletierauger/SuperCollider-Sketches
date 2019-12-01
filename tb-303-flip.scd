(
SynthDef(\tb303, {
	arg outBus = 0, gate = 1, pitch = 50, amp = 0.1, totVol,
	fltCtf, fltDec, fltDst, fltPitchMod, fltAmt, fltRz, fltRza,
	volAtk, volDec, volSus, volRel, volAmt;
	var env1, env2, out, tenv;
	env1 = EnvGen.ar(
		Env.adsr(
			attackTime: volAtk,
			decayTime: volDec,
			sustainLevel: gate * volSus,
			releaseTime: volRel,
	), gate, 1, doneAction: 2);
	env2 = EnvGen.ar(Env.perc(0.01, fltDec, fltAmt, -4));
	out = LFPulse.ar(pitch.midicps * [1, 1.016], 0.0, 0.51, 2, -1);
	//out = BLowPass4.ar(out, ((pitch + env2).clip2(124)).midicps, fltRz,0.1);
	//out = RLPFD.ar(out, ((fltAtk + pitch + env2).midicps) * ((1 + tanh(fltRza))/2), fltRz, fltRz);
	out = RLPFD.ar(out, (fltCtf  + pitch.linlin(0, 127, 0, fltPitchMod) + env2).midicps, fltRz, fltRza);
	out = out * env1 *((totVol + amp - 15).dbamp);
	Out.ar(0, out * 4);
}).add;
)
(
SynthDef(\tb303Flip, {
	arg outBus = 0, gate = 1, pitch = 50, amp = 0.1, totVol,
	fltCtf, fltDec, fltDst, fltPitchMod, fltAmt, fltRz, fltRza,
	volAtk, volDec, volSus, volRel, volAmt;
	var env1, env2, out, tenv;
	env1 = EnvGen.ar(
		Env.adsr(
			attackTime: volAtk,
			decayTime: volDec,
			sustainLevel: gate * volSus,
			releaseTime: volRel,
	), gate, 1, doneAction: 2);
	env2 = EnvGen.ar(Env.perc(0.01, fltDec, fltAmt, -4));
	out = LFPulse.ar(pitch.midicps * [1.016, 1], 0.0, 0.51, 2, -1);
	//out = BLowPass4.ar(out, ((pitch + env2).clip2(124)).midicps, fltRz,0.1);
	//out = RLPFD.ar(out, ((fltAtk + pitch + env2).midicps) * ((1 + tanh(fltRza))/2), fltRz, fltRz);
	out = RLPFD.ar(out, (fltCtf  + pitch.linlin(0, 127, 0, fltPitchMod) + env2).midicps, fltRz, fltRza);
	out = out * env1 *((totVol + amp - 15).dbamp);
	Out.ar(0, out * 4);
}).add;
)