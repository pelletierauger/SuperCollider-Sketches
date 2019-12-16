(
SynthDef.new(\throb, {
    // arg ctls = Array2D.fromArray(6, 6, Array.fill(36, 440)),
    arg cut = [0, 1];
    // modz = Array2D.fromArray(6, 6, Array.fill(36, 440));
    var ctls = Array.fill(36, 44), modz = Array.fill(36, 44);
    ctls = [
        // freq, phase, amp
        [LFNoise1.kr(0.5).range(300, 310), 0, 1],
        [LFNoise1.kr(0.5).exprange(3, 310), 0, 1],
        [LFNoise1.kr(0.5).exprange(3, 100), 0, 1],
        [LFNoise1.kr(0.5).exprange(3, 100), 0, 1],
        [LFNoise1.kr(0.5).exprange(3, 100), 0, 1],
        [LFNoise1.kr(0.5).exprange(3, 100), 0, 1]
    ];
    modz = [
        [Line.kr(0, 0.001, 2), Line.kr(0.1, 0, 4), 0, MouseY.kr(0, 6), 0, 0],
        [MouseX.kr(0, 6), 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0]
    ];
    FM7.ar(ctls, modz).slice(cut);
}).add;
)


Array2D.fromArray(6, 6, Array.fill(36, 440)).flatten;

Array.fill(36, 44).flatten