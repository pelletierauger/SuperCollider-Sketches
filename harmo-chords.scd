(
d.free;
d = {
    MiBraids.ar(~toMidi.("A3") + -5, timbre: ~lfo.(0.1), color: 0.5, model: 3) * 0.025 ! 2;
}.play;
)


(
e.free;
e = {

    var sig = MiBraids.ar(~toMidi.("E4") + [0,2,3,5,-5], timbre: 0.2, color: 0.45, model: 14).sum * 0.1;
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    ~v.(sig, 2000) * 1 ! 2;
}.play;
)


(
f.free;
f = {
    MiBraids.ar(~toMidi.("E1") + [0,2], timbre: ~lfo.(0.01), color: 0.5, model: 3) * 0.05 ! 2;
}.play;
)


(
e.free;
e = {

    var sig = MiBraids.ar(~toMidi.("E4") + [0,2,3,5,-5],
        timbre: 1, color: 0.5, model: 19).sum * 0.1;
    sig = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.2, type: 0);
    ~v.(sig, 2000) * 1 ! 2;
}.play;
)
