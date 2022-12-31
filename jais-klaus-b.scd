(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
n.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
n = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq(
 //     [1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0]
        [1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0]
        , inf));
    var note = Demand.kr(t, 0, Dseq([27, 26].stutter(32), inf));
    var morph = Demand.kr(b, 0, Dseq([0.5, 0.5, 0.5, 0, 1].rotate(1), inf));
    var levv = Demand.kr(b, 0, Dseq([0.25, 0, 0, 0, 0.35].rotate(1), inf));
    var dec = Demand.kr(b, 0, Dseq([0.8, 0.6, 0.6, 0.6, 0.8].rotate(1), inf));
    var m = Demand.kr(b, 0, Dseq([0.35, 0.4], inf));
    var m2 = Demand.kr(b, 0, Dseq([0.5, 0.51], inf));
    var level = b.lag(0.1) * m2 * 2 + (b * 0);
    var sig = MiPlaits.ar(
        pitch: note + 12,                 engine: 10,
        harm: 0.95,                timbre: 0.25,                 morph: 0,
        trigger: b,                /*level: level.lag(0.05),*/
        fm_mod: 0.5,      timb_mod: 0,                  morph_mod: -0.5,
        decay: 0.35
            ,                lpg_colour: 0.5
   ).sum * dd.lag(0.05);
     sig = [sig, DelayC.ar(sig, 0.5, 0.01)];
    sig = sig + ([sig[1], sig[0]] * 0.5);
    sig = sig * 0.4 * 2 * 2;
    sig = VadimFilter.ar(sig, 50, 0, 5) * 2 * dd.lag(0.05);
        sig = CombC.ar(sig, 1, (note-0).midicps.reciprocal*[1,1.01], 4);
        // sig = CombC.ar(sig, 1, (note-0).midicps.reciprocal*1.01, 4);
        sig = ~v.(sig, 3000, 0, 3);
            sig = MiRings.ar(sig!2,
            pit: 27+0+note+[0,0.1]+0, struct: 0.65, bright: 0.85,
            damp: 0.76, pos: 0.25, model: 1) * 0.5 + (sig * 0.25)*1;
   /* sig = AnalogVintageDistortion.ar(
        input: sig,
        drivegain: 0.5, bias: 0.2, lowgain: 0.8, highgain: 0.3,
        shelvingfreq: (27 + 48 + 48 + 12).midicps, oversample: 0
    ) * 0.1;
                sig = ~v.(sig, 3000, 0, 5);
            sig = MiRings.ar(sig!2,
            pit: 27+0+note+[0,0.1]+0, struct: 0.65, bright: 0.5,
            damp: 0.76, pos: 0.25, model: 1) * 0.5 + (sig * 0.25)*2;*/
}.play(fadeTime: 0);
});
)
