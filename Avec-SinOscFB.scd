{SinOscFB.ar(440,MouseX.kr(0,4))*0.1}.play


{SinOscFB.ar(MouseY.kr(10,1000,'exponential'),MouseX.kr(0.5pi,pi))*0.1}.play


{SinOscFB.ar(100*SinOscFB.ar(MouseY.kr(1,1000,'exponential'))+200,MouseX.kr(0.5pi,pi))*0.1}.play


// Scope the wave form
{ SinOscFB.ar([400,301], MouseX.kr(0,4),0.3); }.scope;





(
var f = 440 * 12.midiratio;
{
    var op1 = SinOsc.ar(0.2).range(0, 1);
    var sig = SinOsc.ar(f!2, SinOscFB.ar(1.5 * f * [1, 1], 1)) * 0.1;
    sig + (SinOsc.ar(f) * 0);
}.play;
)


(
var f = 440 * -12.midiratio;
{
    var op1 = SinOsc.ar(2).range(0, 1);
    var sig = SinOsc.ar(f!2, LFSaw.ar(f) * op1) * 0.1;
    sig + (SinOsc.ar(f) * 0);
}.play;
)