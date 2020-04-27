(   // some blowing
y = {
    var mod1 = LFNoise1.kr(0.4,0.5,0.5);
    var mod2 = LFNoise1.kr(0.2,0.5,0.5);
    var pit = LFNoise0.kr(0.1).range(32,44);
    var trig = SinOsc.kr(2).round;
    // var freq = Demand.kr(trig, 0, Dseq([5], inf));
    // freq = 5;
    // var freq = SinOsc.kr(1) * 0 + 5;
    var sig1 = MiElements.ar(gate: trig, pit: 32 + 5 + 7, contour: 0.15, blow_level: 0.2, flow: 0, blow_timb: 0.5);
    var sig2 = MiElements.ar(gate: trig, pit: 32 + 5 + 7 + 0.1, contour: 0.15, blow_level: 0.2, flow: 0, blow_timb: 0.5);
    [sig1[0], sig2[1]];
}.play;
)
y.free;
(   // some blowing
x.free;
x = {
    var mod1 = LFNoise1.kr(0.4,0.5,0.5);
    var mod2 = LFNoise1.kr(0.2,0.5,0.5);
    var pit = LFNoise0.kr(0.1).range(32,44);
    var trig = SinOsc.kr(0.25).round;
    // var freq = Demand.kr(trig, 0, Dseq([5], inf));
    // freq = 5;
    // var freq = SinOsc.kr(1) * 0 + 5;
    var sig1 = MiElements.ar(gate: trig,
        pit: 32 + 12,
        contour: 0.45,
        blow_level: 0.2,
        flow: 0.1,
        blow_timb: 0.25,
        bright: 0.45,
        // pos: 0.75,
        geom: 0.125,
        damp: 1.0,
        space: 0.1
    );
    sig1 * 4;
}.play;
)
x.free;
(   // some blowing
x = {
    var mod1 = LFNoise1.kr(0.4,0.5,0.5);
    var mod2 = LFNoise1.kr(0.2,0.5,0.5);
    var pit = LFNoise0.kr(0.1).range(32,44);
    var trig = SinOsc.kr(1).round;
    // var freq = Demand.kr(trig, 0, Dseq([5], inf));
    // freq = 5;
    // var freq = SinOsc.kr(1) * 0 + 5;
    var sig1 = MiElements.ar(gate: trig, pit: 32 + 5 + 12, contour: 0.25, blow_level: 0.1, flow: 0, blow_timb: 0) * 4;
    sig1 * 4;
}.play;
)