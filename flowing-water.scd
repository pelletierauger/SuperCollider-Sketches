(
SynthDef(\mywater, { | rate = 0.3, depth = 0.5, amp = 1, numStreams = 3, far = 0 |
    var sound;
    numStreams.do{
        var freq, output, differentiator;
        rate = rate.linlin(0, 1, 30, 500);
        depth = depth.linlin(0, 1, 400, 1200);
        freq = LFNoise2.kr(rate).exprange(0.01, 1) * TWChoose.kr(Impulse.kr(rate), [-1, 1], [0.5, 0.5]) ;
        freq = freq * depth * 2 + depth;
        differentiator = HPZ1.kr(freq);
        differentiator = LPF.kr(differentiator, 1);
        output = SinOsc.ar(freq, 0, 0.3).dup;
        output = output * differentiator;
        if(far == 1, {
            output = LPF.ar(output, depth) * 5 * amp;
        }, {
            output = HPF.ar(output, depth) * 5 * amp;
        });
        Out.ar(0, output / numStreams);
    };
}).store;
)


(
Synth(\mywater, [\rate, 0.6, \depth, 1, \numStreams, 4, \amp, 1, \far, 0]);
Synth(\mywater, [\rate, 0.3, \depth, 0.2, \numStreams, 3, \amp, 5, \far, 1]);
Synth(\mywater, [\rate, 0.1, \depth, 0.1, \numStreams, 4, \amp, 2, \far, 0]);
)

s.sampleRate;
s.actualSampleRate;