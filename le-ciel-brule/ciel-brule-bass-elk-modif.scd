(
~nT.schedAbs(~nT.nextBar + 0.5 - 0.12, {
    ~bass.free;
    ~bass = {
        var tonic, dem2, sig, sig2, start, buf, end, env, trig, dif;
        buf = ~buf;
        trig = Impulse.ar(~nT.tempo * 0.0625);
        env = EnvGen.ar(Env.new([0.0, 1, 0.001], [0.7 * 1, 12 * 2], [2, -8]), trig);
        start = 15000;
        tonic = ~toMidi.("Gb1");
        dem2 = tonic + Demand.ar(trig, 0, Dseq([2, 0].stutter(1), inf));
        end = start + floor(BufSampleRate.ir(buf) / dem2.midicps);
        // end.poll;
        dif = 0;
        sig = BufRd.ar(2, buf, Phasor.ar(0, 1, start, end, start), interpolation: 0);
        // sig2 = BufRd.ar(2, buf, Phasor.ar(0, 1, start - dif, end - dif + 1, start), interpolation: 0);
        // sig = sig + sig2;
        sig = sig * 2;
        // sig = MiBraids.ar(dem2) * 0.1!2;
        sig = VadimFilter.ar(sig * 0.5, 2500 * env.lag(0.5) + 100, 0, 1);
        sig * 1.5 * env;
    }.play(fadeTime: 0);
});
)

// Avec MiRings

(
~nT.schedAbs(~nT.nextBar + 0.5 - 0.12, {
    ~bass.free;
    ~bass = {
        var tonic, dem2, sig, sig2, start, buf, end, env, trig, dif;
        buf = ~buf;
        trig = Impulse.ar(~nT.tempo * 0.0625);
        env = EnvGen.ar(Env.new([0.0, 1, 0.001], [0.7 * 1, 12 * 2], [2, -8]), trig);
        start = 15000;
        tonic = ~toMidi.("Gb1");
        dem2 = tonic + Demand.ar(trig, 0, Dseq([2, 0].stutter(1), inf));
        end = start + floor(BufSampleRate.ir(buf) / dem2.midicps);
        // end.poll;
        dif = 0;
        sig = BufRd.ar(2, buf, Phasor.ar(0, 1, start, end, start), interpolation: 0);
        // sig2 = BufRd.ar(2, buf, Phasor.ar(0, 1, start - dif, end - dif + 1, start), interpolation: 0);
        // sig = sig + sig2;
        sig = sig * 2;
        // sig = MiBraids.ar(dem2) * 0.1!2;
        sig = VadimFilter.ar(sig * 0.5, 2500 * env.lag(0.5) + 100, 0, 1);
        sig = sig * 1.5 * env;
        sig = MiRings.ar(
            sig, pit: dem2.lag(2), struct: 0.2, damp: 0.2, model: 1);
    }.play(fadeTime: 0);
});
)

s.record;
s.stopRecording;
~recordingFolder.openOS;

{SinOsc.ar(220) * 0.1!2;}.play;