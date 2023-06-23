(   // external FM
k.free;
k = {
    var fmfreq = MouseX.kr(2, 1000);
    var fmamp = MouseY.kr(0, 1);
    var extFM = SinOsc.ar(fmfreq,0,fmamp);
    MiOmi.ar(extFM, pit: ~toMidi.("Db2"), fm1: 0.5, fm2: 0.5, xfb: 0.1, cutoff: 0.9)}.play
)




(   // external FM
{
        var t = Impulse.kr(7);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2], [2, -8]), t);
    var fmfreq = MouseX.kr(2, 1000);
    var fmamp = MouseY.kr(0, 1);
    var extFM = SinOsc.ar(fmfreq, 0, fmamp);
    MiOmi.ar(extFM, pit: 68 + [0,3, 10], fm1: 0.5, fm2: 0.5, xfb: 0.1,
        filter_mode: 0,

        cutoff: 0.2 * env, reson: 0.5).sum * 1;
}.play
)



(   // external FM
{
        var t = Impulse.kr(7);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2], [2, -8]), t);
    var d = Demand.kr(t, 0, Dseq([5, 3].stutter(32), inf));
    var fmfreq = MouseX.kr(2, 1000);
    var fmamp = MouseY.kr(0, 1);
    var extFM = SinOsc.ar(fmfreq, 0, fmamp);
    var sig = MiOmi.ar(extFM, pit: 68 + [0,d, 10], fm1: 0.5, fm2: 0.5, xfb: 0.1,
        filter_mode: 0.5,

        cutoff: 0.2 * env, reson: 0.5).sum * 1;
    ~v.(sig, 2000, 0, 5);
}.play
)