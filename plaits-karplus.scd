
(
x.free;
x = {
    var freq = 31 + 12 + 24 + -5;
    var trig = In.ar(~pluckBus);
    var engine = 13, harm = 0.25, morph = 0.045, decay = 0.1;
    var amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    var sig = MiPlaits.ar(\pit.kr(60),
        engine: engine,
        harm: harm,
        timbre: \timbre.kr(0.25),
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    // var sig = [sig1[0] + sig3[0] + sig5[0] * 0.333, sig2[0] + sig4[0] + sig6[0] * 0.333];
    // sig;
    sig = [sig[0], sig[0]];
    LPF.ar(sig, 5000);
    sig = CombL.ar(sig, 0.05, \pit.kr(60).midicps.reciprocal, 9);
    // sig;
}.play;
)




(
y.free;
y = {
    var freq, trig, dem, amp, sig, engine, harm, morph, decay, timbre;
    freq = 31 + 12 + 24 + -5;
    trig = Impulse.ar(4);
    // var trig =
    dem = Demand.ar(trig, 0, Dseq([0, 7, 0, 0, 0, 7, -12, -2], inf));
    timbre = 0.25;
    timbre = Demand.ar(trig, 0, 0.25 + Dseq([0, 1, 0, 0, 0, 1, 0, 0] * 0.3, inf));
    trig = trig * Demand.ar(trig, 0, Dseq(1!7 ++ [0], inf));
    engine = 13; harm = 0.25; morph = 0.045; decay = 0.1;
    amp = EnvGen.ar(Env.new([0, 1, 0], [0.05, 0.025]), trig);
    // var dem = 0;
    sig = MiPlaits.ar(\pit.kr(30) + dem + 0,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: trig,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    // var sig = [sig1[0] + sig3[0] + sig5[0] * 0.333, sig2[0] + sig4[0] + sig6[0] * 0.333];
    // sig;
    sig = [sig[0], sig[0]];
    // LPF.ar(sig, 5000);
    sig = CombL.ar(sig, 0.05, \pit.kr(30).midicps.reciprocal, 2);
    sig;
    LPF.ar(sig, 2000);
}.play;
)

