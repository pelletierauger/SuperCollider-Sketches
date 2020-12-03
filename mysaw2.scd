(
{MySaw2.ar(1) * 1!2}.plot(2);
)

(
// x.set(\gate, 0, \fadeTime, 2);
x = {
    var sig = MySaw2.ar(220 * -24.midiratio, mod: 4 + (SinOsc.kr(0.1 * [1, 1.01]) * 4));
    // LPF.ar(sig, 440) * 1;
    sig;
}.play(fadeTime: 2);
)

s.record;
s.stopRecording;

7.midiratio