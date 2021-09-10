AnalogSnareDrum


(
~stormofsnares.free;
~stormofsnares = {
    var trig = Impulse.kr(4);
    var dem = Demand.kr(trig, 0, Dseq((8!3) ++ (8!1)/10, inf));
    var dem2 = Demand.kr(trig, 0,
        Dseq((0.25!3) ++ (0.5!1), inf) + Dseq([0.2, 0], inf)
    );
    var sig = AnalogSnareDrum.ar(
        trig,
        infsustain: 0.0,
        accent: 1,
        freq: 48,
        tone: 0.75 + (0.8 - dem),
        decay: dem,
        snappy: dem2,
    );
    // sig = VadimFilter.ar(sig, 2500, resonance:0, type:1);
        sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        stages: 50
    );
    sig * 0.5;
    //     Pan2.ar(sig, TRand.kr(-1.0,1.0,trig));
}.play;
)


LPG


(
// s.boot;
Ndef(\minieasel, {|tempo=2.0, envdur=0.25|
    var trig = Impulse.kr(tempo);
    var seq = Demand.kr(trig, 0, Dseq([400,99,791,2000,200],inf)).lag(0.01);

    var sig = SinOscFB.ar(seq, 1.1) + WhiteNoise.ar(0.1);
    var env = Env.perc(0.1,0.9).kr(gate: trig, timeScale: envdur/tempo);

    sig = LPG.ar(
        input: sig,
        controlinput: env,
        controloffset: LFSaw.kr(0.1).range(0.0,0.2),
        controlscale: LFNoise2.kr(0.1).range(0.4,0.95),
        vca: LFNoise2.kr(1).unipolar,
        resonance:1.1,
        lowpassmode:1,
        linearity:0
    ) * 0.25;
        sig = AnalogPhaser.ar(
        sig,
        SinOsc.ar(0.022 * [1, 1.1]),
        skew: SinOsc.kr(5.59 * [1, 1.1]),
        feedback: SinOsc.kr(0.005 * [1, 1.1], 1pi).range(0.8,0.85),
        modulation: SinOsc.kr(2.0192 * [1, 1.1], 2pi).unipolar,
        stages: 50
    );
    Pan2.ar(sig, 0.5*TRand.kr(-1.0,1.0,trig))
}).mold(2, 'audio').play;

)