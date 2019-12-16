(
var g, item, preset = 0;
var dx7patches = Array.newClear(16384);
var r = File("DX7.afx".resolveRelative,"r");
16384.do({arg item;
	dx7patches[item] = r.getLine;
    // r.getLine.postln;
});
item = 0;
dx7patches[16383];
g = dx7patches[preset%16384];
g = (g.at((item*2)) ++ g.at((item*2) + 1)).postln.asInt;
~cirklonCCparse[0][0];
)



// This function is what is called when using the synth.
mainCaller = { arg note, vel, preset;
	if(vel > 0,{
        // Here, g is set to the current dx7 patch...
		var g = dx7patches[preset%16384];
        // The loop below iterates over the selected patch.
        // It iterates 145 times, because a patch contains 290 characters
        // and this loop reads two characters at a time ((item * 2) and (item * 2 + 1))
        // Characters are numbers between 0 and 9... This loop concatenates two consecutive
        // numbers, adds them in an array, and then uses the .asInt method to get an integer.
        // So... for example, the first two characters of the first patch are 1 and 7.
        // Using an array is just a way to not add them and get "8". Instead, we get "17".
		145.do({arg item;
			var k = (g.at((item*2)) ++ g.at((item*2) + 1)).asInt;

            // What the f() function does...
            // It is passed three parameters.
            // The third one being this number we just got, 17...
            // The first two parameters fetch two values in a subarray of
            // circklonCCparse...
			f.value(cirklonCCparse[item][0],cirklonCCparse[item][1],k);
			//~midiOutDX7.control(~cirklonCCparse[item][0],~cirklonCCparse[item][1],k);
		});
	});
	noteParser.value(vel, note)
};


(
// cirklonCCprase is an array containing sub-arrays. It contains 145 arrays.
// So... half as many arrays as there are characters in a dx7 patch... and we iterate
// over the dx7 patch characters two at a time.
// But the way cirklonCCparse is used in the above loop doesn't even consider the
// specific dx7 patch currently in use.. it just goes through this list every time,
// regardless of the patch currently in use.
// And every time the 145 loop runs, it accesses [item][0] and [item][1], so
// it really just reads linearly through this list, which could (I think) be just a
// big one-dimensional array...
~cirklonCCparse = #[
	[4,0],[4,1],[4,3],[4,5],[4,4],[4,10],[4,7],[4,8],[4,9],[4,6],[4,2],
	[4,11],[4,12],[4,13],[4,14],[4,15],[4,16],[4,17],[4,18],
	[4,48],[3,0],[3,114],[3,12],[3,72],[3,24],[3,30],[3,36],[3,42],[3,48],[3,54],[3,60],[3,66],[3,6], [3,90],[3,102],[3,84],[3,96], [3,78],[3,108],[3,18],
	[4,49],[3,1],[3,115],[3,13],[3,73],[3,25],[3,31],[3,37],[3,43],[3,49],[3,55],[3,61],[3,67],[3,7], [3,91],[3,103],[3,85],[3,97], [3,79],[3,109],[3,19],
	[4,50],[3,2],[3,116],[3,14],[3,74],[3,26],[3,32],[3,38],[3,44],[3,50],[3,56],[3,62],[3,68],[3,8], [3,92],[3,104],[3,86],[3,98], [3,80],[3,110],[3,20],
	[4,51],[3,3],[3,117],[3,15],[3,75],[3,27],[3,33],[3,39],[3,45],[3,51],[3,57],[3,63],[3,69],[3,9], [3,93],[3,105],[3,87],[3,99], [3,81],[3,111],[3,21],
	[4,52],[3,4],[3,118],[3,16],[3,76],[3,28],[3,34],[3,40],[3,46],[3,52],[3,58],[3,64],[3,70],[3,10],[3,94],[3,106],[3,88],[3,100],[3,82],[3,112],[3,22],
	[4,53],[3,5],[3,119],[3,17],[3,77],[3,29],[3,35],[3,41],[3,47],[3,53],[3,59],[3,65],[3,71],[3,11],[3,95],[3,107],[3,89],[3,101],[3,83],[3,113],[3,23],
];
~cirklonCCparse.size.postln;
)


// So what does the f function do? The very first time it is called,
// if the preset = 0, its arguments will be x = 4, y = 0, and z = 17...
// It starts by testing if x == 3...
// Most sub arrays in cirklonCCparse begin by 3, but some begin by 4.
// Those are the only two options.
// So if x == 3, it well set vr[0] to 17, and vr[0 + 128] also to 17...
// And if not (if x == 4), it will do nothing.
// So what is vr???
(
f = { arg x, y, z; //y value, z cc no
	if(x == 3,
		{ vr[y] = z },
		{ vr[y + 128] = z }
	)
};
)

// vr is first defined this way : vr = Array.fill(256, 63),
// So 256 copies of the number 63..
// I'm assuming that 63 was chosen because it is almost halfway between
// 0 and 128... 63 must be an average for a setting that can exist
// between 0 and 128... So vr would be a set of 256 of those settings..


// vr appears to be used a lot throughout the program.
// In the defme function (truncated below),
// we loop 6 times to get 6 y values and for each of those 6 y values,
// we get 4 x values... What is this ?
// It appears to relate to the calculations required to generate
// envelopes... but why 4 x values for each y values ?
// So... the defme function receives only two arguments, note and vel.
// It then defines a few variables, three of them being two dimensional arrays,
// envL, envR, envC, which potentially are use to store an envelope left,
// envelope right, and envelope center... but the sounds produced by
// the dx7 are monophonic, so I don’t know what’s that about...
// And also envL is bigger than the other two 2D arrays...

// So the first big thing that defme() does is call the envCal.() function
// to do the envelope calculations... and it uses vr a lot...  it is passed
// a very large list of arguments...
defme = { arg note, vel;
	var a, bil, ptchEnv,
	envL  = Array2D.new(6,5),
	envR  = Array2D.new(6,4),
	//selector = [66, 48, 54, 60, 66],
	envC  = Array2D.new(6,4);
	6.do { arg y;
		4.do(
			{
				arg x;//selector = [66, 48, 54, 60, 66],
				dumm = envCal.value(
					vr[selector[x] + y],//vr1, //Level Current
					vr[selector[x + 1] + y],//vr2, //Level Next
					(99-vr[(24 + (x * 6)) + y]),//vrx, //Speed
					vr[6 + y],//vrv, //Volume
					vel,//velo,//Velocity
					vr[108 + y],//velSens,
					vr[78 + y],//level_scaling_bkpoint,
					vr[90 + y],//level_scaling_l_depth,
					vr[102 + y],//level_scaling_r_depth,
					vr[84 + y],//level_scaling_l_curve,
					vr[96 + y],//level_scaling_r_curve,
					(note + 3 + vr[131] - 24),//transposed_note,
					vr[72 + y],//rate_scaling,//not implemented yer
					vr[18 + y]//amp_mod_sens;//no
				);
				envL[y,x] = dumm[0];
				envR[y,x] = dumm[2];
				if(dumm[0] > dumm[1], { envC[y,x] = 3} ,{envC[y,x] = -3});
		});
        // envL is the bigger array...
        // For every row (y) of envL... the content of column 4 is set
        // to the content of column 0.
		envL[y,4] = envL[y,0];
	};

    // .... defme actually continues
};

// vr[131] appears to be about note transposition.

// When all is said and done, and the note is struck with the DX7 SynthDef,
// 6 amplitudes envelopes are generated, clearly one for each operator.
// This is the first one.

envEnv1 = Env.new([(-1 * env1L0).dbamp ,(-1 * env1L1).dbamp, (-1 * env1L2).dbamp, (-1 * env1L3).dbamp, (-1 * env1L4).dbamp], [env1R0,env1R1,env1R2,env1R3], [env1C0,env1C1,env1C2,env1C3], 3);
envAmp1 = EnvGen.kr(envEnv1, gate, doneAction:0 );

// envEnv1, like most SuperCollider envelopes, contains 3 arrays.
// An array of levels, and array of times (durations), and an array of curves values.
// So envL, envR and envC is "envelope - level", "envelope - duration (or rate, I assume)",
// and "envelope - curve".
// It has 5 levels, and so it has 4 segments in between the levels...
// Which is why envL is bigger!

// So envEnv1 is then used in an instance of envGen, called envAmp1.


// Okay, so the usage of the defme() function is to return all the arguments needed
// for the \DX7 SynthDef.
// I found this line inside the noteParser.() function:

noteArrayDX7[note] = Synth(\DX7, defme.value(note, vel), novaDX7);

// Interestingly, defme.() only gets two arguments and figures out everything
// from this... 