(
~nT.sched(~nT.timeToNextBeat(quant: 2) - (~nT.beatDur * 0.5), {
m.set(\trigGate, 0, \gate, 0, \fadeTime, 15);
m = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
 //     [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
        [1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0].rotate(4)
        , inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: 27 + 12 + 12,    engine: 9,
        harm: 0.95,             timbre: 0.95,           morph: 0,
        trigger: b + DelayN.kr(b, 1, [1,2]*0.01).sum,             /*level: level.lag(0.05),*/
        fm_mod: 0.5,            timb_mod: 0.5,           morph_mod: 0.5,
        decay: 0.65,            lpg_colour: 0.25
   )[1] * dd.lag(0.05);
     sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 2;
    sig = VadimFilter.ar(sig, 100, 0, 5) * 0.35 * dd.lag(0.05);
}.play(fadeTime: 0);
});
)