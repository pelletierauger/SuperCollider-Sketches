(
p = Pbind(
    \degree, Pseq([1, 2, 3], 1),
    \dur, Pseq([0.5, 0.75, 1], 2)
).asStream;
)

p.next(Event.new);


a = (x: 6, y: 7, play: { (~x * ~y).postln });
a.play;

a.partialEvents;

~x;
~y;
a.addEventType(\happy, {"I’m happy!".postln;});

a.happy();