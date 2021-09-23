MIDIClient.init;
MIDIIn.connect;


~toLFO = Bus.control(s, 1);

(
~lfoSender.free;
~lfoSender = {
    var sig = SinOsc.kr(3).range(0, 0.5);
    Out.kr(~toLFO, sig);
}.play;
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var amp = vel / 128;
    {
        var env = EnvGen.kr(Env.new([0.001, 1, 0.001], [0.05, 6], [1, -8]), doneAction: 2);
        var lenv = EnvGen.kr(Env.circle([0.125, 0.15] + 0.2, [0.1], [8]));
        var env2 = EnvGen.kr(Env.new([0.5, 0.75], [4], [1, 1]));
        var lfo = SinOsc.kr(1).range(0, 0.5);
        var sig = MiTides.ar(freq: num.midicps,
            shape: 0.0,
            slope: 0.3,
            slope: In.kr(~toLFO, 1) * 2,
            smooth: EnvGen.kr(Env.new([0.5, 0.3], [0.01], [1, 1])),
            smooth: 0,
            shift: 0.85,
            trig: 0,
            clock: 0,
            output_mode: 3,
            ramp_mode: 1,
            ratio: 9,
            rate: 1);
        sig = sig * env;
        // sig = sig + (HPF.ar(sig, 9000) * Line.kr(1, 0, 0.005) * 64 * 4);
        // sig = LPF.ar(sig, 1000 + (amp * 8000));
        // sig = VadimFilter.ar(sig, 1000 + (amp * 16000), resonance: 0, type: 1);
        sig = sig * 8 * 4 * Line.kr(0, 1, 0.05);
        // Out.ar(0, sig);
        Out.ar(~toFilters, [sig[2], sig[3]] * 1);
        // TChoose.ar(Impulse.ar(0.001), [sig, [sig[1], sig[0]]]);
        // sig * amp * 4;Choose
    }.play(fadeTime: 0);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)

~toFilters = Bus.audio(s, 2);


(
{
    var sig = In.ar(~toFilters, 2);
    sig = VAKorg35.ar(sig, freq: 2200, res: 0.5, overdrive: 0.8);
    sig = sig * 0.25 + VadimFilter.ar(sig, 150, resonance: 0, type: 5);
/*    sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        // modulation: 0.25,
        stages: 1
    );*/
    sig * 2;
}.play;
)


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var amp = vel / 128;
    var smo = max(0.0, min(num.linlin(46, 89, 0.0, 0.25), 0.25));
    smo.postln;
    {
        var env = EnvGen.kr(Env.new([0.001, 0.5, 0.001], [0.01, 6], \exp!2), doneAction: 2);
        var lenv = EnvGen.kr(Env.circle([0.125, 0.15] + 0.2, [0.1], [8]));
        var env2 = EnvGen.kr(Env.new([0.5, 0.75], [4], [1, 1]));
        var lfo = SinOsc.kr(6).range(0, 0.25);
        var sig = MiTides.ar(freq: num.midicps,
            shape: lfo,
            slope: 0.5 - (env * 0.25 * amp),
            smooth: smo + EnvGen.kr(Env.new([0.5, 0.3], [0.01], [1, 1])),
            shift: 0.5,
            trig: 0,
            clock: 0,
            output_mode: 3,
            ramp_mode: 1,
            ratio: 9,
            rate: 1) * 0.1;
        sig = sig * env * 16 * 2;
        // sig = sig + (HPF.ar(sig, 9000) * Line.kr(1, 0, 0.005) * 64 * 4);
        sig = LPF.ar(sig, 1000 + (amp * 8000));
        TChoose.ar(Impulse.ar(0.001), [sig, [sig[1], sig[0]]]);
        // sig * amp * 4;Choose
    }.play(fadeTime: 0);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)


(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var amp = vel / 128;
    var smo = max(0.0, min(num.linlin(46, 89, 0.0, 0.25), 0.25));
    smo.postln;
    {
        var env = EnvGen.kr(Env.new([0.001, 0.5, 0.001], [0.01, 6], \exp!2), doneAction: 2);
        var lenv = EnvGen.kr(Env.circle([0.125, 0.15] + 0.2, [0.1], [8]));
        var env2 = EnvGen.kr(Env.new([0.5, 0.75], [4], [1, 1]));
        var lfo = SinOsc.kr(12).range(0, 0.75);
        var sig = MiTides.ar(freq: num.midicps,
            shape: lfo,
            slope: 0.5 - (env * 0.25 * amp),
            smooth: smo + EnvGen.kr(Env.new([0.5, 0.3], [0.01], [1, 1])),
            shift: 0.5,
            trig: 0,
            clock: 0,
            output_mode: 3,
            ramp_mode: 1,
            ratio: 9,
            rate: 1) * 0.1;
        sig = sig * env * 16 * 2;
        // sig = sig + (HPF.ar(sig, 9000) * Line.kr(1, 0, 0.005) * 64 * 4);
        sig = LPF.ar(sig, 1000 + (amp * 8000));
        TChoose.ar(Impulse.ar(0.001), [sig, [sig[1], sig[0]]]) * 0.25;
        // sig * amp * 4;Choose
    }.play(fadeTime: 0);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)