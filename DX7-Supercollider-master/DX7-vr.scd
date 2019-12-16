
// The contents of vr[]

// --------------------------------------------------------------------------------- //
// 0 to 5
// From "op1.frequency_coarse" to "op6.frequency_coarse"
//
// From 0 to 5, we have the coarse pitch values of each
// operator, from op1 to op6. Those coarse pitch values are accessed
// through a reference array, coarseArrR, like this: coarseArrR[vr[0 + k]]
// where k is the increment of a loop that goes from 0 to 5.
// So it could be accessed more simply: coarseArrR[vr[k]] but the 0 makes it clearer.
// And coarseArrR is an array of 32 numbers :
// [0.5,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
// Which are scalars that are applied to the intended pitch. They are really pitch ratios.
// If I play an A at 440 Hz, this frequency will be multiplied by one of those numbers.
// But if the operator’s frequency is set to fix, then the proper reference array is this:
/*coarseArrF = #[
	1, 10, 100, 1000,
	1, 10, 100, 1000,
	1, 10, 100, 1000,
	1, 10, 100, 1000,
	1, 10, 100, 1000,
	1, 10, 100, 1000,
	1, 10, 100, 1000,
	1, 10, 100, 1000
],*/

// --------------------------------------------------------------------------------- //
// 6 to 11

// From "op1.output_level" to "op6.output_level"
// vr[6 + y], //vrv, //Volume


// --------------------------------------------------------------------------------- //
// 12 to 17

// From "op1.detune" to "op6.detune"
// trDetune = vr[12 + c];


// --------------------------------------------------------------------------------- //
// 18 to 23

// From "op1.amplitude_modulation_sensitivity" to "op6.amplitude_modulation_sensitivity"
// vr[18 + y] // amp_mod_sens;//no


// --------------------------------------------------------------------------------- //
// 24 to 47

// (99 - vr[(24 + (x * 6)) + y])
// Looping 6 times through y and 4 times through x...
// We are using 6 * 4 values, so 24.

// 24, 30, 36, 42 = "op1.env.rate1" to "op1.env.rate4"
// 25, 31, 37, 43 = "op2.env.rate1" to "op2.env.rate4"
// 26, 32, 38, 44 = "op3.env.rate1" to "op3.env.rate4"
// 27, 33, 39, 45 = "op4.env.rate1" to "op4.env.rate4"
// 28, 34, 40, 46 = "op5.env.rate1" to "op5.env.rate4"
// 29, 35, 41, 47 = "op6.env.rate1" to "op6.env.rate4"


// --------------------------------------------------------------------------------- //
// 48 to 71

// The values from 48 to 71 are all accessed via this reference array, selector[]
// vr[selector[x] + y], //vr1, // Level Current
// vr[selector[x + 1] + y],  //vr2, // Level Next
// Where x is each segment of the envelope, and y, each operator

// 48, 54, 60, 66 = "op1.env.level1" to "op1.env.level4"
// 49, 55, 61, 67 = "op2.env.level1" to "op2.env.level4"
// 50, 56, 62, 68 = "op3.env.level1" to "op3.env.level4"
// 51, 57, 63, 69 = "op4.env.level1" to "op4.env.level4"
// 52, 58, 64, 70 = "op5.env.level1" to "op5.env.level4"
// 53, 59, 65, 71 = "op6.env.level1" to "op6.env.level4"

// --------------------------------------------------------------------------------- //
// 72 to 77

// "op1.rate_scale" to "op6.rate_scale"
// Not implemented yet.


// --------------------------------------------------------------------------------- //
// 78 to 83

// "op1.level_scale" to "op6.level_scale"


// --------------------------------------------------------------------------------- //
// 84 to 89

// "op1.left_curve" to "op6.left_curve"


// --------------------------------------------------------------------------------- //
// 90 to 95

// "op1.scale_left_depth" to "op6.scale_left_depth"


// --------------------------------------------------------------------------------- //
// 96 to 101

// "op1.right_curve" to "op6.right_curve"


// --------------------------------------------------------------------------------- //
// 102 to 107

// "op1.scale_right_depth" to "op6.scale_right_depth"


// --------------------------------------------------------------------------------- //
// 108 to 113

// "op1.velocity_sensitivity" to "op6.velocity_sensitivity"


// --------------------------------------------------------------------------------- //
// 114 to 119

// "op1.frequency_fine" to "op6.frequency_fine"

// --------------------------------------------------------------------------------- //

// 120 to 127 are always unused


// --------------------------------------------------------------------------------- //
// 128

// The algorithm of the current preset


// --------------------------------------------------------------------------------- //
// 129

// The feedback


// --------------------------------------------------------------------------------- //
// 130

// osc sync
// a = a ++ [\osc_sync, ((vr[130] * (-1)) + 1)];

// --------------------------------------------------------------------------------- //
// 131

// transposed note
// (note + 3 + vr[131] - 24), // transposed_note,

// --------------------------------------------------------------------------------- //
// 132

// lfo speed
// \lfo_speed, dx7_voice_lfo_frequency[vr[132]],

// --------------------------------------------------------------------------------- //
// 133

// lfo wave, the waveform that the lfo takes.
// \lfo_wave, (waveform_selector[vr[133]])

// --------------------------------------------------------------------------------- //
// 134

// lfo delay
// \lfo_delay, ((vr[134]).clip(0,99)).linlin(0,99,0.01,3.4),//lineer ramp ile carp

// --------------------------------------------------------------------------------- //
// 135

// "lfo.pitch_modulation_depth"

// --------------------------------------------------------------------------------- //
// 136

// "lfo.amplitude_modulation_depth"
// \lfo_amd, dx7_voice_amd_to_ol_adjustment[vr[136]]

// --------------------------------------------------------------------------------- //
// 137

// lfo sync
// vr[137]

// --------------------------------------------------------------------------------- //
// 138

// "lfo.pitch_modulation_sensitivity"


// --------------------------------------------------------------------------------- //
// 139 to 146

// 8 values for pitch envelope data:
// "pitchenv.rate1",
// "pitchenv.rate2",
// "pitchenv.rate3",
// "pitchenv.rate4",
// "pitchenv.level1",
// "pitchenv.level2",
// "pitchenv.level3",
// "pitchenv.level4",

// --------------------------------------------------------------------------------- //
// 147 to 175

// Always unused.

// --------------------------------------------------------------------------------- //
// 176 to 181

// From "op1.mode", to "op6.mode"
// noteblok


// --------------------------------------------------------------------------------- //
// 182 to 255

// Always unused.



// Good stuff here:
// https://github.com/catfact/DX7-Supercollider/commit/d1c917d6682d75a52940c81627ed984fe6d837cf

// vr[cirklonCCparse[item]] = filedump[(z*145)+item];