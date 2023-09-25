(
w = Window.new("soundfile test", Rect(200, 300, 740-310, 280+40));
a = SoundFileView.new(w, Rect(20,20, 700-310, 240));
b = Button(w, Rect(20, 280-5, 75, 30))
        .states_([
            ["Play", Color.black, Color.white],
            ["Stop", Color.black, Color.gray(0.75)]
        ])
        .action_({ arg butt;
    // butt.value.postln;
    if (butt.value == 1,{
    x = Synth.new(\samplerStereoEnv,
        [\buf, ~buf, \spos, a.selections[0][0], \sus, a.selections[0][1]]
    );
    c.string = "[ " ++ a.selections[0][0] ++ ", " ++ a.selections[0][1] ++ " ]";
    AppClock.sched((a.selections[0][1]/s.sampleRate), {b.value = 0});
});
    if (butt.value == 0,{x.free});
});
c = StaticText(w, Rect(120, 284-5, 240, 20));
c.string = "[ " ++ 0 ++ ", " ++ 0 ++ " ]";
c.font = Font("Inconsolata", 16);
b.font = Font("Inconsolata", 16);
b.focusColor = Color(0,0,0,1);
b.canFocus = false;
f = SoundFile.new;
f.openRead("/Users/guillaumepelletier/Desktop/pizzi3.wav");
// f.inspect;
// Font
a.soundfile = f;
a.read(0, f.numFrames);
// b.value = 0
a.timeCursorOn = true;
a.timeCursorColor = Color.red;
a.gridColor = Color.gray(0.35, 0);
a.timeCursorPosition = 2050;
a.drawsWaveForm = true;
a.gridOn = true;
a.gridResolution = 0.2;

w.front;
)

a.selections[0]

a.selections
s.record;
s.stopRecording;
~ro.()
(
~h.stop;
~h = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([0.25], inf),
    \spos, 3524471,
    \sus, 13882/2,
    \rel, 0.6,
    \buf, ~buf,
    \amp, Pseq([1, 0.25, 0.5, 0.25], inf)
).play(~nT, quant: 1);
)

(
~g.stop;
~g = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([Rest(0.5), 0.5], inf),
    \spos, 3476420,
    \sus, 33255,
    \buf, ~buf,
    \amp, Pseq([1, 0.25, 0.5, 0.25], inf)
).play(~nT, quant: 1);
)

(
~i.stop;
~i = Pbind(
    \instrument, \samplerStereoEnv,
    \dur, Pseq([Rest(0.75), 1.25], inf),
    \spos, 4138902,
    \sus, 25334,
    \buf, ~buf,
    \amp, Pseq([0.125], inf)
).play(~nT, quant: [1, 0.005]);
)



AppClock.sched((a.selections[0][1]/s.sampleRate), {b.value = 0});

b.focus = false
b.properties

b.value




(
SynthDef(\samplerStereoEnv, {
    arg buf, rate = 1, spos = 0, pan = 0, amp = 1, out = 0, atk = 0.001, sus = 1, rel = 0.01;
    var env = EnvGen.kr(Env([0, 1, 1, 0], [atk, sus/s.sampleRate, rel], [-8, -8, -8, -8]), doneAction: 2);
    var sig = PlayBuf.ar(
        numChannels: 2,
        bufnum: buf,
        rate: rate * BufRateScale.ir(buf),
        startPos: spos,
        doneAction: 2
    ) * amp * env;
    // sig = ~v.(sig, 1000);
    sig = Balance2.ar(sig[0], sig[1], pan);
    Out.ar(out, sig);
    // Out.ar(~distBus, sig * 4);
}).add;
)


~buf = Buffer.read(s, "/Users/guillaumepelletier/Desktop/pizzi3.wav");

~buf.play
Synth.new(\samplerStereoEnv, [\buf, ~buf, \spos, a.selections[0][0]])
Synth.new(\samplerStereoEnv, [\buf, ~buf, \spos, a.selections[0][0]/s.sampleRate, \sus, a.selections[0][1]/s.sampleRate]);

a.selections[0][0]


Synth.new(\samplerStereoEnv, [\buf, ~buf, \spos, 130000, \sus, 44100])