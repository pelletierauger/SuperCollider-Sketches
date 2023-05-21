// For life performances to redundantize my loop pedal. Because it is heavy.
//
//
//     helper Synths for recording to /  playing from buffer
//     effect Synths
//     recording function which records to buffer and chops up input
//     pitch following Synth

s.boot;
s.makeGui;


//synths
(
// record synths
SynthDef(\recAudioIn,{
	arg in_bus = 0, bufnum = 0, offset = 0, duration = 1;
	var in, envelope;
	envelope = EnvGen.ar(Env([0, 0.9, 0], [duration * 0.125, duration * 0.75, duration * 0.125]));
	in = SoundIn.ar([0, 1]) * envelope;
	RecordBuf.ar(in, bufnum, offset: offset, preLevel: 0.8, doneAction: 2);
}).load(s);


SynthDef(\recBus,{
	arg in_bus, bufnum = 0, offset = 0, duration = 1;
	var in, envelope;
	envelope = EnvGen.ar(Env([0, 0.9, 0], [duration * 0.125, duration * 0.75, duration * 0.125]));
	// does not work with In (worked with SinOsc array):
	in = InFeedback.ar(in_bus, 2) * envelope;
	RecordBuf.ar(in, bufnum, offset: offset, preLevel: 0.8, doneAction: 2);
}).load(s);

SynthDef(\playBuf,{
	arg out = 0, bufnum, dir = 1, amp = 1.5;
	var signal;
	signal = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * dir, loop: 1);
	FreeSelfWhenDone.kr(signal);
	Out.ar([0,1], signal * amp);
}).add;


// kazoo synth, effect bus default: 20
SynthDef(\pitchCake,{
	arg out, bus, wet = 0, ampMul = 15;
    var in, amp, sound, effect, freq, hasFreq;
	in = SoundIn.ar([0, 1]);
    amp = Amplitude.kr(in, 0.05, 0.05, 0.5);
    # freq, hasFreq = Pitch.kr(in);
	sound = Mix.new(LFSaw.ar([0.333, 0.5] * freq) + LFPulse.ar([0.333, 0.5] * freq) * amp * ampMul);
	effect = HPF.ar(LinPan2.ar(LPF.ar(sound, SinOsc.kr(0.5, 0, 100, 400), SinOsc.kr(1, 0, 1))), 50);
	Out.ar(out, effect * (1 - wet));
	Out.ar(bus, effect * wet);
}).add;

// audio in, effect bus default: 22
SynthDef(\AudioIn, {
	arg out = 0, bus = 22, wet = 0.5, amp = 2;
	var input;
	input = SoundIn.ar(0) * amp;
	Out.ar(out, input);
	Out.ar(bus, input * wet);
}).add;

// effect Synths

SynthDef(\reverb, {
	arg in = 20, out = [0, 1], wet = 0.5;
	var input, reverb;

	input = In.ar(in);
	reverb = FreeVerb.ar(input, wet, 0.7);
	Out.ar(out, reverb);
}).add;

)


// chopped recording to buffer
(
~record =
{
arg bufnum, duration, offset, record_synth_symbol, in_bus = 0;
var record;
	record = Synth(record_synth_symbol, [\in_bus, in_bus, \bufnum, bufnum, \offset, offset, \duration, duration/44100]);
	(duration/44100).wait;
	record.run(false);
};

~recorder = {
// different buffer for multiple loops
	arg buffer, chop = true, record_synth_symbol = \recAudioIn, in_bus = 0;
	var numPieces, duration, offset, record, bufferLength, routine;

	bufferLength = buffer.numFrames;

	if(chop == true, {
		//chopped recording
		//amount of sound snippets
		numPieces = [4, 6, 8, 12, 16, 32].choose;
		("numPieces:" + numPieces).postln;

		//duration of each sound snippet and break inbetween
		duration = (0.5 * bufferLength / numPieces).floor;
		routine = Routine{
			for (0, numPieces, {
				arg i;
				offset = i * 2 * duration;
				~record.value( buffer.bufnum, duration, offset, record_synth_symbol, in_bus );
			});
			"recording finished".postln;
		}.play;
	},{
		//unchopped recording
		routine = Routine{
				~record.value( buffer.bufnum, bufferLength, 0, record_synth_symbol, in_bus );
			"recording finished".postln;
		}.play;
	});
};
)

// global buffer variables

~beatLoop = Buffer.alloc(s, 44100 * 1.0, 2);
~loop1 = Buffer.alloc(s, 44100 * 8.0, 2);
~loop2 = Buffer.alloc(s, 44100 * 16.0, 2);

// play buffer; start before recording

~loop1Play = Synth(\playBuf, [\bufnum, ~loop1.bufnum, \out, 0]);
~loop2Play = Synth(\playBuf, [\bufnum, ~loop2.bufnum]);
~beatLoopPlay = Synth(\playBuf, [\bufnum, ~beatLoop.bufnum]);

~loop1Reverse = Synth(\playBuf, [\bufnum, ~loop1.bufnum, \dir, -1, \out, 0]);
~loop2Reverse = Synth(\playBuf, [\bufnum, ~loop2.bufnum, \dir, -1, \out, 0]);
~beatLoopReverse = Synth(\playBuf, [\bufnum, ~beatLoop.bufnum, \dir, -1, \out, 0]);

// loop control
~loop1Play.run(false);
~loop1Play.run(true);

~loop2Play.run(false);
~loop2Play.run(true);

~beatLoopPlay.run(false);
~beatLoopPlay.run(true);

~loop1Play.free;
~loop2Play.free;
~beatLoopPlay.free;

~loop1Reverse.free;
~loop2Reverse.free;
~beatLoopReverse.free;

// record loops
~recorder.value(~loop1, true);
~recorder.value(~loop1, false);
~recorder.value(~loop2, true);
~recorder.value(~loop2, false, \recBus, 0);
~recorder.value(~beatLoop, true, \recBus, ~kazooBus.index );
~recorder.value(~beatLoop, true);

// plot a buffers
~beatLoop.plot;
~loop1.plot;

// other input
// pitchfollowing Synth
~kazoo = Synth(\pitchCake, [\out, 0, \bus, 20, \wet, 0]);
~kazoo.free;

// audio (mic) input
~audioIn = Synth(\AudioIn);
~audioIn.free;

~kazooBus = Bus.audio(s, 1);
~kazooToBus = Synth(\pitchCake, [\out, ~kazooBus.index]);
~kazooToBus.free;

// effects
//reverb on kazoo Synth
~reverbKazoo =  Synth.after(1, \reverb, [\in, 20]);
~reverbKazoo.free;

// control busses for wet signal and amp in Kazoo synth
~busKazooWet = Bus.control(s, 1);
~busKazooWet.set(0.9);
~kazoo.map(\wet, ~busKazooWet);

~busKazooAmp = Bus.control(s, 1);
~busKazooAmp.set(10);
~kazoo.map(\ampMul, ~busKazooAmp);

//reverb on AudioIn
~reverbAudioIn = Synth.after(1, \reverb, [\in, 22]);
~reverbAudioIn.free;

// control bus for wet signal in AudioIn;
~busAudioInWet = Bus.control(s, 1);
~audioIn.map(\wet, ~busAudioInWet);

~busAudioInWet.set(0.5);

// reverb on whole output
~reverbOut = Synth.after(1, \reverb, [\in, 0]);
~reverbOut.free;



//recording to file
s.recChannels = 2;
s.recSampleFormat = 'int24';
s.recHeaderFormat = 'wav';
s.prepareForRecord;

s.record;
s.stopRecording;

// free buffer
~loop1.free;
~loop2.free;
~beatLoop.free;