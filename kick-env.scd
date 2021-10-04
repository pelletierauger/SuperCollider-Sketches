

(
{
    // s.record;
    // 0.1.wait;

    v.set(\gate, 0, \fadeTime, 0.1);
    v = {
        var trig, amp, sig, env;
        trig = Impulse.kr(1);

        env = EnvGen.kr(Env([0, 1, 0], [0.005, 0.75], [-8 , 8, 'lin']), trig);
        amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
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
        sig!2 * env;
    }.play(fadeTime: 0);

        0.25.wait;

    w.set(\gate, 0, \fadeTime, 0.1);
    w = {
        var trig, amp, sig, bl, note, env, dd, ddd;
        trig = Impulse.kr(1 * 2);
        bl = Demand.kr(trig, 0, Dseq([1, 1, 1, 1, 0, 0, 0, 0], inf));
        dd = Demand.kr(trig, 0, Dseq(0.5!3 ++ (2.5!1), inf));
        ddd = Demand.kr(trig, 0, Dseq(0.8!3 ++ (0.85!1), inf));
        env = EnvGen.kr(Env([0, 1, 0], [0.005, dd], [-8 , 8, 'lin']), trig * bl);
        note = Demand.kr(trig * bl, 0, Dseq(-5!4 ++ (-12!0), inf));
        amp = EnvGen.kr(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
        sig = MiPlaits.ar(25 + 12 - 2 + note + [0, 0.1],
            engine: 13,
            harm: 0.5,
            timbre: 0.9,
            morph: ddd,
            trigger: trig * bl,
            decay: 0.2,
            lpg_colour: 0,
            mul: 2) * 0.25;
        // sig = sig[0];
        sig = [sig[0][1], sig[1][1]];
        sig = VAKorg35.ar(sig, freq: 1200, res: 0.1, overdrive: 0.05);
        sig = VadimFilter.ar(sig, 2200, 0, 1);
        sig * env;
    }.play(fadeTime: 0);

        0.25.wait;

    ~chen.set(\gate, 0, \fadeTime, 0.1);
    ~chen = {

        var t = Impulse.kr(0.5 * 4);
        var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2.5], [-8, -8, 'lin']), t) * dem;
        var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
        var lfo2 = env * -0.04;
        var sig = Chen.ar(0.1 + lfo2, 0.69, 0.2 + (lfo2 * 4), 0.01);
        sig = sig[2];
        sig = sig + (VadimFilter.ar(
            input: sig,
            type: 5,
            freq: 700,
            resonance: 0.25
        ) * 24);
        sig * 2 * env!2;
    }.play;
    // s.stopRecording;
    // v.free;
    }.fork;
)


(
        j.set(\gate, 0, \fadeTime, 0.1);
    j = {
        var env = EnvGen.kr(Env([0.25, 0.25, 0.5], [0.5, 0.5]));
        var t = Impulse.kr(4);
        var d = Demand.kr(t, 0, Dseq([8, 5, 1, 5, 1, 5, -4, -2], inf));
        var f = 31 - 2 - d + 12;
        var lfo = SinOsc.kr(0.1).range(0.1, 0.25);
        var alg = 5;
        var sig = MiPlaits.ar(f, alg, harm: lfo, morph: 0, trigger: 1, mul: 0.2);
        // var sig2 = MiPlaits.ar(f + 0.1, alg, harm: lfo, morph: 0, mul: 0.2);
        // sig = [sig[0][0], sig[1][0]] * 2;
        sig = sig[0] * 2 * env;
        // sig = sig + ;
        sig = VAKorg35.ar(sig, freq: 2000 * lfo, res: 0.6, overdrive: 0.05) * 0.1 +
        (VadimFilter.ar(sig, 1000, resonance: 0, type: 5) * 3) * 0.5!2 * 2;
    }.play(fadeTime: 10.1);

)

(
// 0.25.wait;

    ~chen.set(\gate, 0, \fadeTime, 0.1);
    ~chen = {

        var t = Impulse.kr(0.5 * 4);
        var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2.5], [-8, -8, 'lin']), t) * dem;
        var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
        var lfo2 = env * -0.04;
        var sig = Chen.ar(0.1 + lfo2, 0.69, 0.2 + (lfo2 * 4), 0.01);
        sig = sig[2];
        sig = sig + (VadimFilter.ar(
            input: sig,
            type: 5,
            freq: 700,
            resonance: 0.25
        ) * 24);
        sig * 2 * env!2;
    }.play;
)