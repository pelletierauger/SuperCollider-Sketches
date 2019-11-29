(
SynthDef("help_PlayBuf", { arg out=0,bufnum=0;
	var trig, env, fr = 86.125;
	trig = Impulse.kr(fr);
    // env = EnvGen.kr(Env.circle([0, 1], [0.001, fr - 0.001]), doneAction: 2);
    env = EnvGen.kr(
        Env(
            levels: [0, 0, 1, 1, 0],
            times: [0.001, 0.001, 1 / fr - 0.006, 0.001],
            curve: 8
        ),
        gate: trig
    );
	Out.ar(out,
		PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * 0.midiratio, trig, 32000, 0) * env
	)
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)


(
SynthDef("help_PlayBuf", { arg out=0,bufnum=0;
	var trig, env, fr = 53.125 * (1 / 0.midiratio);
	trig = Impulse.kr(fr);
    // env = EnvGen.kr(Env.circle([0, 1], [0.001, fr - 0.001]), doneAction: 2);
    env = EnvGen.kr(
        Env(
            levels: [0, 0, 1, 1, 0],
            times: [0.001, 0.001, 1 / fr - 0.004, 0.001],
            curve: 8
        ),
        gate: trig
    );
	Out.ar(out,
		PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * 0.midiratio, trig, 25000, 0) * env
	)
}).play(s,[\out, 0, \bufnum, b.bufnum]);
)