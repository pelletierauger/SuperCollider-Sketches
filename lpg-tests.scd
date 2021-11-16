(
// s.boot;
Ndef(\minieasel, {|tempo=1.0, envdur=0.25|
    var trig = Impulse.kr(tempo);
    var seq = Demand.kr(trig, 0, Dseq([400,99,791,2000,200],inf)).lag(0.01);

    var sig = SinOscFB.ar(55 * 24.midiratio, 1.4) + WhiteNoise.ar(0.01);
    var env = Env.perc(0.1,0.9).kr(gate: trig, timeScale: envdur/tempo);

    sig = LPG.ar(
        input: sig,
        controlinput: env,
        controloffset: 0,
        controlscale: 0.1,
        vca: LFNoise2.kr(1).unipolar,
        resonance: 0.8,
        lowpassmode: 1,
        linearity: 0
    ) * 0.25;

    sig!2;
}).mold(2, 'audio').play;

)

(
// s.boot;
Ndef(\lpgtest, {
    // var sig = PinkNoise.ar(0.95);
    var freq = LFNoise2.kr(1).range(1.0,4.0);
    var env = Env.perc(0.1,1.5).ar(gate: Impulse.kr(freq), timeScale:freq.reciprocal * 0.05);
    var sig = WhiteNoise.ar(0.2) + SinOsc.ar(LFNoise2.kr(1).exprange(200.0,1000)*SinOsc.kr(env.lag3.range(100,10)));

    sig = LPG.ar(
        input: sig,
        controlinput: env,
        controloffset:0.0,
        controlscale: LFNoise2.kr(10.1).range(0.5,0.95),
        vca: 0.091,
        resonance:1.35,
        lowpassmode:1,
        linearity:1
    ) * 0.25;

    Pan2.ar(sig, 0.25*SinOsc.kr(0.1))
}).mold(2, 'audio').play;

)

(
// s.boot;
Ndef(\minieasel2, {|tempo=8.0, envdur=0.91|
    var trig = Impulse.kr(tempo);
    var seq = TWChoose.kr(trig, [0.5,1.0,1.5], [0.75, 0.125, 0.125]) *  Demand.kr(trig, 0, Dseq([200,291,420,191,320],inf)).lag(0.01);

    var sig = SinOscFB.ar(seq, 1.1) + WhiteNoise.ar(0.1);
    var rand = TRand.kr(trig: trig);
    var env = Env.perc(rand,1.0-rand).kr(gate: trig, timeScale: envdur/tempo);

    sig = LPG.ar(
        input: sig,
        controlinput: env,
        controloffset: LFSaw.kr(0.1).range(0.0,0.2),
        controlscale: LFNoise2.kr(0.1).range(0.4,0.95),
        vca: LFNoise2.kr(1).unipolar,
        resonance:1.1,
        lowpassmode:1,
        linearity:1
    ) * 0.25;

    Pan2.ar(sig, 0.5*TRand.kr(-1.0,1.0,trig))
}).mold(2, 'audio').play;

)

(
SynthDef.new(\bongo, {
    |out=0,
    amp=0.5,
    freq=141,
    width=0.95,
    attack=0.001,
    release=0.999,
    pan=0,
    lpgsustain=0.01,
    lpgoffset=0,
    lpgfilterscale=0.3,
    vcaness=0.75,
    t_gate=1,
    resonance=1.1|

    // var sig = VarSaw.ar(freq - [ 0, freq/100.0 ], 0, width).sum;
    var sig = SinOscFB.ar(freq, 1.5);
    var env = Env.perc(attack,release).kr(gate: t_gate, timeScale: lpgsustain.poll, doneAction: 0);

    sig = LPG.ar(
        input: sig,
        controlinput: env,
        controloffset: lpgoffset,
        controlscale: lpgfilterscale,
        vca: vcaness,
        resonance: resonance,
        lowpassmode:1,
        linearity:1
    );

    sig = sig * amp;
    sig = Pan2.ar(sig, pan);
    Out.ar(out, sig)
}).add;
)

(
Pdef('🦞',
    Pmono(
        \bongo,
        \amp, 0.5,
        \degree, Pseq((0..3), inf),
        \width, 0.25,
        // \attack, 0.001,
        // \release, 0.999,
        \pan, Pseq(Array.rand(5,-1.0,1.0),inf),
        \dur, 1.0,
        \gate, 1,
        // \lpgsustain, 0.0001,
        \lpgoffset, 0.0,
        \lpgfilterscale, 0.4,
        \vcaness, 1-Pkey(\lpgfilterscale),
        \resonance, 1.2000000238419,
    )
).play
)