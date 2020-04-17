~frequency = 440;
(
// Two points in space.
var fo = [25, -25];
var fp = [-20, 55];
var fpori = [-20, 55];
var count = 0;
var fr = 100;
var inc = 2pi / fr;
var travel = ~dist.(fp[0], fp[1], fo[0], fp[1]) * 2;
inc = 2pi / fr;
~signalSize = 44100 * 10;
a = Signal.newClear(~signalSize);
~ccc = 0;
a.do({
    |item, i|
    var a0, a1, a2, a3, d, opp, hyp, hei;
//     if (count >= travel, {count = 0; postln(~ccc); ~ccc = 0;});
    ~ccc = ~ccc + 1;
    fp[0] = fpori[0] + (count / 2pi * travel);

    // The three angles of our triangle.
    a0 = atan2(fo[1] - fp[1], fo[0] - fp[0]);
    a1 = (pi / 2) - abs(a0);
    a2 = pi / 2;
    a3 = pi - a1 - a2;

    // The distance between fo and fp.
    d = ~dist.(fp[0], fp[1], fo[0], fo[1]);
    opp = d * 0.5;
    hyp = (1 / sin(a3)) * opp;
    hei = fp[1] - hyp;

    a[i] = hei - 2.5 / 12.5 - 0.5 * 2 * 1;
    count = count + inc;
    if (count >= (2pi - inc), {count = 0; ~ccc = 0;});
});
a.plot;
// b = Buffer.loadCollection(s, a, 1, {|buf| buf.play});
b = Buffer.loadCollection(s, d, 1);
)

(
var win = ceil(44100 / ~frequency);
win = 100;
b = Signal.newClear(~signalSize);
a.do({
   |item, i|
//    b[i] = a[(i + (win * 0.5)) % win] * -1;
   b[i] = a[(i + floor(win * 0.5)) % ~signalSize] * -1;
});
b.plot;
)
f = [1, 2, 3];
f.rotate(1);


44100 / 440
(a + b).plot

(
c = Signal.newClear(~signalSize);
a.do({
   |item, i|
   c[i] = ~lerp.(a[i], b[i], 0.5);
});
c.plot;
)

(
d = Signal.newClear(~signalSize);
a.do({
   |item, i|
//    d[i] = a[i] / c[i];
    d[i] = a[i] * c[i] - 0.5;
});
d.plot;
)

(
var win = ceil(44100 / ~frequency);
var count = 0;
var cur = 1;
win = 100;
a.do({
   |item, i|
//    d[i] = a[i] / c[i];
    var def = 1;
//     if ((i % (44100) < (44100 * 0.5)), {def = -1;}, {def = 1});
    
    d[i] = (d[i] - 0.5) * cur;
    count = count + 1;
    if (count == 50, {
        cur = cur * -1;
        count = 0;
    });
});
d.plot;
)
)

101/2

(
~lerp = {
    |a, b, f|
    a + (f * (b - a));
}
)