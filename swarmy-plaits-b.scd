(
x.free;
x = {
    var sig2;
    var trig = Impulse.kr(0.125);
    var lfo = SinOsc.kr({rrand(0.125, 0.12)}!6).range(0.1, 0.3);
    var dem = Demand.kr(trig, 0, Dseq([-5, -3], inf));
    var dem2 = Demand.kr(trig, 0, Dseq([5, 4], inf));
    var sig = MiPlaits.ar(
        pitch: 60 + 2 - 10 + 26 + [0, dem, dem2].wrapExtend(6) + [0, 0.05].stutter(3) + -24,
        engine: 3,
        harm: lfo,
        timbre: lfo,
        morph: 0,
        level: lfo,
        fm_mod: 0,
        timb_mod: 0.5,
        morph_mod: 0.5
    );
    sig = [
        sig[0][1] + sig[1][1] + sig[2][1], sig[3][1] + sig[4][1] + sig[5][1]
    ] * 0.2;
    // sig = LPF.ar(sig, 2000);
    sig * 4;
    // [sig, sig2];
}.play;
)

collect


