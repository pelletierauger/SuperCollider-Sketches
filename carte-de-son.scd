{SoundIn.ar(0) * 0.1}.play;
s.record;
s.stopRecording;

s.options.numInputBusChannels
ServerOptions.devices

(
s.options.inDevice = "US-600 (Bit Accurate)";
s.options.numInputBusChannels = 6;
s.boot;
)

s.meter;

(
SynthDef.new(\mic, {
    arg in = 0, out = 0, amp = 1;
    var sig;
    sig = SoundIn.ar(in!2);
    Out.ar(out, sig * amp);
}).add;
)

x = Synth(\mic);