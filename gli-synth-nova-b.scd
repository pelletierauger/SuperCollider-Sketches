MIDIClient.init;
MIDIIn.connect;

(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 6],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var env2 = EnvGen.kr(Env([0, 1], [0.1]));
    var sig = MiBraids.ar(
        pitch: pitch,
        timbre: env,
        color: [0.8, 0.95] - 0.2,
        model: 0,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    sig = sig.sum * 4;
    // sig = sig[0][0] + sig[0][1] + sig[1][0] + sig[1][1];
    // sig = (Decimator.ar(sig, 1000, 4) * 0.4);
    // sig = VadimFilter.ar(sig, 500, 0, 5);
    env = env * env2;
    sig = VadimFilter.ar(sig, 100 + (10700 * env * (0.1 + vel)), 0, 1) * 1 * env!2;
    Out.ar(0, sig * 0.1);
}).add;
)






(
MIDIIn.removeFuncFrom(\control, ~control);
~control = {arg ... args;
        args[2].postln;
    if (args[2] == 10, {
        var n = args[3] / 128;
        ~timbreSynth.set(\n, n);
        ~timbreVal = n;
        n.postln;
    });
    if (args[2] == 2, {
        var n = args[3] / 128;
        ~colorSynth.set(\n, n);
        ~colorVal = n;
        n.postln;
    });
    if (args[2] == 12, {
        var n = args[3] / 128;
        ~lfoSynth.set(\n, n);
        ~lfoVal = n;
        n.postln;
    });
};
MIDIIn.addFuncTo(\control, ~control);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    ~playedNotes[num].do({
        | item, i |
        if (item.isNil == false, {
            item.set(\releaseGate, 1);
        });
    });
    ~playedNotes[num][0] = Synth.new(
        \gliSynth, [
            pitch: num,
            vel: vel / 128
    ]);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)
(
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
~noteOff = {
    arg src, chan, num, vel;
    ~playedNotes[num].do({
        | item, i |
        if (item.isNil == false, {
            item.set(\releaseGate, 1);
        });
    });
};
MIDIIn.addFuncTo(\noteOff, ~noteOff);
)

s.record;
s.stopRecording;
~noteOn.(0, 0, 60, 0.7);
~noteOff.(0, 0, 60, 0.7);

(
~noteOn = {
    arg src, chan, num, vel;
    ~playedNotes[num].do({
        | item, i |
        if (item.isNil == false, {
            item.set(\releaseGate, 1);
        });
    });
    ~playedNotes[num][0] = Synth.new(\gliSynth, [pitch: num, vel: vel / 128]);

};
)
(
~noteOff = {
    arg src, chan, num, vel;
    ~playedNotes[num].do({
        | item, i |
        if (item.isNil == false, {
            item.set(\releaseGate, 1);
        });
    });
};
)

(
SynthDef(\mod, {
    |out = 0, n = 1|
    Out.kr(out, n);
}).add;
)

(
~timbreBus = Bus.control(s, 1);
~colorBus = Bus.control(s, 1);
~lfoBus = Bus.control(s, 1);
~timbreSynth = Synth(\mod, [out: ~timbreBus]);
~colorSynth = Synth(\mod, [out: ~colorBus]);
~lfoSynth = Synth(\mod, [out: ~lfoBus]);
~timbreVal = 0;
~colorVal = 0;
~lfoVal = 0;
)
(
("~timb:" ++ ).postln;
("~col:" ++ ~colorVal).postln;
("~lfo:" ++ ~lfoVal).postln;
([~timbreVal, ~colorVal, ~lfoVal]).postln;
)

(
basse gluante
model: 26
[ 0.4140625, 0.2890625, 0.484375 ]
)

(
        ~timbreSynth.set(\n, 0.4140625);
        ~colorSynth.set(\n, 0.2890625);
        ~lfoSynth.set(\n, 0.484375);
)

s.record;
s.stopRecording;
~recordingFolder.openOS


~modSynth.free;

~timbre = 0;
~color = 0;

(
SynthDef(\gliSynth, {
    | trigGate = 1, releaseGate = 0, pitch = 60, vel = 1 |
    var lfo;
    var env = EnvGen.kr(
        Env(
            levels: [1, 1, 0],
            times: [0.001, 4.3],
            curve: ['lin', -8],
            releaseNode: 1
        ),
        gate: Trig.kr(releaseGate),
        doneAction: 2
    );
    var env2 = EnvGen.kr(Env([0, 1], [0.1]));
    var sig = MiBraids.ar(
        // pitch: pitch + ((0..5)/40 * (1 - env)),
        // pitch: pitch + [0, 7],
        // pitch: pitch + [0, 19],
        pitch: pitch,
        timbre: In.kr(~timbreBus, 1),
        color: In.kr(~colorBus, 1),
        model: 26,
        resamp: 0,
        decim: 32,
        bits: 2,
        ws: 0
    );
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
    // sig[1] = VadimFilter.ar(sig[1], 1500, 0, 1);
    // sig = sig.sum;
    // sig = Splay.ar(sig);
    sig = sig * 4;
    env = env * env2;
    lfo = SinOsc.kr(1).unipolar * 1500;
    // sig = VadimFilter.ar(sig, 100 + (10700 * In.kr(~lfoBus, 1) * env * (0.1 + vel)), 0.25, 1) * env;
    Out.ar(0, sig * 0.1!2 * safeEnv * env);
}).add;
)
