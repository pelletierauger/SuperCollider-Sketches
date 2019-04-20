s.boot;

{ SinOsc.ar(EnvGen.kr(Env.circle([0, 1, 0], [0.01, 0.5, 0.2])) * 440 + 200) * 0.2 }.play;
{ SinOsc.ar(EnvGen.kr(Env.circle([0, 1, 0, 2, 0, 1, 0], [0.01, 0.3])) * 440 + 200) * 0.2 }.play;
{ SinOsc.ar(EnvGen.kr(Env.circle([0, 1, 0, (2..4), 0, (1..3), 0], [0.01, 0.3])) * 440 + 200).sum * 0.2 }.play; // multichannel expanded levels



e = Env([0, 1, 0], [1, 2]);
e.duration;
e.duration = 2;
e.duration;

a = {arg freq=440; SinOsc.ar(freq)*0.1}.play;



a.set(\freq, 330);
a.set(\freq, 220);

(
SynthDef("controlsWithLags", { arg freq = 440, mul = 0.12;
    Out.ar(0, SinOsc.ar([freq, freq + 1], 0, mul));
}, [30, 30]).add;
)

~aSynth = Synth("controlsWithLags", [\freq, 550, \mul, 0.1]);
~aSynth.set(\freq1, 600, \freq2, 701, \mul, 0.05);
~aSynth.set(\mul, 0.5);
~aSynth.set(\freq, 220);
~aSynth.set(\freq, 330);
~aSynth.set(\freq, 550);
"controlsWithLags".allControlNames;
~aSynth.free;

~aSynth.get(\freq, { arg value; ("freq is now:" + value + "Hz").postln; });

~globalAmp = PatternProxy(Pn(1, inf));
~globalAmp.source = Pn(0.5, inf);
~globalAmp.source.asStream.next;
~globalAmp.source.asStream.value;
SynthDescLib.global.read;
SynthDescLib.global.browse;
~aSynth.set(\mul, ~globalAmp.source.asStream.value);



(
SynthDef(\trigTest1, { |out, t_trig=0, freq=440| // t_trig creates a TrigControl
    Out.ar(out, SinOsc.ar(freq+[0,1], 0, Decay2.kr(t_trig, 0.005, 1.0)));
}, [0, 0, 4]        // lag the freq by 4 seconds (the second arg), but not t_trig (won't work anyway)
).add;
)

y = Synth(\trigTest1);
y.set(\t_trig, 1); // you can do this multiple times
y.set(\t_trig, 1, \freq, 440); // hear how the freq lags
y.free;