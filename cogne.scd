(
SynthDef(\griSynth, {
    | trigGate = 1, releaseGate = 1, pitch = 60, vel = 1 |
    var env = EnvGen.kr(
        Env(
            levels: [0,      1,     1,    0],
            times:  [   0.0314221*0.5,    0.1,    32],
            curve:  [   'lin', -32,    -8],
            releaseNode: 2
        ),
        gate: releaseGate,
        doneAction: 2
    );
    var sig = MiBraids.ar(
        pitch: pitch + [0, 0.1] + ~lfo.(3,0,0.0), timbre: 0.2+~lfo.(3,0,0.1), color: [0.38] - 0.3,
        model: 37,
        resamp: 2, decim: 22, bits: 2, ws: ~lfo.(1)*1*env
    ).sum * env;
    // pitch.linexp(0, 199, 0.75, 0.005).poll;
    // sig = VadimFilter.ar(sig, 1700 + SinOsc.kr(0.1).range(0, 7000), 0, 1);
    // vel.poll;
    sig = sig!2 * 4 * 3 * 0.05 + (~v.(sig,1000,0,3)*0.5) * 0.5;
    // releaseGate.poll;
/*                sig = MiWarps.ar(
        sig, DelayN.ar(sig, 1, 1/128), lev1: 0.5, lev2: 0.5,
        algo: 4, timb: 1, osc:0, freq: ~toFreq.("E0"), easteregg:0) * 1;*/
    sig = ~v.(sig, 9000 * env * (0.1 + vel) + 100);
    Out.ar(0, sig);
}).add;
)

({
{{
    var x = Synth.new(\griSynth, [\pitch, 102, \vel, 0.0078125]);
        1.wait;
        x.set(\releaseGate, 0);
}.fork;
    8.wait;
}.loop;

}.fork;)
