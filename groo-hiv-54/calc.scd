t.beatDur * 8


~nT = TempoClock.new(1 / ((1 / (122 / 60)) * 8 / 5)).permanent_(true);
1 / ((1 / (122 / 60)) * 8 / 5)
122 / 60
1 / t.beatDur


~nT.beatDur
1.39.reciprocal
~nT = TempoClock.new(1.39).permanent_(true);

1.2708333333333

~nT.tempo_(1.2708333333333);
~nT.tempo_(1.39);

1 / ((1 / (122 / 60)) * 8 / 5);