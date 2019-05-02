s.boot;
s.quit;
s.record;
s.stopRecording;
FreqScope.new(500, 500, 0, server: s);


(
~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);
~reverbBus = Bus.audio(s, 2);
~highPassBus = Bus.audio(s, 2);
~pulseBus = Bus.audio(s, 1);
~limitBus = Bus.audio(s, 2);
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
    del = LPF.ar(del, 600);
	sig = sig + (del * 0.25);
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
    sig = HPF.ar(sig, 300);
//     sig = LPF.ar(sig, 10000);
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
        thresh: 0.05,
        slopeBelow: 0.0125,
        slopeAbove: 0.125,
        clampTime: 0.01,
        relaxTime: 0.01
    );
    sig = (sig * 0.95 + (compSig * 0.75));
    sig = Limiter.ar(sig,0.97, 0.01);
    Out.ar(0, sig);
}).add;
)

(
~limitSynth.free;
~limitSynth = Synth.new(\limit, [\in, ~limitBus, \out, 0], ~fxGroup);
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
)

(
t = TempoClock.new;
t.tempo_(50 * 4/60);
)

(
SynthDef.new(\metro, {
    arg out, freq = 220, amp = 1, pan = 0, atk = 0.02, rel = 2;
    var sig, env;
//     rel = min(max(rel, 0.001), 10);
    env = EnvGen.kr(Env.new([0, 1, 0], [atk, rel]), doneAction: 2);
    sig = LFTri.ar([freq, freq + 0.1]);
    sig = sig * env * amp;
    sig = Balance2.ar(sig[0], sig[1], pan, 1);
    Out.ar(out, sig);
}).add;
)

(
~metronome.stop;
~metronome = Pbind(
    \instrument, \metro,
    \dur, 1,
    \freq, Pseq([880, 440, 440, 440] * 2, inf),
    \rel, 0.1,
    \atk, 0.0001,
    \out, 0
).play(t, quant: 4);
)

(
SynthDef.new(\pulsemetro, {
    arg out;
    var sig, env;
    env = EnvGen.kr(Env.new([1, 0], [0.1]), doneAction: 2);
    sig = Pulse.ar(1) * 0.1;
    Out.ar(out, sig);
}).add;
)

(
~pulseMet.stop;
~pulseMet = Pbind(
    \instrument, \pulsemetro,
    \dur, 16 * 2,
    \out, ~pulseBus
//     \out, [0, ~pulseBus]
).play(t, quant: 4);
)
