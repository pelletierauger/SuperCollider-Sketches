(
a = { |tempo=1| Ringz.ar(Impulse.ar(tempo), [501, 500], 1/tempo) * 0.05 }.play;
t = TempoBusClock(a);
Task { loop { "klink".postln; 1.wait } }.play(t);
);

t.tempo = 1.3;
t.tempo = 0.5;
t.tempo = 1.0;
t.beatDur;
t.tempo
t.tempo


({Impulse.ar(t.tempo) * 0.5!2}.play;)