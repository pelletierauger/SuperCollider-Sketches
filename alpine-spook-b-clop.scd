(
~nT.sched(~nT.timeToNextBeat(quant: 8), {
    var ver = 1;
    var i = ~nT.tempo * 0.25;
    n.free;
    n = {
        | trigGate = 1 |
        var freq = 31 + 12 + 24 + -5 - 12;
        var pulse = Impulse.kr(i) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(([1, 0]).wrapExtend(4 * 6), inf));
        var engine = 2, harm = 0.125, timbre = 0.125, morph = 0.5, decay = 0.95;
        var dem = Demand.kr(trig, 0, Dseq(([3, 5, 3, 6]).stutter(16), inf));
        var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
        var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
        var env = EnvGen.kr(Env([0, 1, 0], [0.025, 0.125], [2, 8, 'lin']), trig);

        var sig1 = MiPlaits.ar(freq + [0, 0.1] + dem - 5 + 3,
            engine: 0,
            harm: harm,
            timbre: timbre,
            morph: morph,
            trigger: 0,
            decay: decay,
            lpg_colour: 0.25,
            // fm_mod: 0.25,
            // timb_mod: -0.5
            morph_mod: 0.25
        );
        var sig = [sig1[0][1], sig1[1][1]];
        // var verb = MiVerb.ar(sig * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
        // var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
        sig = sig * 0.25 + VadimFilter.ar(sig * 0.25, SinOsc.kr(6).range(1000, 3000), 0, 3);
        sig * 0.125 * 0.5;
        // VadimFilter.ar(sig, 4000, 0, 5) * Line.kr(0, 1, 0.01) * 0.125 * 0.5;
    // [sig, env];
}.play.register;
// }.plot(1);
    });
)

~off.set(\trigGate, 0, \gate, 0, \fadeTime, 10);


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    var ver = 1;
    var i = ~nT.tempo * 0.5;
    ~off.free;
    ~off = {
        | trigGate = 1 |
        var freq = 31 + 12 + 24 + -5 - 12 + -12;
        var trig = Impulse.kr(i, 0.0) * trigGate;
        var engine = 2, harm = 0.65, timbre = 0.5, morph = 0.45, decay = 0.95;
        var dem = Demand.kr(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).stutter(4), inf));
        var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
        var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
        var env = EnvGen.kr(Env([0, 1, 0], [0.0125, 0.8], [2, 'lin', 'lin']), trig);

        var sig1 = MiPlaits.ar(freq + [0, 0.1] + dem,
            engine: 2,
            harm: harm,
            timbre: timbre,
            morph: morph,
            trigger: trig,
            decay: decay
        );
        var sig = [sig1[0][1], sig1[1][1]] * env;
        // var verb = MiVerb.ar(sig * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
        var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
        sig * lfo * Line.kr(0, 1, 0.01) * 0.125;
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    var ver = 1;
    var i = ~nT.tempo * 1;
    m.free;
    m = {
        | trigGate = 1 |
        var freq = 31 + 12 + 24 + -5 - 12;
        var trig = Impulse.kr(i) * trigGate;
        var engine = 3, harm = 0.65, timbre = 0.25, morph = 0.25, decay = 0.5;
        var dem = Demand.kr(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).rotate(3).stutter(16), inf));
        var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
        var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
        var amp2 = EnvGen.kr(Env.new([0, 1, 0], [0.0125 * 0.5, 0.09], [8, -8]), trig);
        // var dem = 0;
        var sig = MiPlaits.ar(freq + dem + [0, 0.1],
            engine: engine,
            harm: harm,
            timbre: timbre,
            morph: morph,
            trigger: trig,
            // usetrigger: 1,
            decay: decay,
            lpg_colour: 0.5,
            // fm_mod: 0.25,
            timb_mod: 0.5,
            mul: 1);
        sig = [sig[0][0], sig[1][0]] * amp2.lag(0.025);
        // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
        // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
        sig = VadimFilter.ar(sig, 4000, 0, 1);
        sig;
        // var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
        // var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
        // LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 2000) + verb * Line.kr(0, 1, 0.01) * 0.5;
        // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
    }.play.register;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    var ver = 1;
    var i = ~nT.tempo * 2;
    o.free;
    o = {
        | trigGate = 1, decay = 0.5, tail = 1 |
        var freq = 31 + 12 + 24 + -5 - 0;
        var trig = Impulse.kr(i, 0.0) * trigGate;
        var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45;
        var dem = Demand.kr(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).stutter(16), inf));
        var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
        var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, 0.2 * tail], [2, 'lin', 'lin']), trig);

        // var dem = 0;
        var sig1 = MiPlaits.ar(freq + [0, 0.1] + dem,
            engine: 2,
            harm: harm,
            timbre: timbre * dem2,
            morph: dem2 * 0.5,
            trigger: trig,
            // usetrigger: 1,
            decay: decay
        );
        var sig = [sig1[0][0], sig1[1][0]] * (1 - (dem2 * 0.5)) * env;
        // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
        // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
        // var verb = MiVerb.ar(sig * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
        var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
        LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * Line.kr(0, 1, 0.01) * 0.125;
        // LPF.ar(sig, 3000) + GVerb.ar(sig, mul: 0.125 * 0.25) * Line.kr(0, 1, 0.01);
    }.play.register;
});
)


o.set(\trigGate, 0, \decay, 1, \tail, 5, \gate, 0, \fadeTime, 10);

[n, m, o, ~off].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});
