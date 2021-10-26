~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 4) * 1, {
    ~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~k = {
        | trigGate = 1 |
        var envGate = EnvGate.new();
        var pulse = Impulse.kr(~nT.tempo * 0.5 * 4) * trigGate;
        var t = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 0, 0, 0, 1, 0, 1] ++
            [1, 0, 0, 0, 0, 1, 0, 1]
            , inf));
        // var env = EnvGen.kr(Env([0, 1, 0], [0.001, 0.125 * 1], [2, -8, 'lin']), t);
        // var note = Demand.kr(t, 0, Dseq([-6, -6, -10], inf));
        var sig = MiBraids.ar(
            pitch: 42 - 0 + Demand.kr(t, 0, Dseq([0, 0, -1], inf)),
            timbre: 0.9,
            color: 0.3,
            model: 34,
            trig: t,
            resamp: [0, 2],
            decim: 32,
            bits: Demand.kr(t, 0, Dseq([2, 4, 6], inf)),
            ws: 1
        );
        sig = (sig[0] + (sig[1] * 0.2 * sig[0]));
        // sig = LPF.ar(sig, 4400);
        sig = VadimFilter.ar(sig, 400 + 2000, resonance: 0, type: 1);
        sig * 2 * 2!2;
    }.play;
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4) * 0, {
    ~lush.set(\pulseGate, 0, \gate, 0, \fadeTime, 0.1);
    ~lush = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 2) * pulseGate;

        var env = EnvGen.kr(
            Env([0, 1, 0], [0.01, ~nT.tempo / 2 - 0.01], [8, -8, 'lin']
        ), t);
        var v = Demand.kr(t, 0, Dseq([
            [-12, 0, 3, 7],
            ([-12, 0, 3, 7] - 5)
        ].stutter(16), inf));
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + 12 + 0 + v.wrapExtend(8) + [0, 0.1].stutter(4) + -6,
            timbre: 0.89,
            color: 0.1 + lfo,
            model: 11,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        );
        // var cen = sig[(8..11)].sum * 0.75;
        var lfo2 = SinOsc.kr(0.25 * 0.25).range(0, 1);
        var step = Demand.kr(t, 0, Dseq(((0..15)/16 * 1).reverse, inf));
        sig = [sig[(0..3)].sum, sig[(4..7)].sum] * 0.25;
        //sig = sig[0]!2;
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(280.0, 500.0) + 4000, res: 0, transition: 0);
        // sig = VA1Pole.ar(sig, freq: 100, feedback: -0.1, type: 0);
        sig = sig * Line.kr(0, 1, 0.1) * env;
        sig = VadimFilter.ar(sig, 100 + (env * 2000 * step), resonance: 0.25, type: 1) * 4;
        // sig = VAKorg35.ar(sig, freq: 1200, res: 0.0, overdrive: 0.0);

        sig = sig;
        // Splay.ar(sig.scramble);
    }.play(fadeTime: 0.1);
});
)


// ------------------------------------------------------------------------
// Les roues de l’autobus qui tournent très rapidement.
// ------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4) * 1, {
    ~roues.set(\pulseGate, 0, \gate, 0, \fadeTime, 0.1);
    ~roues = {
        | pulseGate = 1 |
                    var envGate = EnvGate.new();

        var t = Impulse.kr(~nT.tempo * 4) * pulseGate;

        var env = EnvGen.kr(
            Env([0, 1, 0], [0.01, ~nT.tempo / 4 - 0.01], [8, -8, 'lin']
        ), t);
        var y = Demand.kr(t, 0, Dseq([7, 5, 9, 5].stutter(8), inf));
        var y2 = Demand.kr(t, 0, Dseq([7, 5, 10, 5].stutter(8), inf));
        var z = Demand.kr(t, 0, Dseq([3, 2].stutter(8), inf));
        var v = Demand.kr(t, 0, Dseq([
            [-12, 0, z, y],
            ([-5, 0, z, y2] - 5)
        ].stutter(64), inf));
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + 12 + 12 + v.wrapExtend(8) + [0, 0.1].stutter(4) + -6,
            timbre: 0.89,
            color: 0.1,
            model: 11,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        );
        // var cen = sig[(8..11)].sum * 0.75;
        var lfo2 = SinOsc.kr(0.25 * 0.25).range(0, 1);
        var step = Demand.kr(t, 0, Dseq(((0..63)/64 * 1).reverse, inf));
        var ffff = Demand.kr(t, 0, Dseq(Dstutter(8 * 4, Dwhite(0, 0.25, inf)), inf));
        sig = [sig[(0..3)].sum, sig[(4..7)].sum] * 0.25;
        //sig = sig[0]!2;
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(280.0, 500.0) + 4000, res: 0, transition: 0);
        // sig = VA1Pole.ar(sig, freq: 100, feedback: -0.1, type: 0);
        sig = sig * Line.kr(0, 1, 0.1) * env;
        sig = VadimFilter.ar(sig, 100 + (env * 1000 * step), resonance: 0.25, type: 1) * 4;
        // sig = VAKorg35.ar(sig, freq: 1200, res: 0.0, overdrive: 0.0);

        sig = sig;
                Out.ar(~reverbBus2, sig * ffff.lag(0.1) * envGate);
    Out.ar(0, sig * 1 * envGate);
        // Splay.ar(sig.scramble);
    }.play(fadeTime: 0.01);
});
)


// ------------------------------------------------------------------------
// La grenouille qui vit aux abords du ruisseau.
// ------------------------------------------------------------------------


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 1), {
    ~grenouille.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
    ~grenouille = {
        | trigGate = 1 |
                            var envGate = EnvGate.new();

        var trig, env, amp, fil, sig;
        trig = Impulse.kr(~nT.tempo * 1) * trigGate;
        // trig = trig + Impulse.ar(1!2, 0.25);
        // trig = trig;
        fil = SinOsc.ar(0.5!2).range(1, 0);
        env = EnvGen.kr(Env.new([0, 0.15, 0], [0.025, 0.2]), trig);
        amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.00125, 2]), trig);
        sig = MiPlaits.ar(59 + Demand.kr(trig, 0, Dseq([-7, -5, 0, -2].stutter(8), inf)),
            engine: 14,
            harm: 0,
            timbre: 0.2,
            morph: 0.4,
            trigger: trig,
            // usetrigger: 1,
            decay: 0.2,
            lpg_colour: 0,
            mul: 2 * 1) * 0.5;
        sig = sig * Line.kr(0, 1, 0.05);
        sig = VAKorg35.ar(sig * env, freq: 4200, res: 0.1, overdrive: 0.05);
        sig = sig!2 * 4;
                        Out.ar(~reverbBus2, sig * 0.5 * envGate);
    Out.ar(0, sig * envGate);
    }.play;
});
)

// ------------------------------------------------------------------------
// Basse grasse
// ------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {

    ~basse.set(\gate, 0, \fadeTime, 0.1);
    ~basse = {
        | freq  = 400|
        var trig, env, amp, fil, sig;
        trig = Impulse.kr(~nT.tempo * 2);
        // trig = trig + Impulse.ar(1!2, 0.25);
        // trig = trig;
        fil = SinOsc.ar(0.5!2).range(1, 0);
        // env = EnvGen.kr(Env.new([0, 0.15, 0], [0.025, 0.2]), trig);
        // amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.00125, 2]), trig);
        sig = MiBraids.ar(42 - 12 + Demand.kr(trig, 0,
            Dseq(
                [-7, -5, 2, 0].stutter(2), inf)
            + Dseq([0, -5].stutter(32), inf)),
        timbre: 0.0, color: 0, model: 17);
        /*    sig = MiPlaits.ar(59 - 24 - 12 + Demand.kr(trig, 0,
        Dseq(
        [-7, -5, 2, 0].stutter(2).wrapExtend(16)
        // [-7, -5, 2, 0].stutter(2).wrapExtend(16)
        , inf) + Dseq([0, -5].stutter(32), inf)),
        engine: 0,
        harm: 0.75 + Demand.kr(trig, 0, Dseq([0, -0.2].stutter(1), inf)),
        timbre: 0.5,
        morph: 0.6,
        trigger: trig,
        // usetrigger: 1,
        decay: 0.5,
        lpg_colour: 0,
        mul: 2 * 1) * 0.5;*/
        // SinOsc.kr(0.1).exprange(80.0, 1000.0)
        // sig = VAKorg35.ar(sig, freq: 80 + (500 - (env * 500)), res: 0.1, overdrive: 0.05);
        sig = sig * Line.kr(0, 1, 0.1);
        sig = VadimFilter.ar(sig, freq, 0.25, 1) * 4;
        // sig = VAKorg35.ar(sig * 0.2, freq: 2200, res: 0.1, overdrive: 0.05);
        sig!2 * 2;
    }.play;
});
)
~basse.set(\freq, 500);

(
~bassModder = Task {
    {
        ~basse.set(\freq, Pseries(z));
        [1, 2, 4].choose.wait;
    }.loop;
}.start(~nT, quant: [4]);
)
~bassModder.stop;

(
~nT.sched(~nT.timeToNextBeat(quant: 4) * 0, {
    ~lush.set(\pulseGate, 0, \gate, 0, \fadeTime, 0.1);
    ~lush = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 1) * pulseGate;

        var env = EnvGen.kr(
            Env([0, 1, 0], [0.05, ~nT.beatDur * 1 - 0.05], [8, -2, 'lin']
        ), t);
        var v = Demand.kr(t, 0, Dseq([
            [-12, 0, 3, 7],
            ([-12, 0, 3, 7] - 5)
        ].stutter(16), inf));
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + 12 + -24 + v.wrapExtend(8) + [0, 0.1].stutter(4) + -6,
            timbre: 0.89,
            color: 1,
            model: 11,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        );
        // var cen = sig[(8..11)].sum * 0.75;
        var lfo2 = SinOsc.kr(0.25 * 0.25).range(0, 1);
        var step = Demand.kr(t, 0, Dseq(((0..15)/16 * 1).reverse, inf));
        sig = [sig[(0..3)].sum, sig[(4..7)].sum] * 0.25;
        //sig = sig[0]!2;
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(280.0, 500.0) + 4000, res: 0, transition: 0);
        // sig = VA1Pole.ar(sig, freq: 100, feedback: -0.1, type: 0);
        sig = sig * Line.kr(0, 1, 0.1) * env;
        sig = VadimFilter.ar(sig, 100 + (env * 2000 * step), resonance: 0.25, type: 1) * 4;
        // sig = VAKorg35.ar(sig, freq: 1200, res: 0.0, overdrive: 0.0);

        sig = sig * 4;
        // Splay.ar(sig.scramble);
    }.play(fadeTime: 0.1);
});
)

(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
    ~lushZ.set(\pulseGate, 0, \gate, 0, \fadeTime, 10.1);
    ~lushZ = {
        | pulseGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * pulseGate;
        var env = EnvGen.kr(Env([0, 1, 0], [1, 5] * 4, [-8, -8, 'lin']), t);
        var lfo = SinOsc.kr(0.25).range(0.1, 0.2) * 1.5;
        var sig = MiBraids.ar(
            48 + -12 + -6 + Demand.kr(t, 0, Dseq([0, -5], inf)),
            timbre: 0.89,
            color: 0.8 + lfo,
            model: 43,
            resamp: 0,
            decim: 32,
            bits: 2,
            ws: 0
        );
        // var cen = sig[(8..11)].sum * 0.75;
        var lfo2 = SinOsc.kr(0.25).range(0, 1);
        // sig = cen!2 + [sig[(0..3)].sum, sig[(4..7)].sum] * 0.25;
        //sig = sig[0]!2;
        // sig = VASEM12.ar(sig, freq: SinOsc.kr(0.1).exprange(280.0, 500.0) + 4000, res: 0, transition: 0);
        // sig = VA1Pole.ar(sig, freq: 100, feedback: -0.1, type: 0);
        sig = sig * Line.ar(0, 1, 0.1);
        sig = VadimFilter.ar(sig, 100 + (env * 200 * lfo2), resonance: 0.25, type: 1) * 4;
        // sig = VAKorg35.ar(sig, freq: 1200, res: 0.0, overdrive: 0.0);

        sig = sig * env!2;
        // Splay.ar(sig.scramble);
    }.play(fadeTime: 0.1);
});
)


// ------------------------------------------------------------------------
// Les percussions
// ------------------------------------------------------------------------

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
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)



(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {
    ~crushedHats.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
    ~crushedHats = {
        | trigGate = 1 |
        var pulse = Impulse.kr(~nT.tempo * 2 * 8) * trigGate;
        var trig = pulse * Demand.kr(pulse, 0, Dseq(
            [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0].wrapExtend(16 * 3) ++
            [1, 1, 1, 1].wrapExtend(16), inf)
        );
        var col = Demand.kr(trig, 0, Dseq(
            [0.7, 0.5], inf)
        );
        var envD = Demand.kr(trig, 0,
            Dseq(((3!1) * 2 ++ [2]).reverse * 0.01, inf)
        );
        var ddd = Demand.kr(trig, 0, Dseq((78.5!(16 * 3 / 2) ++ (208.5!(16))), inf));
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
        var sig = MiBraids.ar(42 + (12 * -3) - 5,
            timbre: tim,
            color: col,
            model: 41,
            trig: trig,
            resamp: 2,
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
        sig = lsig * 1 * 2 * 2.5!2;
        // [sig[0] + (sig[1 * 0.75]), sig[1] + (sig[0] * 0.75)];
        // sig[1]!2;
    }.play(fadeTime: 0.01);
});
)



// ------------------------------------------------------------------------
// La section des bruits bienvenus
// ------------------------------------------------------------------------

(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {

    if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

    ~crushedNoise = {
        | trigGate = 1 |
        var trig, sig, env, block, decay, timbre, delrd, note, r, n;
        trig = Impulse.kr(1 * 1);
        block = Demand.kr(trig, 0, Dseq([1, 0, 1, 0, 1, 1], inf));
        timbre = Demand.kr(trig, 0, Dseq([0.8, 0.95].stutter(2), inf));
        note = Demand.kr(trig * block, 0, Dseq([-10, -8].stutter(8).midiratio, inf));
        r = 0.01;
        n = (~nT.tempo * 0.125).reciprocal;
        env = EnvGen.ar(Env.circle([0, 1, 1, 0], [r, n - r, r, n - r]));
        // timbre = timbre.lag(0.07);
        // delrd = LocalIn.ar(2);
        sig = MiBraids.ar(
            pitch: 10,
            timbre: 0.25,
            color: [0.8, 0.95] - 0.2,
            model: 37,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        ) * [env * 0.5, 1 - env];
        sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
        // sig = (CombN.ar(sig, 0.2, 0.025 + [0, 0.001], 3) * 0.125 * 0.5) * 1;
        // sig = sig + delrd;
        // LocalOut.ar(DelayC.ar(LPF.ar(sig, 3700) * 0.99 * [1, 0.95], 0.1, 0.025 * note));
        // sig = LPF.ar(sig, 2700);
        sig!2 * 0.5 * 3;
    }.play(fadeTime: 0.01).register;
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4), {

    var f = 0;
    [~billes0, ~billes1].do({|i| if(i.isPlaying, {i.set(\trigGate, 0, \gate, 0, \fadeTime, 5)});});

    ~billes0 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 4) * trigGate;
        var sig = MiPlaits.ar(62 + f + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.8 * 0.8 * 2;
    }.play.register;

    ~billes1 = {
        | trigGate = 1 |
        var trig = Impulse.ar(~nT.tempo * 8) * trigGate;
        var sig = MiPlaits.ar(59 + f + [0, 0.1],
            engine: 11,
            harm: 0.25,
            timbre: 0.5,
            morph: SinOsc.kr(0.1).range(0.75, 0.95),
            trigger: trig,
            decay: 1,
            lpg_colour: 1,
            mul: 1.25);
        HPF.ar(sig, 5000) * 0.8 * 0.8 * 2;
    }.play.register;
});
)

(
~k.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~roues.set(\pulseGate, 0, \gate, 0, \fadeTime, 0.1);
~basse.set(\gate, 0, \fadeTime, 0.1);
~grenouille.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1);
~hats.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~crushedHats.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
if(~crushedNoise.isPlaying, {~crushedNoise.set(\trigGate, 0, \gate, 0, \fadeTime, 0.1)});

)