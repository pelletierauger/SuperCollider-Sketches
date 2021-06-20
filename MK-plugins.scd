(
c.set(\gate, 0, \fadeTime, 0.1);
c = {
    | pan = 0.0, trigfreq = 4 |
        var trig = Impulse.kr(trigfreq);

        var sig = Rongs.ar(
                trigger: trig,
                sustain: trig,
                f0: 0.03 * -12.midiratio,
                structure: 0.9,
                brightness: 1,
                stretch: 1,
                damping: 0.5,
                accent: 1,
                loss: 0.9,
        modeNum: 5
        );

        Splay.ar(LeakDC.ar(sig), spread: 0.25, center: pan) * 2;
}.play;
)


(
// i.set(\gate, 0, \fadeTime, 0.1);
i = {
        var trig = Impulse.kr(1);
        var note = Demand.kr(trig, 0, Dseq([-2, 0, -5, -7].stutter(4), inf)
    + Dseq([0, 7], inf));

        var sig = AnalogSnareDrum.ar(
                trig,
                infsustain: 0.0,
                accent: 0.0,
                freq: 110 * 0.5 * note.midiratio,
                tone: 0.7,
                decay: 0.1,
                snappy: 0.0,
        );
    sig = LPF.ar(sig, 1000);
        Pan2.ar(sig, TRand.kr(-1.0,1.0,trig) * 0) * 5;
}.play;
)


(
x.set(\gate, 0, \fadeTime, 0.1);
x = {
var t = Impulse.kr(0.5);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2 - 0.2], [2, 'lin', 'lin']), t);
    var note = Demand.kr(t, 0, Dseq((4..5)/10, inf));
    var sig = NeoVarSawOsc.ar(110 * 0.midiratio * [1, 1.001], note, 1 - (env * 0.5)) * 2;
    sig = LPF.ar(sig, 2000 + (500 * env)) * 0.5;
    sig * env;
}.play;
)

(1..2)