
(

SynthDef(\ks_pluck, { arg midiPitch = 69, delayDecay = 1.0;

	var burstEnv, att = 0, dec = 0.001;

	var signalOut, delayTime;


	delayTime = [midiPitch, midiPitch + 12].midicps.reciprocal;

	burstEnv = EnvGen.kr(Env.perc(att, dec)); // here using an envelope in the exciter

	signalOut = PinkNoise.ar(burstEnv);

	signalOut = CombL.ar(signalOut, delayTime, delayTime, delayDecay, add: signalOut);

    // signalOut = SinOsc.ar(midiPitch.midicps!2, signalOut * 100 % 2pi) * signalOut;
    signalOut = LPF.ar(signalOut, 1000) * 4;
	DetectSilence.ar(signalOut, doneAction:2);

	Out.ar(0, signalOut * Line.kr(0, 1, 0.1) * SinOsc.ar(3).range(0.25, 1));

	}

).add;

)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    // num.postln;
    // var deviation = 60 - num;
    Synth.new(\ks_pluck, [\midiPitch, num, \delayDecay, 8]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)


r.stop;
(

//Then run this playback task

r = Task({

	{Synth(\KSpluck,

		[

		\midiPitch, rrand(30, 90), //Choose a pitch

		\delayDecay, rrand(0.1, 3.0) //Choose duration

		]);

		//Choose a wait time before next event

		[0.125, 0.125, 0.25].choose.wait;

	}.loop;

}).play

)