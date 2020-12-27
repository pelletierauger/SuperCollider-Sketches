(   // external FM
{
    var fmfreq = MouseX.kr(2, 1000);
    var fmamp = MouseY.kr(0, 1);
    var extFM = SinOsc.ar(fmfreq,0,fmamp);
    MiOmi.ar(extFM, pit: 40, fm1: 0.5, fm2: 0.5, xfb: 0.1, cutoff: 0.9)}.play
)


(   // filter and cutoff modulation
x.free;
x = {
    var filtmod = LFTri.kr(0.23).range(0,1);
    var gate = LFPulse.kr(4,0,0.2);
    var cf = LFTri.kr(0.2).range(0,0.5);
    MiOmi.ar(0, gate, pit: 48 - 12, contour: 0.3, fm1: 0.95, fm2: 0.95, fb:0.5, strength: 0,
        filter_mode: filtmod, cutoff: cf, env: 0.5)
}.play
)


(   // cross feedback
{
    var xfb = LFTri.kr(0.2).range(0,1);
    MiOmi.ar(pit: 43, xfb: xfb)
}.play
)