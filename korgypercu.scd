(
g.free;
g = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.00125, 2]), trig);
    sig = MiPlaits.ar(25 + 12 + 12 + 12 - 2,
        engine: 14,
        harm: 0.0,
        timbre: 0.2,
        morph: 0.2,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.2,
        lpg_colour: 0,
        mul: 2 * 1) * 0.25;
    sig = VAKorg35.ar(sig[0], freq: 600, res: 0.1, overdrive: 0.05);
    sig!2;
}.play;
)


(
v.free;
v = {
    var trig, amp, sig;
    trig = Impulse.ar(2);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
    sig = MiPlaits.ar(25 + 12 - 2,
        engine: 13,
        harm: 0.5,
        timbre: 0.9,
        morph: 0.4,
        trigger: trig,
        decay: 0.2,
        lpg_colour: 0,
        mul: 2) * 0.25;
    sig = sig[0];
    sig = VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05);
    sig!2;
}.play(fadeTime: 0);
)






(
w.free;
w = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(0.5!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.1, 1]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.125, 2]), trig);
    sig = MiPlaits.ar(25 + 12 + 12 + 12 - 5,
        engine: 14,
        harm: 0,
        timbre: 0.9,
        morph: 0.9,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.2,
        lpg_colour: 0,
        mul: 2 * 1) * 0.25;
        sig = VAKorg35.ar(sig[0], freq: 200, res: 0.1, overdrive: 0.05);

    sig[0]!2;
}.play;
)

(
g.free;
g = {
    var trig, env, amp, fil, sig;
    trig = Impulse.ar(2!2);
    // trig = trig + Impulse.ar(1!2, 0.25);
    // trig = trig;
    fil = SinOsc.ar(0.5!2).range(1, 0);
    env = EnvGen.ar(Env.new([0, 0.15, 0], [0.025, 0.2]), trig);
    amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.00125, 2]), trig);
    sig = MiPlaits.ar(25 + 12 + 12 + 12 - 2,
        engine: 14,
        harm: 0,
        timbre: 0.2,
        morph: 0.4,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.2,
        lpg_colour: 0,
        mul: 2 * 1) * 0.25;
    sig = VAKorg35.ar(sig[0] * env, freq: 200, res: 0.1, overdrive: 0.05);
    sig!2 * 8;
}.play;
)




(
var ver = 1;
var i = 8;
m.free;
m = {
    var freq = 31 + 12 + 24 + -4 + 5;
    var trig = Impulse.ar(i, 0.1);
    var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.25;
    var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).stutter(16), inf));
    var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig1 = MiPlaits.ar(freq + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits.ar(freq + 0.1 + dem,
        engine: 2,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig = [sig1[0], sig2[0]];
    // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
    // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
    var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
    var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
    sig = LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.25;
           sig = VAKorg35.ar(sig, freq: 200, res: 0.5, overdrive: 0.05);

    // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
}.play;
)