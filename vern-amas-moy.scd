(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
 ~amasAmythist.free;
 ~amasAmythist =
    {        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0] * dd * Demand.kr(tr[0]*dd,0, Dseq([1,0,0,0] ++(0!4),inf));

    var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
    var sig = MiBraids.ar(
        31+12*((1..20)/1600+1) + [0,7,12,15].wrapExtend(20),
        timbre:~lfo.(0.01)*0.1,
        color: 0.125,
        model:38).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 0.5 * 0.5;
        sig = ~v.(sig, 6000);
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
 ~amasAmythist.free;
 ~amasAmythist =
    {        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0] * dd * Demand.kr(tr[0]*dd,0, Dseq([1,0,0,0] ++(0!4),inf));

    var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
    var d2 = Demand.kr(t, 0, Dseq([0,-5].stutter(4),inf)).lag(0.01);
    var sig = MiBraids.ar(
        31+d2*((1..20)/1600+1) + [0,7,12,15].wrapExtend(20),
        timbre:~lfo.(0.01)*0.1,
        color: 0.25,
        model:38).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 0.5 * 1;
        sig = ~v.(sig, 6000);
}.play;
});
)