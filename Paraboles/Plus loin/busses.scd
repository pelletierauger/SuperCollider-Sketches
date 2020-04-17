s.boot;
s.record;
s.stopRecording;

(
~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);
~volumeBus = Bus.audio(s, 2);
~reverbBus = Bus.audio(s, 2);
~highPassBus = Bus.audio(s, 2);
~limitBus = Bus.audio(s, 2);
"others/names.scd".loadRelative;
)

(
SynthDef.new(\reverb, {
    arg in, out = 0;
    var sig, del;
    sig = In.ar(in, 2);
    del = CombC.ar(in: sig,
    maxdelaytime: 0.1,
    delaytime: [0.25, 0.26],
    decaytime: 20,
    mul: 1, add: 0);
    del = LPF.ar(del, 800);
	sig = sig + (del * 0.25);
    sig = (sig * 0.5) + (GVerb.ar(sig) * 0.25);
    Out.ar(~limitBus, sig);
}).add;
)

(
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
)

(
SynthDef.new(\highPass, {
    arg in, out = 0;
    var sig;
    sig = In.ar(in, 2);
    sig = HPF.ar(sig, 200, 0.75);
//     sig = LPF.ar(sig, 20000);
    Out.ar(~reverbBus, sig);
}).add;
)

(
~highPassSynth.free;
~highPassSynth = Synth.new(\highPass, [\in, ~highPassBus, \out, ~reverbBus], ~fxGroup);
)

(
SynthDef.new(\limit, {
    arg in, out = 0;
    var sig, compSig;
    sig = In.ar(in, 2); 
    compSig = Compander.ar(sig, sig,
        thresh: 0.1,
        slopeBelow: 1,
        slopeAbove: 0.5,
        clampTime: 0.01,
        relaxTime: 0.01
    );
//     sig = (sig * 0.95 + (compSig * 0.025));
    sig = Limiter.ar(sig,0.97, 0.01);
    Out.ar(0, sig);
}).add;
)

(
~limitSynth.free;
~limitSynth = Synth.new(\limit, [\in, ~limitBus, \out, 0], ~fxGroup);
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
~highPassSynth.free;
~highPassSynth = Synth.new(\highPass, [\in, ~highPassBus, \out, ~reverbBus], ~fxGroup);
)