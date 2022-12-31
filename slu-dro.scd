(
a.free;
a = {
    var sig = MiBraids.ar(27 + 12 + 7 + [0, 0.1, 0.25, 0.3],
        timbre: ~lfo.(~nT.tempo*16,0,0.2), color: 0.75, model: 3,
        resamp: 2, decim: 3,
        bits: 0,
        ws: 0
    ).sum * 0.5!2;
    ~v.(sig, 3000, 0, 3) * 4;
}.play;
)


(
b.free;
b = {
    var sig = MiBraids.ar(27 + 12 + 0 + [0, 0.1, 0.25, 0.3],
        timbre: ~lfo.(~nT.tempo*16,0,0.2), color: 0.75, model: 3,
        resamp: 2, decim: 6,
        bits: 0,
        ws: 0
    ).sum * 0.5!2;
    ~v.(sig, 3000, 0, 3) * 4;
}.play;
)