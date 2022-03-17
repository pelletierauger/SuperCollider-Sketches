(
~t.sched(~t.timeToNextBeat(quant: 6), {
        ~gr.set(\fadeTime, 0.1, \gate, 0);
        ~gr = {
            | freeze = 0 |
            var t = Impulse.kr(~t.tempo);
            var bl = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
            var sig = PlayBuf.ar(2, b, -2.midiratio, bl, startPos: 0, loop: 1);
            var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
            var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
            sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
            sig = VadimFilter.ar(sig, 2000, 0, 0) * [4, 2] * (sig3 * 0.2) * 16;
            sig = sig * 0 + (VadimFilter.ar(sig.reverse, 5000, 0, 5) * 8 * 1) * 2;
        sig = VadimFilter.ar(sig, 9000, 0, 1) * 2;
        }.play(fadeTime: 0.25);

});
)


(
~t.sched(~t.timeToNextBeat(quant: 6), {
        ~gr.set(\fadeTime, 0.1, \gate, 0);
        ~gr = {
            | freeze = 0 |
            var t = Impulse.kr(~t.tempo);
            var bl = t * Demand.kr(t, 0, Dseq([1, 0, 0, 0, 0, 0], inf));
            var sig = PlayBuf.ar(2, b, -2.midiratio, bl, startPos: 0, loop: 1);
            var sig2 = VAKorg35.ar(sig, 1500, res: 0, overdrive: 0.5, type: 0) * 0.5;
        // var sig3 = MiRings.ar(sig, pit: 48, struct: 0.3, model: 4);
            sig = sig * 0.7 * VadimFilter.ar(sig2, 500, 0, 0) * 2;
            sig = VadimFilter.ar(sig, 2000, 0, 0) * [4, 2] * 1;
            sig = (VadimFilter.ar(sig.reverse, 5000, 0, 5) * 8 * 1) * 16;
        MiRings.ar(sig, pit: 48, struct: 0.3, model: 4) * 0.5;
        // sig = VadimFilter.ar(sig, 9000, 0, 1) * 2;
        }.play(fadeTime: 0.25);

});
)