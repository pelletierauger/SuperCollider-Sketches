s.boot;
s.record;
s.stopRecording;

(
~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);
~reverbBus = Bus.audio(s, 2);
~limitBus = Bus.audio(s, 2);
)

(
SynthDef.new(\reverb, {
    arg in, out = 0;
    var sig, del;
    sig = In.ar(in, 2);
    del = CombC.ar(in: sig,
        maxdelaytime: 0.3,
        delaytime: [0.25, 0.251],
        decaytime: 20,
        mul: 1, add: 0);
    del = LPF.ar(del, 1600);
    // sig = sig + (del * 0.25);
/*    sig = (sig * 0.5) + (GVerb.ar(
        sig,
        roomsize: 10,
        revtime: 3,
        damping: 0.5,
        inputbw: 0.5,
        spread: 15,
        drylevel: 1,
        earlyreflevel: 0.7,
        taillevel: 0.5,
        maxroomsize: 300

    ) * 0.0025);*/
    Out.ar(~limitBus, sig);
}).add;
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);

)

(
SynthDef.new(\limit, {
    arg in, out = 0;
    var sig, compSig;
    sig = In.ar(in, 2);
    /*    compSig = Compander.ar(sig, sig,
    thresh: 0.1,
    slopeBelow: 1,
    slopeAbove: 0.5,
    clampTime: 0.01,
    relaxTime: 0.01
    );*/
    //     sig = (sig * 0.95 + (compSig * 0.025));
    sig = Limiter.ar(sig, 0.97, 0.01);
    Out.ar(0, sig);
}).add;
)

(
~limitSynth.free;
~limitSynth = Synth.new(\limit, [\in, ~limitBus, \out, 0], ~fxGroup);
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
)