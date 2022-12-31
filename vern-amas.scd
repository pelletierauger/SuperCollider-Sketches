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
        31+12*((1..20)/400+1) + [0,3,7,14,15].wrapExtend(20),
        timbre:~lfo.(0.01),
        color: 0.75,
        model:38).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 0.5 * 0.5;
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
 ~amasAmythists.free;
 ~amasAmythists =
    {        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0] * dd * Demand.kr(tr[0]*dd,0, Dseq([1,0,0,0] ++(0!4),inf));
    var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
    var sig = MiBraids.ar(
        31+12*((1..20)/400+1) + [0,3,7,14,15].wrapExtend(20),
        timbre:~lfo.(0.01),
        color: 0.75,
        model:42).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 1.6;
}.play;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
 ~amasAmythistZ.free;
 ~amasAmythistZ =
    {        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[0] * dd * Demand.kr(tr[0]*dd,0, Dseq([1,0,0,0] ++(0!4),inf));

     var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
    var sig = MiBraids.ar(
        31+24*((1..20)/400+1) + [0,3,7,14,15].wrapExtend(20),
        timbre:~lfo.(0.01),
        color: 0.75,
        model:42).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 1;
    sig = ~v.(sig,1000,0,5);
}.play;
});
)