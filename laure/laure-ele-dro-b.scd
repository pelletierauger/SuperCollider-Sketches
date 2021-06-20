u.set(\blowLevel, 0);

(
u.free;
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    u = {
        | blowLevel = 1 |
        var trig = Impulse.kr(~nT.tempo * 0.25);
        var dem = Demand.kr(trig, 0, Dseq([0.95, 0.75].stutter(4), inf));
        var sig = MiElements.ar(
            gate: 1,
            pit: 59,
            contour: 0.5,
            bow_level: blowLevel,
            bow_timb: 0.25 + (1 - dem * 0.5),
            geom: dem,
            bright: 0.4,
            damp: 0.4,
            space: 1,
            model: 1
        );
        sig = HPF.ar(sig, 200);
        sig * 64 * 4;
        // HPF.ar(sig * 8 * 1.5, 700) * 4 * 8 * 0.85;
    }.play(fadeTime: 0.01);
});
)
(
v.free;
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    v = {
        var trig = Impulse.ar(~nT.tempo * 0.25);
        var dem = Demand.ar(trig, 0, Dseq([0.95, 0.75].stutter(4), inf));
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: 32 + 12 + 12 + 12 + 12 - 9 - 12,
            contour: 0.65,
            bow_level: 1,
            bow_timb: 0.25 + (1 - dem * 0.5),
            geom: dem,
            bright: 0.4,
            damp: 0.4,
            space: 1,
            model: 1
        );
        sig = HPF.ar(sig * 8 * 1.5, 700) * 4 * 6;
        sig = [sig[1], sig[0]] * 0.85;
    }.play(fadeTime: ~nT.beatDur * 8);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    l.set(\gate, 0, \fadeTime, 1);
    l = {
        var trig = Impulse.ar(~nT.tempo * 0.125);
        var dem = Demand.ar(trig, 0, Dseq([0.95, 0.75].stutter(4), inf));
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: 32 + 12 + 12 + 12 + 12 - 12,
            contour: 0.5,
            bow_level: 1,
            bow_timb: 0.25 + (1 - dem * 0.5),
            geom: dem,
            bright: 0.2,
            damp: 0.4,
            space: 1,
            model: 0
        );
        HPF.ar(sig * 4, 2700) * 4 * 16;
    }.play(fadeTime: 1);
});
)
l.free;


(
x = {
    // | dif = 0 |
    var sig = SinOsc.ar(440 + \dif.kr(0))!2 * 0.1;
    sig;
}.play;
)

x.set(\dif, 0);
x.set(\dif, {SinOsc.kr(0.5).range(0, 220)}.play);
x.set(\dif, {Line.kr(0, 12, 30)}.play);


v.set(\blow, {Line.kr(0, 12, 30)}.play);
(
v.free;
// v.set(\blow, 0, \fadeTime, 2);
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    v = {
        | blow = 0 |
        var trig = Impulse.ar(~nT.tempo * 0.25);
        var dem = Demand.ar(trig, 0, Dseq([0.95, 0.75].stutter(4), inf));
        var mod = LFNoise1.kr(0.3,0.5,0.5);
        var sig = MiElements.ar(
            gate: 1,
            pit: 32 + 12 + 12 + 12 + 12 - 9 - 12 + blow,
            contour: 0.65,
            bow_level: 1,
            bow_timb: 0.25 + (1 - dem * 0.5),
            geom: dem,
            bright: 0.4,
            damp: 0.4,
            space: 1,
            model: 1
        );
        sig = HPF.ar(sig * 8 * 1.5, 700) * 4 * 6;
        sig = [sig[1], sig[0]] * 0.85;
    }.play(fadeTime: 0.01);
});
)