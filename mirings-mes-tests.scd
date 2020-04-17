(
// s.record;
// TempoClock.default.sched(10, {s.stopRecording; nil;});
TempoClock.default.sched(0, {
    {
    var trig = Impulse.ar(1);
    var sig = MiPlaits.ar(31 + 24 + 0 + [0, 0.1],
        engine: 11,
        harm: 0.25,
        timbre: 0.5,
        morph: SinOsc.kr(0.1).range(0.75, 0.95),
            // morph: 0.5,
        trigger: trig,
        usetrigger: 1,
        decay: 0.9,
        lpg_colour: 1,
        mul: 1);
        // sig;
        // var trig = Dust.ar(1); //Impulse.ar(1);
	var pit = Latch.ar(WhiteNoise.ar(), trig).range(30, 60);

	//var input = PinkNoise.ar(0.2);
	MiRings.ar(sig,
            trig,
            voct: 50,
            struct: 0.5,
            bright: 0.2,
            damp: 0.9,
            pos: 0.9,
            usetrigger: 0,
            bypass: 0);
    }.play;
    nil;
});
)

// ^this.multiNew('audio', sound_in, trig, voct, struct, bright, damp, pos, usetrigger, bypass).madd(mul);