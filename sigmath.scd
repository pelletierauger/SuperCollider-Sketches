(
a = Signal.newClear(256);
a.waveFill({ arg x, old, i; sin(x)}, 0, 3pi);
a.waveFill({ arg x, old, i; old * sin(11 * x + 0.3) }, 0, 3pi);
a.waveFill({ arg x, old, i; old * (x % 4) }, 0, 3pi);

a.plot;
)

a.play;


2.pow(18) / 44000
(
a = Signal.newClear(2.pow(18));
)


440 hz = 440 cycles par seconde
il ya 44100 samples par seconde
440 / 44100
(
var r = 1/16 * -12.midiratio;
a.waveFill({
   |x, old, i|
    sin(i * r * 0.5 + (tan(i * r * 0.5) * sin(i * 2e-5).linlin(-1, 1, 0, 0.5))) * 0.1;
});
)

a.plot
a.play;
~b = Buffer.loadCollection(s, a)
~b.numFrames;
~b.play;

sin(2pi)
1 / 440
1 /

(
{
    SinOsc.ar(440) * 0.1;
}.play
)
(
var r = 1 / 440;
a.waveFill({
   |x, old, i|
    sin(i / 16 * 0.midiratio);
});
)