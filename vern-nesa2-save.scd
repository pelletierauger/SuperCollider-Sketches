(
~nT.sched(~nT.timeToNextBeat(quant: 4) - (~nT.beatDur * 0.5), {
    if(~toms2G.isPlaying, {~toms2G.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1)});
    ~toms2G = {
        | trigGate = 1 |
        var tr = In.kr(~cb, 2) * trigGate;
        var dd = Demand.kr(tr[0], 0, Dseq([1])); // This opens up the triggers.
        var t = tr[1] * dd;
        var trig = t;
        var trig2 = t + DelayN.kr(t, 0.5, ~nT.beatDur / 8);
        var a = Demand.kr(t, 0, Dseq([0].stutter(16), inf));
        var b = Demand.kr(t, 0, Dseq([0, 1].stutter(32), inf));
        var pat0 = [1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, 0];
        var pat1 = [1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, a, a];
        var pat2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0];
        var block0 = Demand.kr(trig, 0, Dseq(pat0, inf));
        var block1 = Demand.kr(trig, 0, Dseq(pat1, inf));
        var block2 = Demand.kr(trig2, 0, Dseq(pat2, inf));
        var blocks = (trig!3)++(trig2!1) * [block0, block1, block1, block2] * trigGate;
        var e = EnvGen.kr(Env([0,1,0],[0.001,[0.5,0.5,0.5,2]*4],[2,-8]),blocks);
        var sig = PinkNoise.ar(e)*0.5;
        sig = MiRings.ar(sig,
            pit:22-12,struct:0.25,bright:0.7,
            damp:0.5,pos:0.25,model:2);
        sig = sig[0]+[sig[1],sig[2]];
        sig = VAKorg35.ar(sig, 2000, 0.75, 0.5, 0);
        sig = ~v.(sig, 6000);
        sig*1;
    }.play(fadeTime: 0.01).register;
});
)