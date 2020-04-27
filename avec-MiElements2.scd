(
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.5,
        geom: 0.5,
        space: 0.9,
        model: 1
    );
    sig * 4;
}.play;
)
k.free;
x.free;
(
x = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    // var trig = SinOsc.kr(0.5).round;
    var trig = Impulse.kr(2);
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var sig = MiElements.ar(
        gate: trig,
        pit: 32 + 12 + 12 + 12 + 5,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp,
        mallet: amp * 0.5 + 0.5,
        bow_timb: 0.5,
        bright: 0.5,
        damp: 0.4,
        geom: 0.85,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    sig * 8;
}.play;
)
(
x = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var trig = SinOsc.kr(0.5).round;
    var sig = MiElements.ar(
        gate: trig,
        pit: 32 + 12 + 7,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.35,
        geom: 0.85,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.9,
        model: 1
    );
    [sig[1], sig[0]] * 4;
}.play;
)

x.free;
(
x = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    // var trig = SinOsc.kr(0.5).round;
    var trig = Impulse.kr(2);
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var amp2 = EnvGen.kr(Env.new([0.0, 0.2, 0.0], [0.2, 0.8], [7, 2]), trig);
    // var amp3 = EnvGen.kr(Env.new([0.0, 1.0, 0.0], [0.5, 0.8], [7, 2]), trig);
    var sig = MiElements.ar(
        gate: trig,
        pit: 32 + 12 + 12 + 12,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp2,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.5,
        damp: 0.4,
        geom: 0.85,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    sig * 8;
}.play;
)
(
y.free;
y = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    // var trig = SinOsc.kr(0.5).round;
    var trig = Impulse.kr(2);
    var amp = Demand.kr(trig, 0, Dseq(Pseries(1, -1/16, 16).asStream.nextN(16), inf));
    var sig = MiElements.ar(
        gate: trig,
        pit: 32 + 12 + 12 + 12 + 5,
        contour: 0.5,
        bow_level: 0.0,
        strike_level: 0.1 * amp,
        mallet: 0.5,
        bow_timb: 0.5,
        bright: 0.5,
        damp: 0.4,
        geom: 0.85,
        pos: SinOsc.kr(1).range(0.25, 0.75),
        space: 0.7,
        model: 1
    );
    [sig[1], sig[0]] * 4;
}.play;
)

(
k.free;
k = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 12 + 12,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.25,
        geom: 0.95,
        bright: 0.2,
        damp: 0.4,
        space: 1,
        model: 1
    );
    HPF.ar(sig * 4, 700) * 4;
}.play;
)
k.free;

(
l.free;
l = {
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 0,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.25,
        geom: 0.95,
        bright: 0.2,
        damp: 0.4,
        space: 1,
        model: 1
    );
    HPF.ar(sig * 4, 700) * 8;
}.play;
)