


(
x.free;
x = {
    var t = Impulse.kr(2.5);
    var t2 = Impulse.kr(2.5*2);
    var d = t * Demand.kr(t, 0, Dseq(
        [1, 0, 0, 0, 1, 0, 0, 0] ++ [1, 0, 0, 0, 1, 0, 0, 0], inf));
    var f = t2 * Demand.kr(t2, 0, Dseq([1, 0], inf));
    var g = Demand.kr(t, 0, Dseq([0.1285, 0.1285, 0.85, 0.1285], inf));
    var sig = MiPlaits.ar(36-24+4, engine: 13, harm: 0.85,
    timbre: 0.275, morph: 0.95, decay: 0.95, trigger: d, fm_mod: 0.75)[0] * 0.1;
    sig = ~v.(sig, 12000) * 0.25 ! 2;
    sig = sig + ~v.(MiPlaits.ar(36+24+24, engine: 15, harm: g,
    timbre: 0.1975, morph: 0.125+(g*0.5)*0.5, decay: 0.95, trigger: f, fm_mod: 0.75)[0] * 0.05,2200,0,5);
    sig = sig * 4 + (MiWarps.ar(sig, DelayC.ar(sig,1,1/128*4), 0.25, 1.95, algo:4, timb: 1)*0.05);
    sig = ~v.(sig, 2000)*4;
}.play(fadeTime: 0);
)