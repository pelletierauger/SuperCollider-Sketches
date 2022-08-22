(
a.free;
a = {
    var sig = MiBraids.ar(~toMidi.("B1") + 0 + [0, 0.1],
        timbre: 0.25, color: 0.5, model: 5
    ) * 0.4;
    sig = VadimFilter.ar(sig, 1000, 0, 1);
    sig;
}.play;
)

(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(4), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m;
    var sig = MiBraids.ar(pitch + [0, 0.1],
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 3
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24,
        struct: 0.5, bright: 0.75, damp: 0.95, pos: 0.75, model: 4, easteregg: 5);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 2000, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.25 * dd.lag(0.1);
}.play;
)



(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(4), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.5].stutter(4), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5], ['lin', 0]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1],
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 15
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 + [0, 0.1],
        struct: n, bright: 0.75, damp: 0.95, pos: 0.75, model: 4, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 2000, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.25 * dd.lag(0.1);
}.play;
)


(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.5].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.25], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 24,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 15
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24,
        struct: n, bright: 0.75, damp: 0.95, pos: 0.75, model: 4, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 20, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.25 * dd.lag(0.1);
}.play;
)




(
f.free;
f = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1, 0], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(4), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.5].stutter(4), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m;
    var sig = MiBraids.ar(pitch + [0, 0.1],
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 12
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 + [0, 0.1],
        struct: n, bright: 0.75, damp: 0.85, pos: 0.75, model: 4,
        poly: 0,
        easteregg: 5);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 2000, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig * 0.25 * dd.lag(0.1);
}.play;
)



(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.5].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.25], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 24,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 15
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24,
        struct: n, bright: 0.75, damp: 0.95, pos: 0.75, model: 4, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 20, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 2);
    sig * 0.25 * dd.lag(0.1);
}.play;
)


// synth tenace

(
e.free;
e = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[1] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var n = Demand.kr(b, 0, Dseq([0.25, 0.6].stutter(32), inf));
    var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.25], ['lin', -8]), gate: b);
    var ri;
    var pitch = ~toMidi.("B2") + m + 12;
    var sig = MiBraids.ar(pitch + [0, 0.1] + 24,
        timbre: SinOsc.kr(~nT.tempo * 0.25).unipolar * 0.2, color: 0.5, model: 15
    ) * 0.4;
    sig = MiRings.ar(sig, 0, pit: pitch - 24 - 5,
        struct: n, bright: 0.95, damp: 0.95, pos: 0.75, model: 4, easteregg: 1);
    sig = VadimFilter.ar(sig, 4000 * env.lag(0.2) + 20, 0, 1);
    // sig = (ri) + (sig * ri * 0);
    sig = MiMu.ar(sig, 2);
    sig * 0.25 * dd.lag(0.1);
}.play;
)


(
j.set(\gate, 0, \fadeTime, 0.1);
j = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12, -10, -17], inf));
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("B2") + 12 + note.lag(0.1),
        engine: 2,
        harm: 0.25,
        timbre: 0.0,
        morph: 0.2,
        decay: 1
    ) * 0.25;
    sig[1]!2 * dd.lag(0.1);
}.play;
)


//  Ligne de basse

(
j.set(\gate, 0, \fadeTime, 0.1);
j = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12, -10, -17], inf));
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("B2") + 12 + note.lag(0.1),
        engine: 2,
        harm: 0.25,
        timbre: MouseX.kr(),
        morph: MouseY.kr(),
        decay: 1
    ) * 0.25;
    sig[1]!2 * dd.lag(0.1);
}.play;
)


// Drone monophonique

(
j.set(\gate, 0, \fadeTime, 0.1);
j = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -12, -10, -17], inf));
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("B2") + 0,
        engine: 2,
        harm: 0.25,
        timbre: MouseX.kr(),
        morph: MouseY.kr(),
        decay: 1
    ) * 0.25;
    sig[1]!2 * dd.lag(0.1);
}.play;
)


//  Chord

(
j.set(\gate, 0, \fadeTime, 0.1);
j = {
    | trigGate = 1 |
    var tr = In.kr(~cb, 2) * trigGate;
    var dd = Demand.kr(tr[0], 0, Dseq([1]));
    var t = tr[0] * dd;
    var b = t * Demand.kr(t, 0, Dseq([1], inf));
    var m = Demand.kr(b, 0, Dseq([-5, -7].stutter(32), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([12, 10].stutter(8), inf)).lag(0.5);
    var sig = MiPlaits.ar(
        pitch: ~toMidi.("B2") + [0, 3, 7, note] + [0, 12, 12, 12],
        engine: 2,
        harm: 1,
        timbre: MouseX.kr(),
        morph: MouseY.kr(),
        decay: 1
    ) * 0.25;
    sig = [sig[0][1] + sig[1][1] + sig[2][1] + sig[3][1]] * 0.4!2;
    sig * dd.lag(0.1);
}.play;
)