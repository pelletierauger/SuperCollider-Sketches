(
{
    var lfo0 = SinOsc.kr(0.5).range(0.25, 0.75);
    var lfo1 = SinOsc.kr(0.6).range(0.25, 0.05);
    var lfo2 = SinOsc.kr(0.7).range(0.25, 0.01);
    var lfo3 = SinOsc.kr(0.8).range(0.05, 0.35);
    var lfo4 = SinOsc.kr(0.9).range(0.25, 0.75);
    Biquad.ar(LFTri.ar(440 * [1, 1.01]), lfo0, lfo1, lfo2, lfo3, lfo4) * 1}.play;
)

{LFTri.ar(440 * [1, 1.01]) * 0.1}.play;

(
{
    var lfo0 = SinOsc.kr(0.5).range(0.25, 0.75);
    var lfo1 = SinOsc.kr(0.6).range(0.25, 0.05);
    var lfo2 = SinOsc.kr(0.7).range(0.25, 0.01);
    var lfo3 = SinOsc.kr(0.8).range(0.05, 0.35);
    var lfo4 = SinOsc.kr(0.9).range(0.25, 0.75);
    Biquad.ar(LFTri.ar(440 * [1, 1.01]), lfo0, lfo1, lfo2, lfo3, lfo4) * 1}.play;
)

(
{
    var lfo0 = SinOsc.kr(0.5).range(0.25, 0.75);
    var lfo1 = SinOsc.kr(0.6).range(0.25, 0.05);
    var lfo2 = SinOsc.kr(0.7).range(0.25, 0.01);
    var lfo3 = SinOsc.kr(0.8).range(0.05, 0.35);
    var lfo4 = SinOsc.kr(0.9).range(0.25, 0.75);
    Biquad.ar(LFTri.ar(440 * [1, 1.01]), lfo0, lfo1, lfo2, lfo3, lfo4) * 1}.play;
)

{LFTri.ar(440 * [1, 1.01]) * 0.1}.play;

(
{
    var lfo0 = SinOsc.kr(0.5).range(0.25, 0.75);
    var lfo1 = SinOsc.kr(0.6).range(0.75, 0.05);
    var lfo2 = SinOsc.kr(0.7).range(0.25, 0.01);
    var lfo3 = SinOsc.kr(0.8).range(0.05, 0.35);
    var lfo4 = SinOsc.kr(0.9).range(0.25, 0.75);
    Biquad.ar(LFTri.ar(440 * [1, 1.01] * 0.5 * 7.midiratio), 0.1, 0, lfo1, 0.7, 0.2) * 1}.play;
)