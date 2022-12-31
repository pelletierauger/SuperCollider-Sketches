(
 {
    var t = Impulse.kr(0.5);
    var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
    var sig = MiBraids.ar(
        32+12*((1..20)/400+1) + [0,3,7,14,15].wrapExtend(20),
        timbre:~lfo.(0.01),
        color: 0.75,
        model:38).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 0.1 * 0.5;
}.play;
)


(
 {
    var t = Impulse.kr(0.5);
    var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
    var sig = MiBraids.ar(
        32+12*((1..20)/400+1) + [0,3,7,14,15].wrapExtend(20),
        timbre:~lfo.(0.01),
        color: 0.75,
        model:42).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 0.1;
}.play;
)


(
 {
    var t = Impulse.kr(0.5);
    var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
    var sig = MiBraids.ar(
        32+24*((1..20)/400+1) + [0,3,7,14,15].wrapExtend(20),
        timbre:~lfo.(0.01),
        color: 0.75,
        model:42).scramble;
    sig = sig * d;
    sig = Splay.ar(sig) * 1;
    sig = ~v.(sig,1000,0,5);
}.play;
)