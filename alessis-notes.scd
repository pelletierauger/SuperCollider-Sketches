myServer.options.memSize = 65536;
s.options.memSize;
s.options.memSize = 8192 * 8 * 2;

(
~test0.free;
~test0 = {
    var sig = SinOsc.ar(220)!2 * 0.1;
    Out.ar(~reverbBus, sig);
    // sig;
}.play;
)

~reverbBus

(
~test.free;
~test = {
    var sig = In.ar(~reverbBus, 2);
    // Out.ar(0, sig);
    // sig = sig + SinOsc.ar(440, mul: 0.1);
    sig;
}.play;
)


~reverbBus = Bus.audio(s, 2);

(
x = {
      var sig = SinOsc.ar(220)!2 * 0.1;
    // var env = EnvGate
    Out.ar(0, sig * EnvGate.new());
    // sig * 0;
}.play;
)
x.set(\gate, 0, \fadeTime, 5)



// ---------------- Apprentissages
1 + 2!2


(
{
     var tFreqMod = {Rand(110, 440)};
    var sig = SinOsc.ar(tFreqMod!4);
    sig;
}.plot(1);
)