(
~twn2.free;
~twn2 = {
    var note = 46+12+24+24 + ((0..9)/10);

    var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
    var sp = 12;
    var t = Impulse.kr(sp);
    var d = Demand.kr(t, 0, Dstutter(Drand((0..8),inf), Dxrand((16..32),inf)));
    var d2 = Demand.kr(t, 0, Dstutter(Drand((0..8),inf), Dxrand((-10..-1200),inf)));
    var e2 = EnvGen.kr(Env.perc(0.01,sp/1-0.01,1,d2),gate:t);
    var rr = Rand(0.92,0.96!note.size);
    var sig = MiBraids.ar(note, timbre: rr, color: 0.54, model: 2,
        resamp: 2, decim: d, bits: 6, ws: e2
    );
    sig = ~v.(~split.(sig),7000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,(~lerp.(8000*e2,8000,0.5))+10)*8.5*4*4*e2;
    sig = ~v.(sig, 3000,0,5)*4*2;
    sig = MiRings.ar(sig, pit: 46,
        struct: 0.125, bright: 0.5, damp: 0.7,
        pos: 0.95, model: 0
    )*2+sig;
}.play;
)


(
~twn2.free;
~twn2 = {
    var note = 46+12+24+24 + ((0..9)/10);

    var e = EnvGen.kr(Env.sine(dur: 24, level: 1).circle);
    var sp = 12;
    var t = Impulse.kr(sp);
    var d = Demand.kr(t, 0, Dstutter(Drand((0..8),inf), Dxrand((16..32),inf)));
    var d2 = Demand.kr(t, 0, Dstutter(Drand((0..8),inf), Dxrand((-10..-1200),inf)));
    var e2 = EnvGen.kr(Env.perc(0.01,sp/1-0.01,1,d2),gate:t);
    var rr = Rand(0.92,0.96!note.size);
    var sig = MiBraids.ar(note, timbre: rr, color: 0.54, model: 42,
        resamp: 2, decim: d, bits: 6, ws: e2
    ) * 0.1;
    sig = ~v.(~split.(sig),7000,0,5)* 0.125*1 * (note.size.reciprocal);
    sig = ~v.(sig,(~lerp.(8000*e2,8000,0.5))+10)*8.5*4*4*e2;
    sig = ~v.(sig, 3000,0,5)*4*2;
    sig = MiRings.ar(sig, pit: 46,
        struct: 0.125, bright: 0.5, damp: 0.7,
        pos: 0.95, model: 0
    )*2+sig;
}.play;
)