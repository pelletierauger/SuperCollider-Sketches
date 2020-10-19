(
SynthDef.new(\reverb, {
    arg in;
    var input, output, delrd, sig, deltimes, amp;

    input = In.ar(in, 2);
    amp = In.kr(~modBus, 1);

    // Read our 4-channel delayed signals back from the feedback loop
    delrd = LocalIn.ar(4);

    // This will be our eventual output, which will also be recirculated
    output = input + delrd[[0,1]];

    // Cross-fertilise the four delay lines with each other:
    sig = [output[0]+output[1], output[0]-output[1], delrd[2]+delrd[3], delrd[2]-delrd[3]];
    sig = [sig[0]+sig[2], sig[1]+sig[3], sig[0]-sig[2], sig[1]-sig[3]];
    // Attenutate the delayed signals so they decay:
    sig = sig * [0.4, 0.37, 0.333, 0.3] * 1.3;

    // Here we give delay times in milliseconds, convert to seconds,
    // then compensate with ControlDur for the one-block delay
    // which is always introduced when using the LocalIn/Out fdbk loop
    deltimes = [101, 143, 165, 177] * 0.125 * 36.midiratio * 0.001 - ControlDur.ir;

    // Apply the delays and send the signals into the feedback loop
    sig = LPF.ar(sig, (60 + 0 + 36).midicps) * amp;


    // sig = sig + (BPF.ar(sig, In.kr(~peakFreqBus, 1)) * In.kr(~peakAmpBus, 1));
    // sig = HPF.ar(sig, 50);
    LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));

    // Now let's hear it:
    output = Limiter.ar(output, 0.97, 0.01);
    Out.ar(0, output);
}).add;
)

(
SynthDef.new(\reverb, {
    | in |
    var sig;
    sig = In.ar(in, 2);
    sig = GVerb.ar(sig);
    Out.ar(~limitBus, sig);
}).add;
)

(
~limitSynth.free;
~limitSynth = Synth.new(\limit, [\in, ~limitBus, \out, 0], ~fxGroup);
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
)