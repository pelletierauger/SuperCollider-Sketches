(


SynthDef("waveguideFlute", { arg scl = 0.2, pch = 72, ipress = 0.9, ibreath = 0.09, ifeedbk1 = 0.4,

							ifeedbk2 = 0.4, dur = 1, gate = 1, amp = 2;



	var kenv1, kenv2, kenvibr, kvibr, sr, cr, block;

	var poly, signalOut, ifqc;

	var aflow1, asum1, asum2, afqc, atemp1, ax, apoly, asum3, avalue, atemp2, aflute1;

	var fdbckArray;



	sr = SampleRate.ir;

	cr = ControlRate.ir;

	block = cr.reciprocal;



	ifqc = pch.midicps;



	// noise envelope

	kenv1 = EnvGen.kr(Env.new(

		[ 0.0, 1.1 * ipress, ipress, ipress, 0.0 ], [ 0.06, 0.2, dur - 0.46, 0.2 ], 'linear' )

	);

	// overall envelope

	kenv2 = EnvGen.kr(Env.new(

		[ 0.0, amp, amp, 0.0 ], [ 0.1, dur - 0.02, 0.1 ], 'linear' ), doneAction: 2

	);

	// vibrato envelope

	kenvibr = EnvGen.kr(Env.new( [ 0.0, 0.0, 1, 1, 0.0 ], [ 0.5, 0.5, dur - 1.5, 0.5 ], 'linear') );



	// create air flow and vibrato

	aflow1 = LFClipNoise.ar( sr, kenv1 );

	kvibr = SinOsc.ar( 5, 0, 0.1 * kenvibr );



	asum1 = ( ibreath * aflow1 ) + kenv1 + kvibr;

	afqc = ifqc.reciprocal - ( asum1/20000 ) - ( 9/sr ) + ( ifqc/12000000 ) - block;



	fdbckArray = LocalIn.ar( 1 );



	aflute1 = fdbckArray;

	asum2 = asum1 + ( aflute1 * ifeedbk1 );



	//ax = DelayL.ar( asum2, ifqc.reciprocal * 0.5, afqc * 0.5 );

	ax = DelayC.ar( asum2, ifqc.reciprocal - block * 0.5, afqc * 0.5 - ( asum1/ifqc/cr ) + 0.001 );



	apoly = ax - ( ax.cubed );

	asum3 = apoly + ( aflute1 * ifeedbk2 );

	avalue = LPF.ar( asum3, 2000 );


	aflute1 = DelayC.ar( avalue, ifqc.reciprocal - block, afqc );



	fdbckArray = [ aflute1 ];



	LocalOut.ar( fdbckArray );



	signalOut = avalue;


	OffsetOut.ar( 0, [ signalOut * kenv2, signalOut * kenv2 ] );



}).add;


)


// test the flute

s.sendMsg("/s_new", "waveguideFlute", -1, 0, 0, "amp", 0.5, "dur", 5, "ipress", 0.90, "ibreath", 0.00536, "ifeedbk1", 0.4, "ifeedbk2", 0.4, "pch", 60 );


// test the flute player's skills:

(


Routine({

	var pitches, durations;



	pitches = Pseq( [ 47, 49, 53, 58, 55, 53, 52, 60, 54, 43, 52, 59, 65, 58, 59, 61, 67, 64, 58, 53, 66, 73 ], inf ).asStream;

	durations = Pseq([ Pseq( [ 0.15 ], 17 ), Pseq( [ 2.25, 1.5, 2.25, 3.0, 4.5 ], 1 ) ], inf).asStream;


	17.do({

		var rhythm;

		rhythm = durations.next;

		s.sendMsg("/s_new", "waveguideFlute", -1, 0, 0, "amp", 0.6, "dur", rhythm, "ipress", 0.93,

			"ibreath", 0.00536, "ifeedbk1", 0.4, "ifeedbk2", 0.4, "pch", pitches.next );

		rhythm.wait;

	});



	5.do({

		var rhythm;

		rhythm = durations.next;

		s.sendMsg("/s_new", "waveguideFlute", -1, 0, 0, "amp", 0.6, "dur", rhythm + 0.25, "ipress",

			0.93, "ibreath", 0.00536, "ifeedbk1", 0.4, "ifeedbk2", 0.4, "pch", pitches.next

		);

		rhythm.wait;

	});



}).play;

)


