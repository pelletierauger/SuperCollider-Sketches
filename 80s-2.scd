(
z.free;
z = {
    var t = Impulse.kr(4);
    var b = t * Demand.kr(t, 0, Dseq(
        [
            1, 0, 0, 0], inf));
    var d = Demand.kr(b, 0, Dseq([0, 5, 7, 8], inf));
    var e = EnvGen.kr(Env([0.001, 1, 0.001], [0.005, 1], 'exp'), b);
    var a = [0, 0.1, 0.2, 0.3];
    var sig = MiBraids.ar(~toMidi.("E2") + d + ~lfo.(8, 0, 0.5) + a - (e*0.25),
        timbre: 0.5-a, color: 0.5+a, model: 14
    );
    sig = DelayN.ar(sig, 1, a*0.05);
    sig = ~v.(sig, 3000 * e + 500);
    sig = Splay.ar(sig, 0.5);
    sig = sig + ~v.(CombC.ar(sig*Line.kr(0,1,0.1)*0.5, 1, 0.125, 3), 1000);
    sig = sig * 0.5;
}.play;
)