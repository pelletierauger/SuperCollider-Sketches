(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    var ver = 1;
    var i = ~nT.tempo * 2;
    n.free;
    n = {
        | trigGate = 1 |
        var freq = 31 + 12 + 24 + -5 - 12;
        var trig = Impulse.kr(i) * trigGate;
        var engine = 2, harm = 0.65, timbre = 0.25, morph = 0.45, decay = 0.5;
        var dem = Demand.kr(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).stutter(16), inf));
        var dem2 = Demand.kr(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
        var amp = EnvGen.kr(Env.new([0, 1, 0], [0.05, 0.025]), trig);
        var env = EnvGen.kr(Env([0, 1, 0], [0.0125, 0.2], [2, 'lin', 'lin']), trig);

        var sig1 = MiPlaits.ar(freq + [0, 0.1] + dem,
            engine: 2,
            harm: harm,
            timbre: timbre,
            morph: morph,
            trigger: trig,
            decay: decay
        );
        var sig = [sig1[0][1], sig1[1][1]] * env;
        var verb = MiVerb.ar(sig * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
        var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
        LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo + verb * Line.kr(0, 1, 0.01) * 0.25;
    }.play.register;
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
        LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 3000) * lfo * Line.kr(0, 1, 0.01) * 0.25;
    }.play.register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    var ver = 1;
    var i = ~nT.tempo;
    m.free;
    m = {
        | trigGate = 1 |
        var freq = 31 + 12 + 24 + -5 - 12;
        var trig = Impulse.ar(i) * trigGate;
        var engine = 3, harm = 0.65, timbre = 0.25, morph = 0.25, decay = 0.5;
        var dem = Demand.ar(trig, 0, Dseq(([3, 5, 3, 6] ++ [3, 5, 8, 10]).rotate(3).stutter(16), inf));
        var dem2 = Demand.ar(trig, 0, Dseq(Pseries(0.5, 1/16, 16).asStream.nextN(16), inf));
        var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
        var amp2 = EnvGen.ar(Env.new([0, 1, 0], [0.0125 * 0.5, 0.09]), trig);
        // var dem = 0;
        var sig1 = MiPlaits.ar(freq + dem,
            engine: engine,
            harm: harm,
            timbre: timbre,
            morph: morph,
            trigger: trig,
            // usetrigger: 1,
            decay: decay,
            lpg_colour: 0,
            mul: 1);
        var sig2 = MiPlaits.ar(freq + 0.1 + dem,
            engine: engine,
            harm: harm,
            timbre: timbre,
            morph: morph,
            trigger: trig,
            // usetrigger: 1,
            decay: decay,
            lpg_colour: 0,
            mul: 1);
        var sig = [sig1[0], sig2[0]] * dem2 * amp2;
        // LPF.ar(sig, 3000) + MiVerb.ar(sig, mul: 0.125 * 0.5) * Line.kr(0, 1, 0.01);
        // LPF.ar(sig, 3000) * Line.kr(0, 1, 0.01);
        var verb = MiVerb.ar(sig * amp * Line.kr(0, 1, 0.1), diff: 0.95, mul: 0.125 * ver);
        var lfo = SinOsc.kr(0.1, [0, pi]).range(0.25, 1);
        LPF.ar(sig * (Line.kr(0, 1, 0.01).floor), 19000) + verb * Line.kr(0, 1, 0.01) * 0.5;
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
