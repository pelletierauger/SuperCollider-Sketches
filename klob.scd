(
~nT.schedAbs(~nT.nextBar + 0.5, {
    x.free;
    x = {
        | trigGate = 1 |
        var t = Impulse.kr(~nT.tempo * 0.125 * 0.5) * trigGate;
        var d = Demand.kr(t, 0, Dseq([6, 1].stutter(1), inf));
        var e = EnvGen.kr(Env([0, 0.5, 0], [6, 24], [-8, -8]), gate: t).lag(1);
        // var note = 48 + [0, 1, 2, 3, 4, 5, 6];
        var shift = Demand.kr(t, 0, Dseq([1, 2, 3, 4] * 0.1, inf));
        var note = 26 + 24 + d + 0 + (((0..6) * 2) * 0.05 * e);
        var lfo = SinOsc.kr(6).unipolar;
        var har = [0, 3, 5, 7, 14].wrapExtend(21);
        var sig = MiBraids.ar(
            pitch: note ++ (note + (shift * e))  ++ (note + (shift + 1 * e)) + (lfo * (e*0.5)) + har,
            timbre: (0..20).size * 0.25, color: MouseY.kr(), model: floor(MouseX.kr(0,47)),
            resamp: 0, decim: 12 * e, bits: 2, ws: 0.5
        );
        // 20 * 0.025;
        // sig.size.poll;
        // sig = [sig[0].sum, sig[1].sum];
        sig = VadimFilter.ar(sig, 3500 * e + 50, 0, 1);
        sig = DelayN.ar(sig, 4, (1..21).scramble / 20);
        sig = Splay.ar(sig.scramble);
        sig = sig * Line.kr(0, 1, 1);
        sig = VadimFilter.ar(sig, 1000, 0, 5);
        // sig = MiVerb.ar(sig, time: 0.8, drywet: 1);
        sig = VadimFilter.ar(sig, 3000, 0, 1);
        Out.ar(0, sig * 4 * 4 * 4);
    }.play;
});
)