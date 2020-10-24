
(
SynthDef(\fm3mc_perc,{| gate=1 vel=0.7 |

	var f,ff0,ff1,ff2,a,b,c,d,e, modInd,t, aa;
	var osc,signal;
	f = \freq.kr(100);
	e = EnvGen.kr(Env.perc(
		Rand(0.8,1.2)* \att.kr(0.015),
		\rel.kr(4.02),
		curve: \curve.kr(-4)
	),
		gate: gate,
		doneAction:2
	) * vel;

	e = e * PinkNoise.ar(1!2).range( 0.1, 1 ).lag(0.01);

	ff0 = f * \f0ratio.kr(2) + { Rand(-3,3) }.dup;
	ff1 = f * \f1ratio.kr(2) + { Rand(-3,3) }.dup;
	ff2 = f * \f2ratio.kr(4) + { Rand(-3,3) }.dup;

	b = SinOsc.ar(ff0) * f * \modInd0.kr(1) * Line.ar(1, 20, 10);
	c = SinOsc.ar(ff1) * f * \modInd1.kr(0.6) * e.pow(1.4);
	d = SinOsc.ar(ff2) * f * \modInd2.kr(0.3) * e.pow(2.5);
	a = SinOsc.ar(
		f
        + LFTri.ar(e.pow(0.5) * LFNoise1.kr(0.3).range(1,5), Rand(0.0, 2pi), mul: e.pow(0.2) *  f * 0.005)
		+ [b].sum
        + WhiteNoise.ar(f/8!2).lag(0.001)
	);

	a = HPF.ar(a*e.pow(0.5), f);
	a = MidEQ.ar(a, f*\midEQratio.kr(5), rq:e.pow(0.5)* \rq.kr(3.5) + 0.1, db: \boostAtten.kr(-32));

	osc = a * \pgain.kr(0.1);
	osc = OnePole.ar(osc, \onepole.kr(0.8));
	Out.ar(0, osc * 4);
}).add;
)

Synth.new(\fm3mc_perc, [\freq, 55, \curve, -8, \modInd0, 8, \rel, 2]);
Synth.new(\fm3mc_perc_nonoise, [\freq, 220]);


(

SynthDef(\fm3mc_perc_nonoise,{| gate=1 vel=0.7 |

	var f,ff0,ff1,ff2,a,b,c,d,e, modInd,t, aa;
	var osc,signal;

	f = \freq.kr(100);
	// f = f.clip(20,900);

	e = EnvGen.kr(Env.perc(
		Rand(0.8,1.2)* \att.kr(0.015),
		\rel.kr(4.02),
		curve: \curve.kr(-4)
	),
		gate: gate,
		doneAction:2
	) * vel;

    // e = e * PinkNoise.ar(1!2).range( 0.1, 1 ).lag(0.01);

	ff0= f * \f0ratio.kr(2)
	+ { Rand(-3,3) }.dup
	;
	ff1= f * \f1ratio.kr(2)
	+ { Rand(-3,3) }.dup
	;
	ff2= f * \f2ratio.kr(4)
	+ { Rand(-3,3) }.dup
	;


	b = SinOsc.ar(ff0) * f * \modInd0.kr(1) * e.pow(0.8);
	c = SinOsc.ar(ff1) * f * \modInd1.kr(0.6) * e.pow(1.4);
	d = SinOsc.ar(ff2) * f * \modInd2.kr(0.3) * e.pow(2.5);
	a = SinOsc.ar(
		f
		+ LFTri.ar(e.pow(0.5) * LFNoise1.kr(0.3).range(1,5), Rand(0.0,2pi), mul: e.pow(0.2) *  f * 0.005)
		+ [b,c,d].sum
		+ WhiteNoise.ar(f/8!2).lag(0.001)
	);

	a = HPF.ar(a*e.pow(0.5), f);
	a = MidEQ.ar(a, f*\midEQratio.kr(5), rq:e.pow(0.5)* \rq.kr(3.5) + 0.1, db: \boostAtten.kr(-32));



	osc = a * \pgain.kr(0.1);
	osc = OnePole.ar(osc, \onepole.kr(0.8));
	Out.ar(0,osc * 4);


}).add;
)