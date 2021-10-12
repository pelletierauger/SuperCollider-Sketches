~nT = TempoClock.new(1.39 * 1.25 * 1.075).permanent_(true);

(
j.free;
j = {
    var t = Impulse.kr(4 * 2);
    var d = Demand.kr(t, 0, Dseq([8, 5, 1,  5, 1, 5, -4, -2].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq([0, 0.8], inf));
    var f = 31 - 2 - d + 12 + 0;
    var lfo = SinOsc.kr(0.1).range(0.05, 0.1);
    var lfo2 = SinOsc.kr(0.1).range(100, 3000);
    var alg = 5;
    var sig = MiPlaits.ar(f, alg, harm: lfo, morph: d2, trigger: t, decay: 0.6,  mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    // sig = [sig[0][0], sig[1][0]] * 2;
    sig = sig[0] * 2;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 200 * lfo, res: 0.0, overdrive: 0.05) * 4 +
    (VadimFilter.ar(sig, 1000 + lfo2, resonance: 0, type: 1) * 0) * 1!2;
}.play(fadeTime: 0.2);
)


// son clave bruyant
(
j.free;
j = {
    var t = Impulse.kr(4);
    var d = Demand.kr(t, 0, Dseq([8, 5, 1,  5, 1, 5, -4, -2], inf));
    var f = 31 - 2 - d + 12;
    var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
    var alg = 5;
    var sig = MiPlaits.ar(f, alg, harm: lfo, morph: 0, mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    // sig = [sig[0][0], sig[1][0]] * 2;
    sig = sig[0] * 2;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) +
    (VadimFilter.ar(sig, 1000, resonance: 0, type: 5) * 3) * 0.25!2;
}.play(fadeTime: 0.3);
)

(
~pul3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~pul3 = {
    | trigGate = 1 |
    var trig = Impulse.kr(1 * 8) * trigGate;

    var dem = Demand.kr(trig, 0, Dseq(
        [1, 0, 1, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 0, 0]
        , inf));
    var envD = Demand.kr(trig * dem, 0, Dseq([0.4, 1].stutter(3) * 2, inf));
    var fil = Demand.kr(trig * dem, 0, Dseq([2000, 7000].stutter(3), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD], [-8, -8, 'lin']), trig * dem);
    var dec = Demand.kr(trig * dem, 0, Dseq([0.4] + 0.1, inf));
    var tim = Demand.kr(trig * dem, 0, Dseq([0.9, 0.9, 0.9, 0.6, 0.6, 0.6], inf));
    var sig = MiBraids.ar(42 - 36 + 24 + 12,
        timbre: tim,
        color: 1,
        model: 43,
        trig: trig * dem,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0
    ) * env;
    // sig = HPF.ar(sig, 200);
    // sig = [sig[0][1], sig[1][1]];
    var lsig = VadimFilter.ar(sig, fil, resonance: 0, type: 1);
    sig = VAKorg35.ar(lsig, freq: 100, res: 0.0, overdrive: 0.0) + (sig * 0);
    sig = sig * 1.2!2;
    // sig[1]!2;
}.play(fadeTime: 0.01);
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 1), {
~pul3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~pul3 = {
    | trigGate = 1 |
    var trig = Impulse.kr(~nT.tempo * 0.5 * 8) * trigGate;

    var dem = Demand.kr(trig, 0, Dseq(
        [1, 0, 1, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 0, 0]
        , inf));
    var envD = Demand.kr(trig * dem, 0, Dseq([0.4, 1].stutter(3) * 2, inf));
    var fil = Demand.kr(trig * dem, 0, Dseq([2000, 7000].stutter(3), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD], [-8, -8, 'lin']), trig * dem);
    var dec = Demand.kr(trig * dem, 0, Dseq([0.4] + 0.1, inf));
    var tim = Demand.kr(trig * dem, 0, Dseq([0.7, 0.7, 0.7, 0.6, 0.6, 0.6], inf));
    var sig = MiBraids.ar(42 - 36 + 24 + 12,
        timbre: tim + [0, 0.01],
        color: 1,
        model: 43,
        trig: trig * dem,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0
    ) * env;
    // sig = HPF.ar(sig, 200);
    // sig = [sig[0][1], sig[1][1]];
    var lsig = VadimFilter.ar(sig, fil, resonance: 0, type: 1);
    sig = VAKorg35.ar(lsig, freq: 200, res: 0.0, overdrive: 0.0) + (sig * 0);
    sig = sig * 0.6;
    // sig[1]!2;
}.play(fadeTime: 0.01);
});
)


(
~nT.sched(~nT.timeToNextBeat(quant: 4) + (~nT.beatDur * 0), {

j.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
j = {
    | trigGate = 1 |
    var t = Impulse.kr(~nT.tempo * 0.5 * 4 * 2) * trigGate;
    var d = Demand.kr(t, 0, Dseq([8, 5, 1,  5, 1, 5, -4, -2].stutter(2), inf));
    var d2 = Demand.kr(t, 0, Dseq([0, 0.8], inf));
    var f = 31 - 2 - d + 12 + 0;
    var lfo = SinOsc.kr(0.1).range(0.05, 0.1);
    var lfo2 = SinOsc.kr(0.1).range(100, 3000);
    var alg = 5;
    var sig = MiPlaits.ar(f, alg, harm: lfo, morph: d2, trigger: t, decay: 0.6,  mul: 0.2);
    // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
    // sig = [sig[0][0], sig[1][0]] * 2;
    sig = sig[0] * 2;
    // sig = sig + ;
    sig = VAKorg35.ar(sig, freq: 200 * lfo, res: 0.0, overdrive: 0.05) * 4 +
    (VadimFilter.ar(sig, 1000 + lfo2, resonance: 0, type: 1) * 0) * 1!2;
}.play(fadeTime: 0.2);

~pul5.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~pul5 = {
    | trigGate = 1 |
    var trig = Impulse.kr(~nT.tempo * 0.5 * 8) * trigGate;

    var dem = Demand.kr(trig, 0, Dseq(
        [1, 0, 1, 0, 1, 0, 0, 0] ++ [1, 0, 1, 0, 1, 0, 0, 0]
        , inf));
    var envD = Demand.kr(trig * dem, 0, Dseq([0.4, 1].stutter(3) * 2, inf));
    var fil = Demand.kr(trig * dem, 0, Dseq([2000, 7000].stutter(3), inf));
    var env = EnvGen.kr(Env([0, 1, 0], [0.005, envD], [-8, -8, 'lin']), trig * dem);
    var dec = Demand.kr(trig * dem, 0, Dseq([0.4] + 0.1, inf));
    var tim = Demand.kr(trig * dem, 0, Dseq([0.7, 0.7, 0.7, 0.65, 0.65, 0.65], inf));
    var sig = MiBraids.ar(42 - 36 + 24 + 12 - 0,
        timbre: tim,
        color: 1,
        model: 43,
        trig: trig * dem,
        resamp: 2,
        decim: 32,
        bits: 6,
        ws: 0
    ) * env;
    // sig = HPF.ar(sig, 200);
    // sig = [sig[0][1], sig[1][1]];
    var lsig = VadimFilter.ar(sig, fil - 1000, resonance: 0, type: 5);
    sig = VAKorg35.ar(lsig, freq: 300, res: 0.0, overdrive: 0.0) + (sig * 0.125);
    sig = sig * 0.2!2;
    // sig[1]!2;
}.play(fadeTime: 0.01);
});
)


(
j.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~pul5.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
~pul3.set(\trigGate, 0, \gate, 0, \fadeTime, 5);
)