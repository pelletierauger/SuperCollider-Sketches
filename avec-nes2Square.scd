Nes2Triangle
Nes2Square

b = {Nes2Triangle.ar(Impulse.kr([1, 1]), MouseX.kr(0, 1), MouseY.kr(0, 127), 110 * 2.midiratio) * 0.4}.play;
b.free;

b = {Nes2Square.ar(Impulse.kr(4 * [1, 1]), MouseX.kr(0, 3), 0, 1, MouseY.kr(0, 15), envdecay: 1, freq: 440) * 0.2}.play;

c = {Nes2Square.ar(Impulse.kr(4 * [1, 1]), MouseX.kr(0, 3), 0, 1, MouseY.kr(0, 15), envdecay: 1, freq: 440 * -5.midiratio) * 0.2}.play;
c.free;

d = {Nes2Square.ar(Impulse.kr(4 * [1, 1]), MouseX.kr(0, 3), 0, 1, MouseY.kr(0, 15), envdecay: 1, freq: 440 * -12.midiratio) * 0.2}.play;
d.free;