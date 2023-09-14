(
// ~nT.sched(~nT.timeToNextBeat(quant: 8), {
x.free;
x = {
    | trigGate = 1 |
    var t = Impulse.kr(~nT.tempo * 0.0625) * trigGate;
    var t2 = Impulse.kr(Demand.kr(Impulse.kr(1),0,Dwhite(4,64)));
    var d2 = Demand.kr(t2, 0, Drand([-1,1],inf)).lag(0.001);
    var d = Demand.kr(t, 0, Dseq([0, 1, 0, -2, 0, 1, 4, 5].stutter(1), inf));
    var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle)*0.9+0.1;
    // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
    // var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
    var shift = 0.1;
    var note = 24 + ( [0, 6, 12, 18, 24, 30, 36] * 0.1)+24+0;
    var sig = MiBraids.ar(
        pitch: note ++ (note + shift)  ++ (note + shift + 1)+12,
        timbre: 0, color: 0.5, model: 14,
        resamp: 2, decim: 22, bits: 6, ws: 0
    );
    var sigH;
    sig = Splay.ar(sig.scramble);
    // sig = ~split.(sig.scramble);
    sig = sig * Line.kr(0, 1, 1);
    sig = VadimFilter.ar(sig, 9500 * e + 150, 0, 1);
    sigH = ~v.(sig,3000,0,5)*0.5;
    sig = XFade2.ar(~v.(sig,3000,0,5)*4*1,~v.(sig.reverse,2000,0,5),pan:d2);
    Out.ar(0, sig * 0.4);
}.play;
// });
)