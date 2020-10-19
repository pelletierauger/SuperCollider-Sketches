(
SynthDef.new(\limit, {
    arg in, out = 0;
    var sig, compSig;
    sig = In.ar(in, 2);
    /*    compSig = Compander.ar(sig, sig,
    thresh: 0.1,
    slopeBelow: 1,
    slopeAbove: 0.5,
    clampTime: 0.01,
    relaxTime: 0.01
    );*/
    //     sig = (sig * 0.95 + (compSig * 0.025));
    sig = Limiter.ar(sig, 0.97, 0.01);
    Out.ar(0, sig);
}).add;
)

b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/Dropbox/Art/cpp/supercollider-Version-3.9.3/sounds/a11wlk01-44_1.aiff");
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/sons/0002 7-Audio.aif");
b = Buffer.read(s, "/Users/guillaumepelletier/Desktop/sons/slide-0008-propre.wav");
// Hear it raw:
b.play



(
Ndef(\verb, {
    var input, output, delrd, sig, deltimes;

    // Choose which sort of input you want by (un)commenting these lines:
    input = Pan2.ar(PlayBuf.ar(1, b, loop: 0), -0.5); // buffer playback, panned halfway left
    //input = SoundIn.ar([0,1]); // TAKE CARE of feedback - use headphones
    //input = Dust2.ar([0.1, 0.01]); // Occasional clicks

    // Read our 4-channel delayed signals back from the feedback loop
    delrd = LocalIn.ar(4);

    // This will be our eventual output, which will also be recirculated
    output = input + delrd[[0,1]];

    // Cross-fertilise the four delay lines with each other:
    sig = [output[0]+output[1], output[0]-output[1], delrd[2]+delrd[3], delrd[2]-delrd[3]];
    sig = [sig[0]+sig[2], sig[1]+sig[3], sig[0]-sig[2], sig[1]-sig[3]];
    // Attenutate the delayed signals so they decay:
    sig = sig * [0.4, 0.37, 0.333, 0.3];

    // Here we give delay times in milliseconds, convert to seconds,
    // then compensate with ControlDur for the one-block delay
    // which is always introduced when using the LocalIn/Out fdbk loop
    deltimes = [101, 143, 165, 177] * 0.001 - ControlDur.ir;

    // Apply the delays and send the signals into the feedback loop
    LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));

    // Now let's hear it:
    output

}).play
)


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
    deltimes = [101, 143, 165, 177] * 0.125 * 0.midiratio * 0.001 - ControlDur.ir;

    // Apply the delays and send the signals into the feedback loop
    sig = LPF.ar(sig, (60 + 0 + 36).midicps) * amp;


    // sig = sig + (BPF.ar(sig, In.kr(~peakFreqBus, 1)) * In.kr(~peakAmpBus, 1));
    // sig = HPF.ar(sig, 50);
    LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));

    // Now let's hear it:

    Out.ar(~limitBus, output);
}).add;
)
(60 + 36).midicps
(
~limitSynth.free;
~limitSynth = Synth.new(\limit, [\in, ~limitBus, \out, 0], ~fxGroup);
~reverbSynth.free;
~reverbSynth = Synth.new(\reverb, [\in, ~reverbBus, \out, 0], ~fxGroup);
)

(
~sourceGroup = Group.new;
~fxGroup = Group.after(~sourceGroup);
~reverbBus = Bus.audio(s, 2);
~limitBus = Bus.audio(s, 2);
)


(
SynthDef(\mod, {
    |out = 0, n = 1|
    Out.kr(out, n);
}).add;
)

~modBus = Bus.control(s, 1);
~peakFreqBus = Bus.control(s, 1);
~peakAmpBus = Bus.control(s, 1);

~modSynth = Synth(\mod, [out: ~modBus]);
~modSynth.free;
~peakFreqSynth = Synth(\mod, [out: ~peakFreqBus]);
~peakFreqSynth.free;
~reverbSynth.free;
~peakAmpSynth = Synth(\mod, [out: ~peakAmpBus]);
~peakAmpSynth.free;
~pos = 0;
(
MIDIIn.removeFuncFrom(\control, ~control);
~control = {arg ... args;
        args[2].postln;
    if (args[2] == 91, {
        var n = args[3] / 128;
        ~modSynth.set(\n, n * 1);
    });
    if (args[2] == 93, {
        var n = args[3] / 128;
        ~pos = n;
        ~velocityScalar = args[3] / 128;
    });
    if (args[2] == 32, {~curAlg = ~curAlg + 1; ~curAlg.postln;});
/*    if (args[2] == 93, {
        var n = args[3] / 128;
        n = n.linlin(0, 1, 200, 8000);
        ~peakFreqSynth.set(\n, n);
        n.postln;
    });
    if (args[2] == 73, {
        var n = args[3] / 128;
        ~peakAmpSynth.set(\n, n);
    });*/
};
MIDIIn.addFuncTo(\control, ~control);
)


// Producing a note

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 1;
    var rate = (num - 60).midiratio;
{
        var l = BufSamples.kr(b);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 0.5], ['lin', -8]), doneAction: 2);
        var sig = PlayBuf.ar(2, b, rate: rate, startPos: ~pos * l); // buffer playback, panned halfway left

        Out.ar(~reverbBus, sig * 40 * env * (vel / 128));
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)





(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 1;
    var rate = (num - 60).midiratio;
{
        var l = BufSamples.kr(b);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 1], ['lin', -8]), doneAction: 2);
        var sig = PlayBuf.ar(2, b, rate: rate, startPos: ~pos * l); // buffer playback, panned halfway left

        Out.ar(~reverbBus, sig * 40 * env * (vel / 128));
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)



(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
~noteOn = {
    arg src, chan, num, vel;
    var dur = 1;
    var rate = (num - 60).midiratio;
{
        var l = BufSamples.kr(b);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.01, 1], ['lin', -8]));
        var env2 = EnvGen.kr(Env.new([0, 1, 0], [0.001, 10], ['lin', -8]), doneAction: 2);
        var sig = PlayBuf.ar(2, b, rate: rate, startPos: ~pos * l); // buffer playback, panned halfway left



            var input, output, delrd, deltimes, amp;

         sig = sig * 40 * env * (vel / 128);

    input = sig;
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
    deltimes = [101, 143, 165, 177] * 0.125 * 0.001 - ControlDur.ir;

    // Apply the delays and send the signals into the feedback loop
    sig = LPF.ar(sig, 2000) * amp;

        // sig = sig + (BPF.ar(sig, In.kr(~peakFreqBus, 1)) * In.kr(~peakAmpBus, 1));
    // sig = HPF.ar(sig, 50);
    LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));

    // Now let's hear it:

        // Out.ar(~limitBus, output);




        Out.ar(~limitBus, HPF.ar(output, Line.kr(50, 2000, 5)));
}.play;
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
)