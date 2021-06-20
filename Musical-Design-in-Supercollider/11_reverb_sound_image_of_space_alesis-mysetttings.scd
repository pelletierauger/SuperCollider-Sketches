(
Ndef('barr_verb', { arg
	inAmp=0.8,
	scaleDelays=1,
	inDiffusion=0.05,
	feedback=0.5,
	decay_sec=0.5,
	decay1_sec=0.5
	// peakgain=0,
	// rqscale=1
	;
	var signal;
	var signalIn = SoundIn.ar( (0..7) ) * inAmp;
	// var signalIn = Impulse.ar(0.5) * inAmp!8;//  ++ DC.ar(0).dup(6);
	var tank;
	var	ndelaylines = 2;
	var sr = SampleRate.ir, sz = 4;
	var src, localin;
	var  times, dtimes, b;
	var l,r;
	var earlyDiffDTimes, earlyDiffSize=4;
	var apc;
	var tankIns;


	src = HPF.ar(signalIn, \inputHPF.kr(150));
	src = OnePole.ar(src, \inputLPF.kr(0.5));


	src = DelayN.ar(src, 0.1, \predelay.kr(0.0));

	src.debug(\src________________);





	times = [ 1447, 727, 613, 673, 1439, 2083, 2011, 1511, 1493, 1277, 2437, 2383, 2341, 997, 1061, 2039, 1997, 1481, 1627, 1129, 743, 983, 1091, 907, 541, 2393, 1801, 2081, 1787, 1453, 977, 2311, 691, 479, 2377, 1693, 1013, 1931, 1049, 2243, 839, 739, 1747, 601, 1823, 1123, 2467, 1297, 1613, 1361, 2207, 593, 619, 1709, 449, 937 ];



	// times = [ 1061, 1637, 1487, 307, 1789, 2131, 823, 947, 743, 521, 1433, 601, 1093, 2029, 1361, 1229, 2143, 241, 541, 1721, 1889, 1493, 1777, 509, 839, 1913, 641, 1619, 271, 1823, 283, 863, 1601, 1693, 1867, 1117, 1193, 691, 1709, 1499, 1481, 953, 607, 1297, 1409, 331, 491, 677, 2203, 419, 733, 1831, 991, 857, 1583, 2141 ]

	// times = [ 709, 2221, 1901, 3023, 3943, 1459, 1583, 257, 2251, 2617, 857, 223, 3761, 1213, 829, 353, 929, 1597, 4001, 953, 3643, 2671, 607, 3137, 3121, 349, 739, 271, 3793, 773, 2731, 1553, 2143, 1877, 3607, 1741, 4159, 1021, 3041, 2017, 3037, 2459, 997, 2999, 2083, 3517, 499, 2803, 1013, 4027, 227, 2213, 3463, 2887, 2719, 3623 ]

	// times = [ 4447, 1511, 2797, 4229, 3209, 3881, 661, 4339, 1867, 739, 1291, 457, 4297, 1861, 3709, 3253, 487, 1709, 1607, 859, 757, 4289, 1447, 1367, 4451, 2971, 967, 773, 2137, 809, 1753, 2221, 3929, 2467, 2381, 1153, 2777, 1847, 3079, 2039, 1831, 521, 2767, 641, 2693, 2659, 3257, 1999, 1279, 2287, 1877, 1277, 569, 983, 1031, 3499 ];






	times.debug(\times_______________________________);


	earlyDiffDTimes = { times.removeAt(times.minIndex) } ! ( earlyDiffSize * src.size );

	l = times.size.div(2).collect({|i| times[i*2]}) * scaleDelays;
	r = times.size.div(2).collect({|i| times[i*2 + 1]}) * scaleDelays;



	/*
		// Keith Barr dtimes

		l = nil ! ( sz * 3  ) ;
		l.size.div(3).do { |i|
		i = i * 3;
		l[i] = rrand(1000,2000);
		l[i+1] = rrand(1000,2000);
		l[i+2] = ( l[i] + l[i+1] * rrand(0.8,1.0) ).round(1);
		};

		l.debug(\l);

		r = nil ! ( sz * 3  ) ;
		r.size.div(3).do { |i|
		i = i * 3;
		r[i] = rrand(1000,2000);
		r[i+1] = rrand(1000,2000);
		r[i+2] = ( r[i] + r[i+1] * rrand(0.8,1.0) ).round(1);
		};

		r.debug(\r);
	*/



	dtimes = Routine{(earlyDiffDTimes ++ l ++ r).do { |it|it.yield}};
	// dtimes = Pseq( earlyDiffDTimes ++ l ++ r ).asStream;




	src.do { |it j|
		earlyDiffSize.do { |i|
			var dt = dtimes.next / sr;
			src[j] = AllpassN.ar(src[j], dt, dt, inDiffusion);
		};

	};



	localin = LocalIn.ar(ndelaylines);

	tankIns = [nil!src.size.div(ndelaylines), nil!src.size.div(ndelaylines)];

	ndelaylines.do { |j|
		tankIns[j].do { |it i|
			tankIns[j][i] = src[i*2+j];
		};
	};

	tankIns.debug(\tankIns);



	tank =
	ndelaylines.collect({|j|
		var processed;

		processed = localin[j];

		sz.collect { |i|
			var dt0, dt1, dt2;
			processed = processed + tankIns[j][i];

			dt0 = dtimes.next / sr;
			dt1 = dtimes.next / sr;
			dt2 = dtimes.next / sr;

			processed = FaustAllpassFComb5Decay.ar(
				in1: processed,
				max_delay_sec: dt0 ,
				delay_sec: dt0,
				decay_sec: decay_sec,
			);

			processed = FaustAllpassFComb5Decay.ar(
				in1: processed,
				max_delay_sec: dt1 ,
				delay_sec: dt1,
				decay_sec: decay_sec,
			);

			// processed = AllpassC.ar(processed, dt0, dt0, decay_sec );
			// processed = AllpassC.ar(processed, dt1, dt1, decay1_sec);


			processed = DelayC.ar(processed, dt2, dt2 * LFNoise2.kr(0.3).range(0.9,1));

			processed = OnePole.ar(processed, \damping.kr(0.0) );
			// processed = BPeakEQ.ar(processed, Rand(800,2500), Rand(0.9,1.2) * rqscale, db:peakgain);

		}
	});


	tank.debug(\tank);

	LocalOut.ar(
		[
			tank[0].last ,
			tank[1].last
		]//.reverse
		* feedback
	);

	tank = LeakDC.ar(tank);

	signal = tank.collect({|item i|
		tank[i].collect({|it j|
			tank[i][j] * ( "level_" ++ i ++ j ).asSymbol.kr(0)
		})
	});

	signal = signal.collect({|item| item.sum});


	// signal.debug(\signal);
	signal * \tail.kr(1)




});
Ndef('barr_verb').set('level_00', -1.0, 'level_11', 0.0, 'tail', 1.0, 'inputLPF', 0.058201058201058, 'inAmp', 0.8, 'scaleDelays', 1.7008154108643, 'inDiffusion', 1.2205076645288, 'level_03', 0.0, 'level_13', 0.0, 'damping', 0.28042328042328, 'level_12', 0.0, 'decay_sec', 4.0740740740741, 'level_02', 0.0, 'inputHPF', 33.362010744001, 'predelay', 0.0, 'level_01', 0.0, 'decay1_sec', 4.7619047619048, 'level_10', 1.0, 'feedback', 0.78835978835979);
Ndef('barr_verb').play;
);
