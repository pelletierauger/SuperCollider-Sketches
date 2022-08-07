(
a = [2, 3, 4, 6].choose;
g = 0!(a - 1) ++ [1];
a = [2, 3, 4, 6].choose;
f = 1!(a - 1) ++ [0];
g = (g ++ f).wrapExtend(16);
~hearCB.free;
~hearCB = {
    var in = In.kr(~cb, 2);

    var sig, dem, sig2;
    in = in + (DelayN.kr(in, 1, ~nT.beatDur * 0.125));
    dem = Demand.kr(in, 0, Dseq(1 - g, inf));
    // in = in * dem;
    sig = K2A.ar(in * dem) * 1;
    // sig2 = K2A.ar(in * (1 - dem)).sum!2;
    // sig[1] = sig[1];
    sig = sig[0] + sig[1] * 1!2;
    sig = VadimFilter.ar(sig, 2000, 0, 5) * 4;
    // sig2 = MiRings.ar(sig2, pit: 40 - 2, struct: 0.5, bright: 0.8,damp: 0.5, pos: 0.05, model: 2) * 1 * 2;
    sig = MiRings.ar(sig, pit: 40 - 2 , struct: 1, damp: 0.7, pos: 0.05, model: 2) * 8 * 2;
    sig;
}.play;
g;
)

[ 1, 0, 1, 1, 1, 0 ]
[ 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0 ]


(
a = [2, 3, 4, 6].choose;
g = 1!(a - 1) ++ [0];
g.wrapExtend(16);
)