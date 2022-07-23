// hacking a triangle --> sawtooth wavetable
(
f = SoundFile.openWrite("~/tri-saw.wav".standardizePath, "wav", "float", 1, 44100);

if(f.notNil) {
	var wt = Signal.newClear(2048);
	protect {
		50.do { |i|
			var frac = 0.5 - (i / 100);  // (0.5, 0.49 .. 0.01)
			var peakI = (2048 * frac).round.asInteger;
			var remain = 2047 - peakI;
			(0 .. peakI).do { |j|
				wt[j] = (j / peakI) * 2 - 1;
			};
			(peakI .. 2047).do { |j|
				wt[j] = ((j - peakI) / remain) * -2 + 1;
			};
			f.writeData(wt);
		};
	} { f.close };
};
)

// convert to MultiWtOsc format
w = WavetablePrep("~/tri-saw.wav".standardizePath, wtSize: 2048, numMaps: 8, ratio: 2, filter: \tenPctSlope).read;

w.write("~/tri-saw-wt.wav".standardizePath);

b = Buffer.read(s, "~/tri-saw-wt.wav".standardizePath);

// simple oscillator
(
a = {
	var sig = MultiWtOsc.ar(
		MouseX.kr(50, 800, 1),
		MouseY.kr(0, 48.999, 0),
		bufnum: b
	);
	(sig * 0.1).dup
}.play;
)

// hard sync
(
a = {
	// sync freq should be below oscillator freq
	var sync = LFTri.ar(50);
	var sig = MultiWtOsc.ar(
		MouseX.kr(50, 800, 1),
		MouseY.kr(0, 48.999, 0),
		bufnum: b,
		hardSync: sync
	);
	(sig * 0.1).dup
}.play;
)

// windowed sync
(
~nT.sched(~nT.timeToNextBeat(quant: 4), {
a.free;
    a = {
    var trig = Impulse.kr(~nT.tempo * 1);

	var sync = LFTri.ar(55 * Demand.kr(trig, 0, Dseq([0, -2, -5, 2].midiratio, inf)));
    var e = EnvGen.kr(Env([0.1, 1, 0.1], [0.005, 1 - 0.2], [2, -8, 'lin']), trig);
    var sig = MultiWtOsc.ar(
        // MouseX.kr(50, 800, 1),
        20 + (e * 100),
        0 + (e * 48),
            // wtPos: 0,
        // MouseY.kr(0, 48.999, 0),
            // squeeze: -1.5,
		bufnum: b,
            ratio: 1,
		// try also with more oscillators
            numOscs: 8,
            // detune: 1.11,
		hardSync: sync
	);
        // sig = VAKorg35.ar(sig, freq: 2200, res: 0, overdrive: 0.05);
    sig = VadimFilter.ar(sig, 8000 * e + 100, 0, 1);
	(sig * (sync * 5).clip(-1, 1) * 0.5).dup
}.play;
});
)