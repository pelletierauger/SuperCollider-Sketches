(
{
  MoogVCF.ar(
       Pulse.ar([40,121],[0.3,0.7]),
     SinOsc.kr(LFNoise0.kr(0.42).range(0.001,2.2)).range(30,4200),0.8
)}.play(s);
)

s.boot;
// Play it with the mouse...
x = { MoogFF.ar(WhiteNoise.ar(01.1), MouseY.kr(100, 10000, 1), MouseX.kr(0, 4)) }.play(s);
x.free;

// Mmmm, throbby
(
x = {
    MoogFF.ar(
        Pulse.ar([40,121], [0.3,0.7]),
        SinOsc.kr(LFNoise0.kr(0.42).range(0.001, 2.2)).range(30, 4200),
        0.83 * 4)}.play(s);
)
x.free;

y.free;
y = {Pulse.ar([40,121], [0.3,0.7])}.play(s);

(
x = {
    var sig = Pulse.ar([40,121], [0.3,0.7]);
    var noise = LFNoise0.kr(0.42).range(0.001, 2.2);
    var osc = SinOsc.kr(noise).range(30, 4200);
    MoogFF.ar(sig, osc, 0.83 * 4)}.play(s);
)
x.free;


(
i = {
    var noise = LFNoise0.kr(0.42).range(0.001, 2.2);
    SinOsc.kr(noise).range(30, 4200);
}.plot(10);
)