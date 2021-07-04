x = Pseries(1, 1, inf).asStream;
x.next

x = (Pseries(1, 1, inf).stutter(2) + Pseq([0, 7], inf)).asStream;
x.next


(
x = Pseq([
    Pseries(0, 1, 8),
    Pseries(100, 1, 8)
], inf).asStream;
)

x.reset;
16.do({x.next.postln});