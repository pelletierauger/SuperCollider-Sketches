// read a soundfile
(
s.waitForBoot({

    SynthDef(\wowflutter_2chan, {
        arg bufnum, out = 0, wobble_rpm=33, wobble_amp=0.05, wobble_exp=39, flutter_amp=0.03, flutter_fixedfreq=6, flutter_variationfreq=2;
        var signed_wobble = wobble_amp*(SinOsc.kr(wobble_rpm/60)**wobble_exp);
        var wow = Select.kr(signed_wobble > 0, signed_wobble, 0);
        var flutter = flutter_amp*SinOsc.kr(flutter_fixedfreq+LFNoise2.kr(flutter_variationfreq));
        var combined_defects = 1 + wow + flutter;
        var sig = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum)*combined_defects, doneAction:Done.freeSelf);
        Out.ar(out, sig);
    }).add;

    b = Buffer.read(s, "/Users/guillaumepelletier/Downloads/pianomusic.wav"); // link in code description, or use your own...
    s.sync;

    Synth(\wowflutter_2chan ,[
        \bufnum, b.bufnum,
        \out, 0,
        \wobble_rpm, 33,
        \wobble_amp, 0.04,
        \wobble_exp, 11, // best an odd power, higher values produce sharper, smaller peak
        \flutter_amp, 0.02,
        \flutter_fixedfreq, 6,
        \flutter_variationfreq, 2
    ]);
});
)