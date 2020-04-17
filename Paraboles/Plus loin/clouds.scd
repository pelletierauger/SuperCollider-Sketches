// grimpant, joyeux
(
var sr = 44100;
a = Signal.newClear(sr * 4);
a.do({
    |item, i|
//     var y = sin(i / sr);
    var samp = 0;
    var t = i;
    var xx = 0;
    100.do({
        |item, i|
        var ti = t.linlin(0, sr * 4, 0, 0.01);
        var x = cos(t * sin(i * ti) + sin(i * 1e-5) + xx) * i * 2 * ti;
        var y = sin(t * sin(i * ti) + sin(i * 1e-5) + xx) * i * 2 * ti;
        var angle = atan2(x, y);
        var di = ~dist.(0, 0, x, y);
        xx = x;
        samp = samp + (sin(angle * di) * 1e-3);
    });
    a[i] = samp * 100;
    }
);
a.plot;
)



// basse un peu losangée
(
var sr = 44100;
a = Signal.newClear(sr * 8);
a.do({
    |item, i|
//     var y = sin(i / sr);
    var samp = 0;
    var t = i;
    var xx = 0;
    var yy = 0;
    100.do({
        |item, i|
        var ti = t.linlin(0, sr * 4, 0, 0.001);
        var x = cos(t * 1e-2 * cos(i * ti) + sin(i * ti * 1e-1) + xx) * i * 0.5 * ti;
        var y = sin(t * 1e-2 * sin(i * ti) + sin(i * ti * 1e-1) + yy) * i * 0.5 * ti;
        var angle = atan2(x, y);
        var di = ~dist.(0, 0, x, y);
        xx = x;
        yy = y;
        samp = samp + (sin(angle * di * 1e-1) * 1e-3);
    });
    a[i] = samp * 100;
    }
);
a.plot;
)
(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \sampler,
    \dur, Pseq([4], inf),
    \rate, Pseq([0, 5].midiratio, inf),
    \amp, 8,
    \atk, 0.1,
    \rel, 4,
    \spos, 0.025
).play;
)


// note soutenue, belle
(
var sr = 44100;
a = Signal.newClear(sr * 16);
a.do({
    |item, i|
//     var y = sin(i / sr);
    var samp = 0;
    var t = i;
    var xx = 0;
    var yy = 0;
    10.do({
        |item, i|
        var ti = t.linlin(0, sr * 4, 0, 0.0001);
        var x = cos(t * 1e-2 * cos(i * ti)) * i;
        var y = sin(t * 1e-2 * sin(i * ti)) * i;
        var angle = atan2(x, y);
        var di = ~dist.(0, 0, x, y);
        xx = x;
        yy = y;
        samp = samp + (sin(angle + di) * 1e-3);
    });
    a[i] = samp * 100;
    }
);
a.plot;
)

(
~muds3.stop;
~muds3 = Pbind(
    \instrument, \sampler,
    \dur, Pseq([0.125], inf),
    \rate, Pseq([0].midiratio, inf) * [0, 7].midiratio,
    \amp, 0.25,
    \atk, 0.5,
    \rel, 2,
    \spos, 0.5 + Pwhite(-0.2, 0.4, inf)
).play;
)

// prev plus pincements

(
var sr = 44100;
a = Signal.newClear(sr * 16);
a.do({
    |item, i|
//     var y = sin(i / sr);
    var samp = 0;
    var t = i;
    var xx = 0;
    var yy = 0;
    10.do({
        |item, i|
        var ti = t.linlin(0, sr * 4, 0, 0.001);
        var x = cos(t * 1e-2 * cos(i * ti)) * i;
        var y = sin(t * 1e-2 * sin(i * ti)) * i;
        var angle = atan2(x, y);
        var di = ~dist.(0, 0, x, y);
        xx = x;
        yy = y;
        samp = samp + (sin(angle + di) * 1e-3);
    });
    a[i] = samp * 100;
    }
);
a.plot;
)


(
var sr = 44100;
a = Signal.newClear(sr * 4);
a.do({
    |item, i|
//     var y = sin(i / sr);
    var samp = 0;
    var t = i;
    var xx = 0;
    10.do({
        |item, i|
        var ti = t.linlin(0, sr * 4, 0, 0.01);
        var x = cos(t * sin(i * ti) + sin(i * 1e-5) + xx) * i * 2 * ti;
        var y = sin(t * sin(i * ti) + sin(i * 1e-5) + xx) * i * 2 * ti;
        var angle = atan2(x, y);
        var di = ~dist.(0, 0, x, y);
        xx = x;
        samp = samp + (sin(angle * di) * 1e-3);
    });
    a[i] = samp * 100;
    }
);
a.plot;
)