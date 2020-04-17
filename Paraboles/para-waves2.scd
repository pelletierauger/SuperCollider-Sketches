(
var win = 100;
b = Signal.newClear(~signalSize);
a.do({
   |item, i|
   b[i] = a[(i + floor(win * 0.5)) % ~signalSize] * -1;
});
)

(
c = Signal.newClear(~signalSize);
a.do({
   |item, i|
   var lerps = i.linlin(0, ~signalSize, 0, 1);
   lerps = sin(i * 3e-2);
   c[i] = ~lerp.(a[i], b[i], lerps);
});
c.plot;
)
b = Buffer.loadCollection(s, c, 1);