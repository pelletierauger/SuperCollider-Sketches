MiOmi

(    // basic
{ MiOmi.ar(pit: 50, level1:1, level2:0.5, ratio1:0.49, fm1:0.5) }.play
)


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
    var filtmod = LFTri.kr(0.23).range(0,0.1);
    var gate = LFPulse.kr(10,0,0.2);
    var cf = LFTri.kr(0.2).range(0.25, 0.75);
    MiOmi.ar(0, gate, pit: 48 + 7 + 4 - 9, contour: 0.1, fm1: 0.15, fm2: 0.15, fb: 0.5, strength: 0,
        filter_mode: filtmod, cutoff: cf, env: 0.5) * 2;
}.play
)

(   // filter and cutoff modulation
y.free;
y = {
    var filtmod = LFTri.kr(0.23).range(0,0.1);
    var gate = LFPulse.kr(10,0,0.2);
    var cf = LFTri.kr(0.2).range(0.25, 0.75);
    var dem = Demand.kr(gate, 0, Dseq(([0, 2, 5, -2]).stutter(16), inf));
    MiOmi.ar(0, gate, pit: 48 + 7 + 4 - 9 + 19 + dem, contour: 0.1, fm1: 0.15, fm2: 0.15, fb: 0.5, strength: 0,
        filter_mode: filtmod, cutoff: cf, env: 0.5) * 2;
}.play
)



(   // cross feedback
{
    var xfb = LFTri.kr(0.2).range(0,1);
    MiOmi.ar(pit: 43, xfb: xfb)
}.play
)