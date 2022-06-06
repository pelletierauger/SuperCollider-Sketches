~cl = TempoClock.new(1).permanent_(true);

(
~cl.schedAbs(~cl.nextBar, {
    ~oneShot.set(\trigGate, 0, \gate, 0, \fadeTime, 10.1);
    ~oneShot = {
        | trigGate = 1 |
        var rate = 1;
        var x = MouseX.kr(0, 1);
        var y = MouseY.kr(0, 1);
        var last = ~pizzi3.duration * ~pizzi3.sampleRate;
        var buf = ~pizzi3;
        var trig = Impulse.ar(~cl.tempo) * trigGate;
        var trig2 = Impulse.ar(~c.tempo * 6 * 2) * trigGate;
        var start0 = 4552896;
        var start1 = 4626752;
        var start2 = Demand.ar(trig, 0, Dseq([start0, start1], inf));
        // var starts = [start0, start1, start2];
        var starts = [start1, start0, start2];
        var pat0 = [1, 0, 0, 1, 0, 0];
        var pat1 = [1, 0, 1, 0, 1, 0];
        var pat2 = [1, 0, 1, 0, 1, 1];
        var block0 = trig * Demand.ar(trig, 0, Dseq(pat0, inf));
        var block1 = trig * Demand.ar(trig, 0, Dseq(pat1, inf));
        var block2 = trig2 * Demand.ar(trig, 0, Dseq(pat2, inf));
        var blocks = [block0, block1, block2];
        var atk = 0.001;
        var length = [3, 2, 1] * (~c.beatDur / 3);
        var env = EnvGen.ar(Env.new([0, 1, 1, 0], [atk, length - (atk * 2), atk], [2, -8]), blocks);
        var demm = Demand.ar(trig, 0, Dseq([0.2, 0.1].stutter(24), inf));
        var sig = BufRd.ar(2, buf, Phasor.ar(trig, 1, 4725888, last, 4725888), interpolation: 0);
        sig = (sig * CombN.ar(sig, 1, 1 / 110, 1.5) * 0) + (sig);
        sig;
        // starts.poll;
        // sig = VadimFilter.ar(sig, 100, 0, 5);
        sig;
        sig = sig.reverse * 0.5 + MiRings.ar(
            sig, pit: 36 + -12, struct: x, damp: 0.4, pos: y, model: 5) * 0.5;
    }.play(fadeTime: 0);
});
)