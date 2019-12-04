(
SynthDef.new(\reverb, {
    arg in, out = 0, amount = 0.2;
    var sig, del;
    sig = In.ar(in, 2);
    del = CombC.ar(in: sig,
        maxdelaytime: [0.05, 0.09] * 1,
    delaytime: [0.25, 0.4],
    decaytime: 20,
    mul: 1, add: 0);
    // del = LPF.ar(del, 2400);
    sig = sig + (del * amount);
    sig = LPF.ar(sig, 2500) + (GVerb.ar(sig) * 0.05);
    Out.ar(~limitBus, sig);
}).add;
)

(
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0, \amount, 0.075], ~fxGroup);
)

~reverbBus2 = Bus.audio(s, 2);
(
SynthDef.new(\reverb2, {
    arg in, out = 0, amount = 0.2;
    var sig, del;
    sig = In.ar(in, 2);
    del = CombC.ar(in: sig,
        maxdelaytime: [0.05, 0.09] * 0.5,
    delaytime: [0.25, 0.4],
    decaytime: 20,
    mul: 1, add: 0);
    // del = LPF.ar(del, 2400);
    sig = sig + (del * amount);
    sig = LPF.ar(sig, 900) + (GVerb.ar(sig, 50, 6, 0.5, 0.5, 30) * 0.2);
    Out.ar(~limitBus, sig);
}).add;
)

(
~reverbSynth2.free;
~reverbSynth2 = Synth.new(\reverb2, [\in, ~reverbBus2, \out, 0, \amount, 0.075], ~fxGroup);
)