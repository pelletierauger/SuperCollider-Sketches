(
x.free;
x = {
        | trigGate = 1|
        var tr = ~tks.(1, trigGate);
        var dd = tr[1];
        var t = (tr[0]) * dd;
        var trig = t;
    var safeEnv = EnvGen.kr(Env([0,0,1], [0.009,0.001]));
    var sig = MiBraids.ar(27+1, 0.5, ~lfo.([3,3.1],0.5,0.55), model: 14);
    ~v.(sig,200) * 0.3 * Line.kr(0,1,0.125) * safeEnv * dd.lag(0.1);
}.play;
)