(   // cross feedback
// m.free;
{
    var xfb = LFTri.kr(0.05).range(0.25, 1);
    MiOmi.ar(
        pit: 23, xfb: xfb,
        filter_mode: 0, cutoff: 0.35, reson: 0,
        rotate: 0.2, space: 0.5
    ) * 1;
}.play;
)


(
{
    v.set(\gate, 0, \fadeTime, 0.1);
    v = {
        var trig, amp, sig;
        trig = Impulse.ar(1);
        amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
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
        sig!2;
    }.play(fadeTime: 0);
    0.5.wait;
    ~chen.set(\gate, 0, \fadeTime, 0.1);
    ~chen = {

        var t = Impulse.kr(0.5 * 4);
        var dem = Demand.kr(t, 0, Dseq([1, 0.5], inf));
        var env = EnvGen.kr(Env([0, 1, 0], [0.01, 2.5], [-8, -8, 'lin']), t) * dem;
        var lfo = SinOsc.kr([1, 1.01]).range(-0.01, 0.01);
        var lfo2 = env * -0.04;
        var sig = Chen.ar(0.1 + lfo2, 0.69, 0.2 + (lfo2 * 4), 0.01);
        sig = sig[2]!2;
        // sig.size.poll;
        sig = sig * 1 + (VadimFilter.ar(
            input: sig,
            type: 5,
            freq: 700,
            resonance: 0.25
            // resonance: 2 - (env * 2) + (SinOsc.kr(8 + [0, 0.5]).range(0, 1) * (1 - env))
            //         resonance: SinOsc.kr(0.25).range(0.0, 4.0)
        ) * 24);
        sig * 2 * env;
    }.play;
}.fork;
)
