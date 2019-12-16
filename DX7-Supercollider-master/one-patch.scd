(
~currentPatch = ();
~patchToVr.keysValuesDo({
    |key, value|
    ~currentPatch.put(key, v[value]);
    ("\\" ++ key ++ ", " ++ v[value] ++ ",").postln;
})
)

(
~printVR = {
    |vr|
    (~vrRef.size / 2).do({
        |item, i|
        ("\\" ++ ~vrRef[i * 2] ++ ", " ++ vr[~vrRef[i * 2 + 1]] ++ ",").postln;
    });
};
)

~printVR.(~applyPatch.(~epiano1));


(
var patch = [
    \op1_frequency_coarse, 1,
    \op2_frequency_coarse, 1,
    \op3_frequency_coarse, 1,
    \op4_frequency_coarse, 1,
    \op5_frequency_coarse, 1,
    \op6_frequency_coarse, 14,
    \op1_output_level, 70,
    \op2_output_level, 99,
    \op3_output_level, 78,
    \op4_output_level, 99,
    \op5_output_level, 99,
    \op6_output_level, 62,
    \op1_detune, 7,
    \op2_detune, 7,
    \op3_detune, 7,
    \op4_detune, 13,
    \op5_detune, 14,
    \op6_detune, 7,
    \op1_amplitude_modulation_sensitivity, 3,
    \op2_amplitude_modulation_sensitivity, 3,
    \op3_amplitude_modulation_sensitivity, 3,
    \op4_amplitude_modulation_sensitivity, 3,
    \op5_amplitude_modulation_sensitivity, 3,
    \op6_amplitude_modulation_sensitivity, 3,
    \op1_env_rate1, 0,
    \op2_env_rate1, 19,
    \op3_env_rate1, 19,
    \op4_env_rate1, 19,
    \op5_env_rate1, 19,
    \op6_env_rate1, 0,
    \op1_env_rate2, 71,
    \op2_env_rate2, 14,
    \op3_env_rate2, 14,
    \op4_env_rate2, 14,
    \op5_env_rate2, 14,
    \op6_env_rate2, 51,
    \op1_env_rate3, 0,
    \op2_env_rate3, 75,
    \op3_env_rate3, 56,
    \op4_env_rate3, 75,
    \op5_env_rate3, 75,
    \op6_env_rate3, 0,
    \op1_env_rate4, 49,
    \op2_env_rate4, 49,
    \op3_env_rate4, 49,
    \op4_env_rate4, 49,
    \op5_env_rate4, 49,
    \op6_env_rate4, 49,
    \op1_env_level1, 99,
    \op2_env_level1, 99,
    \op3_env_level1, 99,
    \op4_env_level1, 99,
    \op5_env_level1, 99,
    \op6_env_level1, 99,
    \op1_env_level2, 25,
    \op2_env_level2, 90,
    \op3_env_level2, 74,
    \op4_env_level2, 90,
    \op5_env_level2, 90,
    \op6_env_level2, 32,
    \op1_env_level3, 0,
    \op2_env_level3, 0,
    \op3_env_level3, 0,
    \op4_env_level3, 0,
    \op5_env_level3, 0,
    \op6_env_level3, 0,
    \op1_env_level4, 0,
    \op2_env_level4, 0,
    \op3_env_level4, 0,
    \op4_env_level4, 0,
    \op5_env_level4, 0,
    \op6_env_level4, 0,
    \op1_rate_scale, 2,
    \op2_rate_scale, 2,
    \op3_rate_scale, 4,
    \op4_rate_scale, 3,
    \op5_rate_scale, 3,
    \op6_rate_scale, 5,
    \op1_level_scale, 39,
    \op2_level_scale, 39,
    \op3_level_scale, 39,
    \op4_level_scale, 0,
    \op5_level_scale, 0,
    \op6_level_scale, 39,
    \op1_left_curve, 0,
    \op2_left_curve, 0,
    \op3_left_curve, 0,
    \op4_left_curve, 0,
    \op5_left_curve, 0,
    \op6_left_curve, 0,
    \op1_scale_left_depth, 12,
    \op2_scale_left_depth, 4,
    \op3_scale_left_depth, 12,
    \op4_scale_left_depth, 0,
    \op5_scale_left_depth, 0,
    \op6_scale_left_depth, 12,
    \op1_right_curve, 3,
    \op2_right_curve, 3,
    \op3_right_curve, 3,
    \op4_right_curve, 0,
    \op5_right_curve, 0,
    \op6_right_curve, 3,
    \op1_scale_right_depth, 12,
    \op2_scale_right_depth, 12,
    \op3_scale_right_depth, 12,
    \op4_scale_right_depth, 0,
    \op5_scale_right_depth, 0,
    \op6_scale_right_depth, 12,
    \op1_velocity_sensitivity, 7,
    \op2_velocity_sensitivity, 5,
    \op3_velocity_sensitivity, 4,
    \op4_velocity_sensitivity, 7,
    \op5_velocity_sensitivity, 5,
    \op6_velocity_sensitivity, 7,
    \op1_frequency_fine, 0,
    \op2_frequency_fine, 0,
    \op3_frequency_fine, 0,
    \op4_frequency_fine, 0,
    \op5_frequency_fine, 0,
    \op6_frequency_fine, 0,
    \algorithm, 22,
    \feedback, 5,
    \key_sync, 1,
    \transpose, 24,
    \lfo_speed, 26,
    \lfo_wave, 0,
    \lfo_delay, 0,
    \lfo_pitch_modulation_depth, 0,
    \lfo_amplitude_modulation_depth, 2,
    \lfo_sync, 1,
    \lfo_pitch_modulation_sensitivity, 1,
    \pitchenv_rate1, 0,
    \pitchenv_rate2, 0,
    \pitchenv_rate3, 0,
    \pitchenv_rate4, 0,
    \pitchenv_level1, 50,
    \pitchenv_level2, 50,
    \pitchenv_level3, 50,
    \pitchenv_level4, 50,
    \op1_mode, 0,
    \op2_mode, 0,
    \op3_mode, 0,
    \op4_mode, 0,
    \op5_mode, 0,
    \op6_mode, 0
];
~curPatch = ();
(patch.size / 2).do({
    |item, i|
    ~curPatch.put(patch[i * 2], patch[i * 2 + 1]);
});
~mainCaller.value(75, 120, ~cur);
)

~applyPatch.(~curPatch)