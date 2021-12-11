~reverb = Bus.audio(s, 2);

(

~cloudyVerb.set(\gate, 0, \fadeTime, 0.1);
~cloudyVerb = {
    | freeze = 0 |
    // var sig = PlayBuf.ar(2, b, 1, startPos: 332950, loop: 1);
    // var sig = XPlayBuf.ar(2, b, 0.5, 1, 332950, loop: 1);
    // sig.size.poll;
    var sig = In.ar(~reverb, 2);
    //     var dens = LFNoise1.kr(0.3).range(0.3, 0.45);
    sig = VadimFilter.ar(sig, 12000, 0, 1);
        MiClouds.ar(
        inputArray: sig,
        pit: 0,
        pos: 0,
        size: 0,
        dens: 0.01,
        tex: 0.25,
        drywet: 0.75,
        in_gain: 1,
        spread: 0,
        rvb: 0.8,
        fb: 0,
        freeze: freeze,
        mode: 1,
        lofi: 0
    ) * 1;
    // sig * 1;
    // MiVerb.ar(sig);
    // sig.size.poll;
    // sig * 0.5;
}.play;
)