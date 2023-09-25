~t = TempoClock.new(1).permanent_(true);

(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n;
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 10,
        timbre: 0.25,
        color: [0.8, 0.95] - 0.2,
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 4,
        ws: 0
    )[0];
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
    sig!2 * 1 * 3;
}.play(fadeTime: 0.01).register;
)


(
if(~crushedNoise2.isPlaying, {~crushedNoise2.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise2 = {
    | trigGate = 1 |
    var sig, env, delrd, r, n;
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 10,
        timbre: 0.25,
        color: [0.8, 0.95] - 0,
        model: 37,
        resamp: 2,
        decim: 32,
        bits: 4,
        ws: 0
    )[0];
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(4).range(0, 1000), 0, 5);
    sig!2 * 1 * 3;
}.play(fadeTime: 0.01).register;
)



(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n;
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 10, timbre: 0.25, color: [0.8, 0.95] - 0.2,
        model: 37,
        resamp: 2, decim: 2, bits: 4, ws: 0
    )[0];
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
    sig!2 * 1 * 3;
}.play(fadeTime: 0.01).register;
)

(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n, t, note;
    t = Impulse.kr(0.125);
    note = Demand.kr(t, 0, Dseq([0], inf));
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 30 + note + [0, 0.1], timbre: 0.75, color: [0.8] - 0.2,
        model: 37,
        resamp: 2, decim: 2, bits: 4, ws: ~lfo.(0.25)*1
    );
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 3000), 0, 1);
    sig * 1 * 3;
}.play(fadeTime: 0.01).register;
)



(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n, t, note;
    t = Impulse.kr(0.125);
    note = Demand.kr(t, 0, Dseq([0], inf));
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 30 + note + [0, 0.1], timbre: 0.75, color: [0.8] - 0.3,
        model: 37,
        resamp: 2, decim: 2, bits: 4, ws: ~lfo.(0.25)*1
    );
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 3000), 0, 1);
    sig * 1 * 3;
}.play(fadeTime: 0.01).register;
)



(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n, t, note;
    t = Impulse.kr(0.125);
    note = Demand.kr(t, 0, Dseq([0], inf));
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 30 + note + [0, 0.1], timbre: 0.75, color: [0.8] - 0.3,
        model: 37,
        resamp: 2, decim: 2, bits: 4, ws: ~lfo.(0.25)*1
    );
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 3000), 0, 3);
    sig * 1 * 1;
}.play(fadeTime: 0.01).register;
)



(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n, t, note;
    t = Impulse.kr(0.125);
    note = Demand.kr(t, 0, Dseq([0], inf));
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 30 + note + [0, 0.1], timbre: 0.75, color: [0.8] - 0.3,
        model: 37,
        resamp: 2, decim: 2, bits: 4, ws: ~lfo.(0.25)*1
    );
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
    sig = MiRings.ar(sig, pit: 30);
    sig * 1 * 0.25;
}.play(fadeTime: 0.01).register;
)

// Korg Volca Modular-like
(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n, t, note;
    t = Impulse.kr(0.125);
    note = Demand.kr(t, 0, Dseq([0], inf));
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 30 + note - 6 + [0, 12] + ~lfo.(3), timbre: 0.75, color: [0.8] - 0.3,
        model: 37,
        resamp: 2, decim: 22, bits: 6, ws: ~lfo.(0.25)*1
    ).sum;
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
    sig!2 * 4 * 3 * 0.05 + (~v.(sig,1000,0,3)*0.5) * 0.5;
}.play(fadeTime: 0.01).register;
)





(
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});
~crushedNoise = {
    | trigGate = 1 |
    var sig, env, delrd, r, n, t, note;
    t = Impulse.kr(0.125);
    note = Demand.kr(t, 0, Dseq([0], inf));
    r = 0.01;
    n = (~t.tempo * 0.125).reciprocal;
    env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
    sig = MiBraids.ar(
        pitch: 24 + note - 12 + 9 + [0, 12] + ~lfo.(3), timbre: 0.175, color: [0.8] - 0.3,
        model: 37,
        resamp: 2, decim: 2, bits: 2, ws: ~lfo.(0.25,0,0)*1
    ).sum;
    sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
    sig!2 * 4 * 3 * 0.05 + (~v.(sig,1000,0,3)*0.5) * 0.125;
}.play(fadeTime: 0.01).register;
)