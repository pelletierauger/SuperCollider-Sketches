~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);



(
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var envGate = EnvGate.new();
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var env2 = EnvGen.kr(Env([-2, 0, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -3, -12, -7] + -8, inf));
    var lfo = SinOsc.kr(3).range(0.25, 0.5);
    var sig = MiPlaits.ar(
        pitch: 60 + note - 12 - 19 - 2 + 8 + [0, 0.01] + lfo,
        engine: 2,
        harm: 0.95,
        timbre: 0.75,
        morph: 1 - (lfo * 0.35)
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = VadimFilter.ar(sig, 2200 + (1000 * env), 0, 1) * 2;
    Out.ar(~reverbBus2, sig * 0.5 * envGate);
    Out.ar(0, sig * 0.1 * envGate);
}.play;
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

{
        e.set(\gate, 0, \fadeTime, 0.1);
e = {
            var envGate = EnvGate.new();
    var t = Impulse.kr(~nT.tempo * 0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.25, 0.5 - 0.2], [8, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([4], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 0 + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = VadimFilter.ar(sig, 1200, 0, 1) * 2;
    // sig = LPF.ar(sig, 400) * 2;
        Out.ar(~reverbBus2, sig * 0.5 * envGate);
    Out.ar(0, sig * 0.1 * envGate);
}.play;
        (~nT.beatDur * 2).wait;
        z.set(\gate, 0, \fadeTime, 0.1);
z = {
            var envGate = EnvGate.new();
    var t = Impulse.kr(~nT.tempo * 0.125);
    var env = EnvGen.kr(Env([0, 1, 0], [0.25, 0.5 - 0.2], [8, -8, 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([0, -3] + 2, inf));
    var sig = MiPlaits.ar(
        pitch: 60 + note + 0 + [0, 0.01],
        engine: 2,
        harm: 0.5,
        timbre: 0.75,
        morph: 1
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    // sig = LPF.ar(sig, 400) * 2;
    sig = VadimFilter.ar(sig, 1200, 0, 1) * 2;
        Out.ar(~reverbBus2, sig * 0.5 * envGate);
    Out.ar(0, sig * 0.1 * envGate);
}.play;
    }.fork;
});
)

(
        e.set(\gate, 0, \fadeTime, 0.1);
        z.set(\gate, 0, \fadeTime, 0.1);
)


~reverbBus2 = Bus.audio(s, 2);

(
~verby.free;
~verby = {
    var in = In.ar(~reverbBus2, 2);
    in = JPverbRaw.ar(
        in[0],
        in[1],
        damp: 0.5,
        earlydiff: 0.707,
        highband: 2000,
        highx: 0.2,
        lowband: 500,
        lowx: 1,
        mdepth: 2,
        mfreq: 2,
        midx: 1,
        size: 3,
        t60: 10
    );
    in = VadimFilter.ar(in, 1200 + (Amplitude.kr(in) * 1000), 0.25, 1);
    in = AnalogTape.ar(in, bias: 0.75, saturation: 1, drive: 1.2, oversample: 1, mode: 0);
    // in = VAKorg35.ar(in, 200, 0, 0, 0);
}.play;
)




(
y.set(\gate, 0, \fadeTime, 0.1);
y = {
    var t = Impulse.kr(0.25);
    var env = EnvGen.kr(Env([0, 1, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var env2 = EnvGen.kr(Env([-2, 0, 0], [0.5, 4 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq([-5, -3, -12, -7] + -8, inf));
    var lfo = SinOsc.kr(3).range(0.25, 0.5);
    var sig = MiPlaits.ar(
        pitch: 60 + note - 12 - 19 - 2 + 8 + [0, 0.01] + lfo,
        engine: 2,
        harm: 0.95,
        timbre: 0.75,
        morph: 1 - (lfo * 0.35)
    ) * 0.5 * env;
    sig = [sig[0][0], sig[1][0]];
    sig = VadimFilter.ar(sig, 2200 + (1000 * env), 0, 1) * 2;
    sig;
}.play;
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~hats.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~hats = {
        | trigGate = 1 |
        var pulse = Impulse.kr(~nT.tempo * 1 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(12) ++
            [1, 1, 1, 1].wrapExtend(4), inf)
        );
        var col = Demand.kr(trig, 0, Dseq(
            [0.7, 0.5], inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq(((3!1) * 2 ++ [2]).reverse * 0.01, inf)
        );
        var ddd = Demand.kr(trig, 0, Dseq((78.5!(6) ++ (108.5!(4))), inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.005, 0.01 * ddd], [8, -8, 'lin']), trig);

        var fil = Demand.kr(trig, 0,
            Dseq(2000!1 ++ [2000], inf)
        );
        var note = Demand.kr(trig, 0,
            Dseq([0, 0, 2, 1].stutter(6 * 2), inf)
        );
        var tim = Demand.kr(trig, 0,
            Dseq(0.65!1 ++ [0.65], inf)
        );
        var frr = Demand.kr(trig, 0, Dseq(Dstutter(1, Dseries(0, 200, 12)), inf));
        var sig = MiBraids.ar(42 + (12 * 1) - 5 + [0, 1],
            timbre: tim,
            color: col - [0.1, 0.15],
            model: 41,
            trig: trig,
            resamp: 0,
            decim: 32,
            bits: 6,
            ws: 0
        ) * env.pow(5);
        // sig = [sig[0][1], sig[1][1]];
        var lsig = VadimFilter.ar(sig, 2000, resonance: 0.2, type: 5);
        // lsig = VAKorg35.ar(sig, freq: 2300, res: 0.0, overdrive: 0.0);
        lsig = VadimFilter.ar(lsig, 6000, resonance: 0.2, type: 1);
        // lsig = VAKorg35.ar(sig, freq: 5300, res: 0.0, overdrive: 0.0);
        // lsig = VAKorg35.ar(lsig, freq: 200 + frr, res: 0.0, overdrive: 0.0);
        sig = lsig * 1 * 2 * 1.5;
                sig = Decimator.ar(sig, 1100, 12) * 0.5;
        sig = VadimFilter.ar(sig, 2 * Amplitude.kr(sig) + 4000, 0.25, 1) * 1;
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)
