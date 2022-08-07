
~path = PathName.new("/Users/guillaumepelletier/Desktop/ponts-stereo.aiff");

~path.pathOnly.openOS

b = Buffer.read(s, ~path.fullPath);
Safety(s).disable


s.record;
s.stopRecording;
~recFolder.openOS



~cl = TempoClock.new(68 / 60).permanent_(true);


(
~x.free;
~x = {
    Impulse.ar(~cl.tempo * 2) * 0.1!2;
}.play;
)


(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
    var trig = Impulse.kr(~cl.tempo);
    var trig3 = trig * Demand.kr(trig, 0, Dseq((1!1) ++ (0!11), inf));
    var delTrig = DelayN.kr(trig, 1, 0.580);
    var sig = XPlayBuf.ar(2, b, 1, trigger: trig3, startPos: 0, loop: -1);
    sig + (K2A.ar(delTrig) * 0.75!2);
}.play;
)


(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
    var trig = Impulse.kr(~cl.tempo);
    var trig3 = trig * Demand.kr(trig, 0, Dseq((1!1) ++ (0!9), inf));
    var delTrig = DelayN.kr(trig, 1, 0.580);
    var sig = XPlayBuf.ar(2, b, 1, trigger: trig3, startPos: 0, loop: 0, fadeTime: 0.5);
    var click = (K2A.ar(delTrig) * 0.75!2);
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, ~cl.beatDur - 0.025], [2, -8, 'lin']), delTrig);
    // MiWarps.ar(carrier: sig, modulator: K2A.ar(e), lev1: 0.5, lev2: 0.5,
    //     algo: 5, timb: 0.25, osc: 0, freq: 110, vgain: 1, easteregg: 0
    // ) * 0.1;
    MiRings.ar(WhiteNoise.ar()!2 * e * 0.01,
        pit: ~toMidi.("A2") + 12, struct: 0.25, bright: 0.5,
        damp: 0.7, pos: 0.25, model: 2
    ) * 2 + (sig * 0.5) * 6;
}.play;
)



(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
    var trig = Impulse.kr(~cl.tempo);
    var trig3 = trig * Demand.kr(trig, 0, Dseq((1!1) ++ (0!9), inf));
    var delTrig = DelayN.kr(trig, 1, 0.580);
    var sig = XPlayBuf.ar(2, b, 1, trigger: trig3, startPos: 0, loop: 0, fadeTime: 0.5);
    var click = (K2A.ar(delTrig) * 0.75!2);
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, ~cl.beatDur - 0.025 * 3], [2, -8, 'lin']), delTrig);
    // MiWarps.ar(carrier: sig, modulator: K2A.ar(e), lev1: 0.5, lev2: 0.5,
    //     algo: 5, timb: 0.25, osc: 0, freq: 110, vgain: 1, easteregg: 0
    // ) * 0.1;
    var n = Demand.kr(delTrig, 0, Dseq([0, -2], inf));
    var mel = MiBraids.ar(pitch: ~toMidi.("A2") + n, timbre: 0.5, color: 0.5, model: 5) * e.lag(1);
    mel = VadimFilter.ar(mel, 2000, 0, 1);
    MiRings.ar(WhiteNoise.ar()!2 * e * 0.01,
        pit: ~toMidi.("A2") + 0 - 2, struct: 0.25, bright: 0.5,
        damp: 0.7, pos: 0.25, model: 2
    ) * 2 + (sig * 0.5) * 6 + DelayN.ar((mel * 0.5 * 0.5!2) * 0, 1, ~cl.beatDur * 0.5);
}.play;
)


(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
    | freeze = 0 |
    var trig = Impulse.kr(~cl.tempo);
    var trig3 = trig * Demand.kr(trig, 0, Dseq((1!1) ++ (0!9), inf));
    var delTrig = DelayN.kr(trig, 1, 0.580);
    var sig = XPlayBuf.ar(2, b, 1, trigger: trig3, startPos: 0, loop: 0, fadeTime: 0.5);
    var click = (K2A.ar(delTrig) * 0.75!2);
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, ~cl.beatDur - 0.025], [2, -8, 'lin']), delTrig);
    // MiWarps.ar(carrier: sig, modulator: K2A.ar(e), lev1: 0.5, lev2: 0.5,
    //     algo: 5, timb: 0.25, osc: 0, freq: 110, vgain: 1, easteregg: 0
    // ) * 0.1;
    var sig2 = MiRings.ar(
        WhiteNoise.ar()!2 * e * 0.01,
        pit: ~toMidi.("A2") + 12, struct: 0.25, bright: 0.5,
        damp: 0.7, pos: 0.25, model: 2
    ) * 2;
    sig2 = MiWarps.ar(carrier: sig2, modulator: sig, lev1: 0.5, lev2: 0.5,
        algo: 3, timb: 0.6, osc: 0, freq: 110, vgain: 1, easteregg: 0
    );
    sig2 * 2 + (sig * 0.125);
}.play;
)