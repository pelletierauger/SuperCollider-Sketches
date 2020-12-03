(
{
    // var sig = [WhiteNoise.ar(), WhiteNoise.ar()];
    var f = 440 * [0].choose.midiratio;
    var sig = WhiteNoise.ar(1!2);
    // var sig = BrownNoise.ar(1!2);
    sig = RLPF.ar(sig, f, rq: 0.125 * 0.125);
    sig = sig + RLPF.ar(sig, f * 19.midiratio, rq: 0.125 * 0.125);
    // sig = HPF.ar(sig, f + Line.kr(0, 9000, 4));
    // sig = Resonz.ar(sig, 220, bwr: 1);
    sig = sig * EnvGen.kr(Env.new([0, 0.1, 1, 0], [0.001, 0.5, 0.01], ['lin', -8]), doneAction: 2);
    sig * 0.1;
}.play;
)