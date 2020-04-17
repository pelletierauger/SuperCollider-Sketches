(
// Two points in space.
var fo = [25, -25];
var fp = [-20, 55];
var fpori = [-20, 55];
var count = 0;
var fr = 44100 / 440;
var inc = 2pi / fr;
var travel = ~dist.(fp[0], fp[1], fo[0], fp[1]) * 2;
var startY = 55;
var endY = 155;
var diffY = (endY - startY) / fr;
var curY = 0;
var si = 1;
inc = travel / fr;
a = Signal.newClear(44100 * 10);
a.do({
    |item, i|
    var a0, a1, a2, a3, d, opp, hyp, hei, so1, so2, lerps;
    
    count = count + inc;
    if (count >= travel, {count = 0; si = si * -1;});
    curY = curY + diffY;
    
    fp[0] = fpori[0] + count;
//     fp[1] = curY;
   
    // The three angles of our triangle.
    a0 = atan2(fo[1] - fp[1], fo[0] - fp[0]);
    a1 = (pi / 2) - abs(a0);
    a2 = pi / 2;
    a3 = pi - a1 - a2;
    
    // The distance between fo and fp.
    d = ~dist.(fp[0], fp[1], fo[0], fo[1]);
    opp = d * 0.5;
    hyp = (1 / sin(a3)) * opp;
    hei = fp[1] - hyp;
    so1 = hei - 2.5 / 12.5 - 0.5 * 2 * 0.1;
    so2 = (hei - 2.5 / 12.5 - 0.5 * 2 * 0.1).pow(32) * 1e30;
    lerps = i / (44100 * 10);
//     a[i] = so2;
    a[i] = ~lerp.(so1, so2, abs(sin(i / 16000)));
//     a[i] = sin(count / travel * 4);
});
// a.plot;
b = Buffer.loadCollection(s, a, 1);
)


(
~lerp = {
    |a, b, f|
    a + (f * (b - a));
}
)