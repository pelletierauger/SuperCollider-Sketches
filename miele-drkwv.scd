// ----------------------------------------------------------------------------- //
// MiElements "Ominous" Easter Egg Mode: A hidden 2x2-op FM synth.
// Full instructions here: https://modwiggler.com/forum/viewtopic.php?t=134148
// ----------------------------------------------------------------------------- //


// In "Ominous" Easter Egg Mode, the controls of MiElements do not have the same
// names as they normally do. Below is a Synth where the Easter Egg controls are
// presented, with names and descriptions intertwined with the code.
(
{
    var t = Impulse.kr(7);
    var env = EnvGen.kr(Env([0, 1, 0], [0.025, 2], [2, -8]), t);
    var note = Demand.kr(t, 0, Dseq([0, -2, 2, -5].stutter(8), inf));
    var mod = Demand.kr(t, 0, Dwhite());
    var mod2 = Demand.kr(t, 0, Dseq(Dseries(0, 1/16, 16), inf));
    var sig = MiElements.ar(
        blow_in: 0,                strike_in: 0,               gate: t,
        pit: 40 + note,            strength: mod2,

        // Shape of the built-in envelope that is triggered -------------------- //
        // by the GATE input.
        contour: 0.5,

        // Detuning of oscillator 2 with respect to oscillator 1. -------------- //
        // The range is -2 octaves to 2 octaves, with strategically placed notches.
        bow_level: 0.25,

        // Oscillator 1 level           Oscillator 2 level --------------------- //
        blow_level: 0.5,                strike_level: 0.5,

        // Carrier/modulator frequency ratio ----------------------------------- //
        // Oscillator 1                 Oscillator 2
        flow: 0.5,                      mallet: 0.5,

        // Oscillator 1 & 2 feedback amount ------------------------------------ //
        bow_timb: 0.35,

        // FM Amount ----------------------------------------------------------- //
        // Oscillator 1                 Oscillator 2
        blow_timb: env,                 strike_timb: mod,

        // Response of the stereo filter. This interpolates between low-pass, -- //
        // notch, high-pass, and finally band-pass. The filter has a mild resonance.
        // No dedicated resonance control because it's kind of silly on FM timbres.
        geom: 0.14,

        // Cutoff frequency of the stereo filter ------------------------------- //
        bright: 0.67 + (mod * 0.2) * (mod2 * 0.5 + 0.5),

        // Amount of filter modulation from the internal envelope -------------- //
        // and the STRENGTH CV input.
        damp: 0.25,

        // Mixing configuration. When set to its minimum value, OUT L contains
        // the raw mix of both oscillators, and OUT R a mono signal without
        // spatialization (but with the filter and VCA). When turning the knob
        // further, you reach a zone where the stereo rotation becomes more
        // intense. Past 12 o'clock (0.5), the reverb kicks in.
        space: 0.35,

        easteregg: 1
    );
    ~v.(sig, 1000, 0, 3);
}.play;
)