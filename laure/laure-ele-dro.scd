(
u.free;
~nT.sched(~nT.timeToNextBeat(quant: 4), {
u = {
    var trig = Impulse.ar(~nT.tempo * 0.25);
        var dem = Demand.ar(trig, 0, Dseq([0.95, 0.75].stutter(4), inf));
    var mod = LFNoise1.kr(0.3,0.5,0.5);
    var sig = MiElements.ar(
        gate: 1,
        pit: 32 + 12 + 12 + 12 + 12 - 9 - 12,
        contour: 0.5,
        bow_level: 1,
        bow_timb: 0.25 + (1 - dem * 0.5),
        geom: dem,
        bright: 0.4,
        damp: 0.4,
        space: 1,
        model: 1
    );
    HPF.ar(sig * 8 * 1.5, 700) * 4 * 8 * 0.85;
}.play(fadeTime: ~nT.beatDur * 8);
});
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