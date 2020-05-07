Nes2Square

s.boot
w.free;
w = {Nes2DMC.ar(Impulse.kr(4), MouseX.kr(0, 1), MouseY.kr(0, 15))}.play

{Nes2DMC.ar(Impulse.kr(10), 1, SinOsc.kr([SinOsc.kr(0.05, pi, 0.5, 1.5).round, 1], 0, 7.5, 7.5).round(SinOsc.kr(0.19, 0, 2.5, 2.5)))}.play


{Nes2Square.ar(Impulse.kr(10), MouseX.kr(0, 3), 0, 1, MouseY.kr(0, 15))}.play
{Nes2Square.ar(Impulse.kr(10), 0, 1, 1, 10, 1, MouseX.kr(0, 7), 0, MouseY.kr(0, 7))}.play
{Nes2Square.ar(Impulse.kr(2), 0, 0, 1, 10, 1, 2, 1, 4, MouseX.kr(0, 1023), MouseY.kr(0, 31))}.play
w.free;
w = {Nes2Square.ar(Impulse.kr(10), SinOsc.kr([11, 8], 0, 1.5, 1.5), 0, 1, LFSaw.kr(0.4, [1, 0.7], -7.5, 7.5), 1, 6, 1, SinOsc.kr(0.08, 0, 3.5, 3.5))}.play

w = {Nes2Square.ar(Dust.kr(3), 2, 1, 1, 10, 1, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(0.3, 100, 200)).dup * 0.25}.play

w.free;
(
i.free;
i = {
    var sig = Nes2Square.ar(Dust.kr(3), 2, 1, 1, 10, 1, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(0.3, 100, 200)).dup * 0.25;
    MiRings2.ar(sig, pit: 31 + 12 - 5);
}.play
)

Nes2Noise

{Nes2Noise.ar(Impulse.kr(2), 1, MouseX.kr(0, 1), MouseY.kr(0, 15))}.play
{Nes2Noise.ar(Impulse.kr(10), 0, 1, 10, MouseX.kr(0, 1), MouseY.kr(0, 15))}.play
{Nes2Noise.ar(Impulse.kr(2), 0, 0, 10, 0, MouseX.kr(0, 15), MouseY.kr(0, 31))}.play

{Nes2Noise.ar(Impulse.kr(4), SinOsc.kr([11, 8], 0, 0.5, 0.5)>SinOsc.kr(0.2, 0, 0.5, 0.5), 0, SinOsc.kr(0.1, pi, 0.5, 0.5)>0.1, 1, SinOsc.kr(0.25, 0, 20, 20).round(5)+1, 31)}.play

(
w.free;
w = {
    var sig = Nes2Noise.ar(Dust.kr(30), 0, 0, LFNoise0.kr(3, 3.5, 3.5), LFNoise0.kr(3, 0.5, 0.5), LFNoise0.kr(3, 3, 4), LFNoise0.kr(0.3, 15.5, 15.5)).dup * 0.25;
    MiRings2.ar(sig, pit: 31 + 12 - 5);
}.play;)