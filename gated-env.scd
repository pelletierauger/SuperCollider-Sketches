

(
x = {
    | relGate = 0 |
    var amp = EnvGen.ar(
        envelope: Env([1, 1, 0], [0, 5], ['lin', -8], releaseNode: 1),
        gate: Trig.kr(relGate),
        doneAction: 2
    );
    var op2 = SinOsc.ar(55) * Line.kr(10, 2, 2);
    var op1 = SinOsc.ar(440 * 2, op2 % 2pi);
    var op0 = SinOsc.ar(440, op1 * (1 + (1 - amp * 20)) % 2pi) * 0.1 * amp;
    op0!2;
}.play;
)

x.set(\relGate, 1);
