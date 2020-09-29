(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    {
        var env = EnvGen.kr(Env.new([0.4, 0.5, 0], [0.001, 6], [1, 1]), doneAction: 2);
        var lenv = EnvGen.kr(Env.circle([0.5, 0], [0.05], [8]));
        var env2 = EnvGen.kr(Env.new([0.1, 0.75], [4], [1, 1]));
        var lfo = SinOsc.kr(0.5).range(0, 0.1);
        var sig = MiTides.ar(freq: num.midicps,
            shape: SinOsc.kr(2).range(0.5, 0.9),
            slope: 0.75,
            smooth: env + lfo * 1,
            shift: 0.45,
            trig: 0,
            clock: 0,
            output_mode: 3,
            ramp_mode: 1,
            ratio: 9,
            rate: 1) * 0.1;
        sig * env * 4 * 3;
    }.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)