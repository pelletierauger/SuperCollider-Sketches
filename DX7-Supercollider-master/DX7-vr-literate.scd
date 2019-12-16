(
~vrRef = [

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
    \op1_frequency_coarse, 0,
    \op2_frequency_coarse, 1,
    \op3_frequency_coarse, 2,
    \op4_frequency_coarse, 3,
    \op5_frequency_coarse, 4,
    \op6_frequency_coarse, 5,

// --------------------------------------------------------------------------------- //
// 6 to 11

// From "op1.output_level" to "op6.output_level"
// vr[6 + y], //vrv, //Volume

    \op1_output_level, 6,
    \op2_output_level, 7,
    \op3_output_level, 8,
    \op4_output_level, 9,
    \op5_output_level, 10,
    \op6_output_level, 11,


// --------------------------------------------------------------------------------- //
// 12 to 17

// From "op1.detune" to "op6.detune"
// trDetune = vr[12 + c];


    \op1_detune, 12,
    \op2_detune, 13,
    \op3_detune, 14,
    \op4_detune, 15,
    \op5_detune, 16,
    \op6_detune, 17,

// --------------------------------------------------------------------------------- //
// 18 to 23

// From "op1.amplitude_modulation_sensitivity" to "op6.amplitude_modulation_sensitivity"
// vr[18 + y] // amp_mod_sens;//no


    \op1_amplitude_modulation_sensitivity, 18,
    \op2_amplitude_modulation_sensitivity, 19,
    \op3_amplitude_modulation_sensitivity, 20,
    \op4_amplitude_modulation_sensitivity, 21,
    \op5_amplitude_modulation_sensitivity, 22,
    \op6_amplitude_modulation_sensitivity, 23,

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

    \op1_env_rate1, 24,
    \op2_env_rate1, 25,
    \op3_env_rate1, 26,
    \op4_env_rate1, 27,
    \op5_env_rate1, 28,
    \op6_env_rate1, 29,

    \op1_env_rate2, 30,
    \op2_env_rate2, 31,
    \op3_env_rate2, 32,
    \op4_env_rate2, 33,
    \op5_env_rate2, 34,
    \op6_env_rate2, 35,

    \op1_env_rate3, 36,
    \op2_env_rate3, 37,
    \op3_env_rate3, 38,
    \op4_env_rate3, 39,
    \op5_env_rate3, 40,
    \op6_env_rate3, 41,

    \op1_env_rate4, 42,
    \op2_env_rate4, 43,
    \op3_env_rate4, 44,
    \op4_env_rate4, 45,
    \op5_env_rate4, 46,
    \op6_env_rate4, 47,



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


    \op1_env_level1, 48,
    \op2_env_level1, 49,
    \op3_env_level1, 50,
    \op4_env_level1, 51,
    \op5_env_level1, 52,
    \op6_env_level1, 53,

    \op1_env_level2, 54,
    \op2_env_level2, 55,
    \op3_env_level2, 56,
    \op4_env_level2, 57,
    \op5_env_level2, 58,
    \op6_env_level2, 59,

    \op1_env_level3, 60,
    \op2_env_level3, 61,
    \op3_env_level3, 62,
    \op4_env_level3, 63,
    \op5_env_level3, 64,
    \op6_env_level3, 65,

    \op1_env_level4, 66,
    \op2_env_level4, 67,
    \op3_env_level4, 68,
    \op4_env_level4, 69,
    \op5_env_level4, 70,
    \op6_env_level4, 71,


// --------------------------------------------------------------------------------- //
// 72 to 77

// "op1.rate_scale" to "op6.rate_scale"
// Not implemented yet.

    \op1_rate_scale, 72,
    \op2_rate_scale, 73,
    \op3_rate_scale, 74,
    \op4_rate_scale, 75,
    \op5_rate_scale, 76,
    \op6_rate_scale, 77,

// --------------------------------------------------------------------------------- //
// 78 to 83

    // Level scaling breakpoint
    // vr[78 + y], // level_scaling_bkpoint,

    // Breakpoint explanation from :
    // "https://www.reddit.com/r/synthesizers/comments/4i8vcd/need_help_understanding_a_couple_of_parameters_pn/"

    // The EGs have a time scale. Usually the higher notes play through the envelopes
    // more quickly, imitating the behaviour of acoustic instruments.

    // The simplest way to implement this behaviour is to have a linear scaling across
    // the keyboard from the lowest note (slower) to the highest note (faster).
    // For some sounds the scaling can be exponential instead of linear.

    // Adding breakpoints, you can change the scaling across the keyboard so that
    // the high and low notes have faster EGs while the middle have slower, or vice versa.



// "op1.level_scale" to "op6.level_scale"

    \op1_level_scale, 78,
    \op2_level_scale, 79,
    \op3_level_scale, 80,
    \op4_level_scale, 81,
    \op5_level_scale, 82,
    \op6_level_scale, 83,

// --------------------------------------------------------------------------------- //
// 84 to 89

// "op1.left_curve" to "op6.left_curve"
// This is a number between 0 and 3, who becomes : [-lin, -exp, +exp, +lin]
// This is calculated within the scale_vrv.() function

    \op1_left_curve, 84,
    \op2_left_curve, 85,
    \op3_left_curve, 86,
    \op4_left_curve, 87,
    \op5_left_curve, 88,
    \op6_left_curve, 89,

// --------------------------------------------------------------------------------- //
// 90 to 95

// "op1.scale_left_depth" to "op6.scale_left_depth"

    \op1_scale_left_depth, 90,
    \op2_scale_left_depth, 91,
    \op3_scale_left_depth, 92,
    \op4_scale_left_depth, 93,
    \op5_scale_left_depth, 94,
    \op6_scale_left_depth, 95,



// --------------------------------------------------------------------------------- //
// 96 to 101

// "op1.right_curve" to "op6.right_curve"
// This is a number between 0 and 3, who becomes : [-lin, -exp, +exp, +lin]
// This is calculated within the scale_vrv.() function



    \op1_right_curve, 96,
    \op2_right_curve, 97,
    \op3_right_curve, 98,
    \op4_right_curve, 99,
    \op5_right_curve, 100,
    \op6_right_curve, 101,


// --------------------------------------------------------------------------------- //
// 102 to 107

// "op1.scale_right_depth" to "op6.scale_right_depth"

    \op1_scale_right_depth, 102,
    \op2_scale_right_depth, 103,
    \op3_scale_right_depth, 104,
    \op4_scale_right_depth, 105,
    \op5_scale_right_depth, 106,
    \op6_scale_right_depth, 107,

// --------------------------------------------------------------------------------- //
// 108 to 113

// "op1.velocity_sensitivity" to "op6.velocity_sensitivity"

    \op1_velocity_sensitivity, 108,
    \op2_velocity_sensitivity, 109,
    \op3_velocity_sensitivity, 110,
    \op4_velocity_sensitivity, 111,
    \op5_velocity_sensitivity, 112,
    \op6_velocity_sensitivity, 113,

// --------------------------------------------------------------------------------- //
// 114 to 119

// "op1.frequency_fine" to "op6.frequency_fine"

    \op1_frequency_fine, 114,
    \op2_frequency_fine, 115,
    \op3_frequency_fine, 116,
    \op4_frequency_fine, 117,
    \op5_frequency_fine, 118,
    \op6_frequency_fine, 119,

// --------------------------------------------------------------------------------- //

// 120 to 127 are always unused


// --------------------------------------------------------------------------------- //
// 128

// The algorithm of the current preset

    \algorithm, 128,

// --------------------------------------------------------------------------------- //
// 129

// The feedback

    \feedback, 129,

// --------------------------------------------------------------------------------- //
// 130

// osc sync
// a = a ++ [\osc_sync, ((vr[130] * (-1)) + 1)];

    \key_sync, 130,

// --------------------------------------------------------------------------------- //
// 131

// transposed note
// (note + 3 + vr[131] - 24), // transposed_note,

    \transpose, 131,

// --------------------------------------------------------------------------------- //
// 132

// lfo speed
// \lfo_speed, dx7_voice_lfo_frequency[vr[132]],

    \lfo_speed, 132,

// --------------------------------------------------------------------------------- //
// 133

// lfo wave, the waveform that the lfo takes.
// \lfo_wave, (waveform_selector[vr[133]])

    \lfo_wave, 133,

// --------------------------------------------------------------------------------- //
// 134

// lfo delay
// \lfo_delay, ((vr[134]).clip(0,99)).linlin(0,99,0.01,3.4),//lineer ramp ile carp

     \lfo_delay, 134,

// --------------------------------------------------------------------------------- //
// 135

// "lfo.pitch_modulation_depth"

    \lfo_pitch_modulation_depth, 135,

// --------------------------------------------------------------------------------- //
// 136

// "lfo.amplitude_modulation_depth"
// \lfo_amd, dx7_voice_amd_to_ol_adjustment[vr[136]]

    \lfo_amplitude_modulation_depth, 136,

// --------------------------------------------------------------------------------- //
// 137

// lfo sync
// vr[137]

    \lfo_sync, 137,

// --------------------------------------------------------------------------------- //
// 138

// "lfo.pitch_modulation_sensitivity"

    \lfo_pitch_modulation_sensitivity, 138,

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

    \pitchenv_rate1, 139,
    \pitchenv_rate2, 140,
    \pitchenv_rate3, 141,
    \pitchenv_rate4, 142,
    \pitchenv_level1, 143,
    \pitchenv_level2, 144,
    \pitchenv_level3, 145,
    \pitchenv_level4, 146,

// --------------------------------------------------------------------------------- //
// 147 to 175

// Always unused.

// --------------------------------------------------------------------------------- //
// 176 to 181

// From "op1.mode", to "op6.mode"
// noteblok

    \op1_mode, 176,
    \op2_mode, 177,
    \op3_mode, 178,
    \op4_mode, 179,
    \op5_mode, 180,
    \op6_mode, 181,

// --------------------------------------------------------------------------------- //
// 182 to 255

// Always unused.

];
~patchToVr = ();
(~vrRef.size / 2).do({
    |item, i|
    ~patchToVr.put(~vrRef[i * 2], ~vrRef[i * 2 + 1]);
});
)

// Good stuff here:
// https://github.com/catfact/DX7-Supercollider/commit/d1c917d6682d75a52940c81627ed984fe6d837cf

// vr[cirklonCCparse[item]] = filedump[(z*145)+item];