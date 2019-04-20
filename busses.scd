s.boot;

s.plotTree;


(
SynthDef.new(\blip, {
	arg out, fund = 300, dens = 2, decay = 0.2;
	var freq, trig, sig, lfo;
	freq = LFNoise0.kr(3).exprange(fund, fund * 4).round(fund);
	sig = SinOsc.ar([freq, freq+1]) * 0.25;
	trig = Dust.kr(dens);
	sig = sig * EnvGen.kr(Env.perc(0.01, decay), trig);
	// lfo = SinOsc.kr(freq / 300);
	// sig = sig * lfo;
	Out.ar(out, sig);
}).add;

SynthDef.new(\reverb, {
	arg in, out = 0;
	var sig;
	sig = In.ar(in, 2);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.01);
	Out.ar(out, sig);
}).add;
)

s.options.numAudioBusChannels;
s.options.numOutputBusChannels;
s.options.numInputBusChannels;
s.meter;

(
x = Synth.new(\blip, [\out, ~reverbBus], ~sourceGroup);
y = Synth.new(\reverb, [\in, ~reverbBus], ~fxGroup);
)

(
~sourceGroup = Group.new;
8.do{
	Synth.new(
		\blip,
		[
			\out, ~reverbBus,
			\fund, exprand(60, 300).round(30)
		],
		~sourceGroup
	);
}
)

~sourceGroup.set(\dens, 100);
~sourceGroup.set(\decay, 0.015);

~sourceGroup.free;

s.plotTree;
~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);
(
x.free;
y.free;
)


~reverbBus = Bus.audio(s, 1);
~reverbBus.index;