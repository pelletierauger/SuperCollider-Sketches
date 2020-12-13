MIDIClient.init;
MIDIIn.connect;

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var amp = vel / 128;
    {
        var env = EnvGen.kr(Env.new([0.001, 0.5, 0.001], [0.01, 6], \exp!2), doneAction: 2);
        var lenv = EnvGen.kr(Env.circle([0.125, 0.15] + 0.2, [0.1], [8]));
        var env2 = EnvGen.kr(Env.new([0.5, 0.75], [4], [1, 1]));
        var lfo = SinOsc.kr(0.1).range(0, 0.5);
        var sig = MiTides.ar(freq: num.midicps,
            shape: 0.01,
            slope: 0.5 - (env * 0.25 * amp),
            smooth: EnvGen.kr(Env.new([0.5, 0.3], [0.01], [1, 1])),
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