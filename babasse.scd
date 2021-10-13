(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {

    i.set(\trigGate, 0, \gate, 0, \fadeTime, 1);
    i = {
        | trigGate = 1, freq  = 400|
        var trig, env, fil, sig;
        trig = Impulse.kr(~nT.tempo * 2) * trigGate;
        fil = SinOsc.ar(0.5!2).range(1, 0);
        env = EnvGen.kr(Env.new([0, 1, 0], [0.025, 0.2]), trig);
        sig = MiBraids.ar(
            pitch: 42 + 12 + Demand.kr(trig, 0,
                Dseq([-7, -5, 2, 0].stutter(2), inf) +
                Dseq([0, -5].stutter(32), inf)),
            timbre: 0.0,
            color: 0,
            model: 17
        );
        sig = sig * Line.kr(0, 1, 0.05);
        sig = VadimFilter.ar(sig, 50 + (freq * env), 0.25, 1) * 4;
        // sig = VAKorg35.ar(sig * 0.2, freq: 500, res: 0.1, overdrive: 0.05);
        sig!2 * 2;
    }.play;
});
)
i.set(\freq, 2500);