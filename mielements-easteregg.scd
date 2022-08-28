// easteregg: a hidden 2x2-op FM synth
// Full instructions here: https://modwiggler.com/forum/viewtopic.php?t=134148
(
x.free;
x = {
    var t = Impulse.kr(5);
    var mod = Demand.kr(t, 0, Dwhite());
    var n = Demand.kr(t, 0, Dseq(Dseries(0, 1/16, 16), inf));
    var m = Demand.kr(t, 0, Dseq([0, -2, 2, -5].stutter(8), inf));
    var e = EnvGen.kr(Env([0, 1, 0], [0.025, 2], [2, -8, 'lin']), t);
    var sig = MiElements.ar(
        blow_in: 0,                strike_in: 0,               gate: t,
        pit: 38 + 12 + m,          strength: n,

        // Shape of the built-in envelope that is triggered
        // by the PLAY button or the GATE input.
        contour: 0.15,

        // Detuning of oscillator 2 with respect to oscillator 1.
        // The range is -2 octaves to 2 octaves, with strategically placed notches.
        bow_level: 0.25,

        // Oscillator 1 level           Oscillator 2 level
        blow_level: 0.5,                strike_level: 0.5,

        // Carrier/modulator frequency ratio ----------------------------------- //
        // Oscillator 1                 Oscillator 2
        flow: 0.5,                      mallet: 0.5,

        // Oscillator 1 & 2 feedback amount ------------------------------------ //
        bow_timb: 0.35,

        // FM Amount ----------------------------------------------------------- //
        //oscillator 1                  Oscillator 2
        blow_timb: e,                   strike_timb: mod,

        // Response of the stereo filter. This interpolates between low-pass,
        // notch, high-pass, and finally band-pass. The filter has a mild resonance.
        // No dedicated resonance control because it's kind of silly on FM timbres.
        geom: 0.85,

        // Cutoff frequency of the stereo filter.
        bright: 0.67 + (mod * 0.2) * (n * 0.5 + 0.5),

        // Amount of filter modulation from the internal envelope and the STRENGTH CV input.
        damp: 0.25,

        // Mixing configuration. When set to its minimum value,
        // OUT L contains the raw mix of both oscillators, and OUT R a mono signal
        // without spatialization (but with the filter and VCA).
        // When turning the knob further, you reach a zone where the stereo rotation
        // becomes more intense. Past 12 o'clock (0.5), the reverb kicks in.
        space: 0.65,

        easteregg: 1
    );
    sig = VadimFilter.ar(sig, 3000, 0, 1) * 4;
    sig;
}.play
)