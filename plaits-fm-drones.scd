(
var ver = 1;
var i = 20;
l.free;
l = {
    var freq = 31 + 27 + 7;
    var trig = Impulse.ar(i);
    var osc = SinOsc.kr(0.1).range(-0.1, 0.1);
    var engine = 2, harm = 0.3, timbre = 0.15 + osc, morph = 0.5 + osc, decay = 0.15;
    // var dem = 0;
    var sig1 = MiPlaits2.ar(freq,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: 0,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    var sig2 = MiPlaits2.ar(freq + 0.1,
        engine: engine,
        harm: harm,
        timbre: timbre,
        morph: morph,
        trigger: 0,
        // usetrigger: 1,
        decay: decay,
        lpg_colour: 0,
        mul: 1);
    // var sig = [sig1[0], sig2[0]] * 4;
    var sig = [sig1[0], sig2[0]] * 1;
    sig;
}.play;
)