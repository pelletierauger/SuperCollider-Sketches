(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~syyy.isPlaying, {~syyy.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~syyy = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([1, 1].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, a, a];
        var pat2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var blocks = (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate;
        var e = EnvGen.kr(Env([0.001,1,0.001],[0.5,[0.5,0.5,0.5,4]*0.25],['exp']),blocks).lag(0.01);
    var d = Demand.kr(t, 0, Drand([0,1],inf)!20).lag(1);
        var sig2, sig3;
        var scr = Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf));
    var sig = MiBraids.ar(
        22+12*((1..20)/900+1) + [0,3,7,12,15,19].wrapExtend(20)+36-12,
        timbre:~lfo.(0.01)*e.wrapExtend(20),
            color: 0.75-(0.2*e.wrapExtend(20))*e.wrapExtend(20),
        model:14,model:22).scramble;
    sig = sig * d * e.wrapExtend(20);
    sig = Splay.ar(sig) * 0.5 *2;
        sig = VAKorg35.ar(sig, 2000, 0.125, 0.125, 1);
        sig = ~v.(sig,4000) * 2 * dd.lag(0.05);
        sig = DelayC.ar(sig, 2, ~nT.beatDur*0.5);
        // sig2 = (MiWarps.ar(sig[0], PinkNoise.ar() * sig[0], 0.75, 0.25, algo: 2, timb: 0.4)[0]);
        // sig3 = (MiWarps.ar(sig[1], PinkNoise.ar() * sig[1], 0.75, 0.25, algo: 2, timb: 0.4)[0]);
        // sig3 = [sig2, sig3] * 0.25;
        // sig3 = VadimFilter.ar(sig3, scr.linlin(0, 1, 5000, 500), 0, 5) * 8;
        // sig = sig+(sig3 * Demand.kr(trig!2, 0, Dwhite(0.00, 1.00, inf)).lag(1)) * 0.5;

    }.play(fadeTime: 0.0).register;
});
)