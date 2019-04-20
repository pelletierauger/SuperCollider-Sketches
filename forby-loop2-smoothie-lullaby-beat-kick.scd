s.quit;
s.boot;
s = 0.5;
s;
{s.floor}().value.even;
0.5.even;


even(floor(0.5));

floor(0.5);

floor(0.5).asInteger.even;
even(0);

1.5.floor;

(2 % 2) == 0;

~currentChord = 0;

{[1, 2, 3] * 5}.value.choose

(
~f2 = {

    a = [0, -5, 4, 11];
    // a = [2, -5, 9, 11];




    if (floor(~currentChord).asInteger.even, {
        a = [0, -5, 4, 11, 12] - 0;
        // a = [4, -4, 11, 13, 16] + 3;
    }, {
        a = [2, -5, 9, 11, 14] - 0;
        // a = [4, -3, 11, 13, 16] + 1;
    });
    ~currentChord = ~currentChord + 0.5;

    // 59.floor.even;

    // a = [4, -3, 7, 11];

~iter2 = 0;
~sus = 8;
    ~fre = 0;
    forBy (0, a.size - 1, 1, {
    // 1.postln;
    // forBy (a.size - 1, 0, -1, {
    arg i;
    // a[i].postln;
        // ~vol = 0.5;
    var freqModifier = -24;
    var modulo = 0;
    3.do({
            // ~fre.postln;
            // arg i;
        var schedule;
        schedule = {arg freqMod = 0;
                t.sched(~iter2, {
                    ~frequency = (a[i] + 40).midicps * 36.midiratio * freqMod.midiratio;
                    // floor(~frequency).postln;
                    if (floor(~frequency) == 123, {
                        // ~beats[2].play;
                        Synth.new(\percu, [\buf, ~beats[4], \amp, 2]);
                        Synth.new(\kick, [amp: 1]);
                    });
                  if (floor(~frequency) == 311, {
                        // ~beats[2].play;
                        Synth.new(\percu, [\buf, ~beats[4], \amp, 2]);
                        Synth.new(\percu, [\buf, ~beats[2], \amp, 4]);
                        Synth.new(\kick, [amp: 1]);
                    });
/*                    if (floor(~frequency) == 493, {
                        // ~beats[2].play;
                        Synth.new(\percu, [\buf, ~beats[2]]);
                    });*/
                    if (floor(~frequency) == 1244, {
                        // ~beats[2].play;
                        Synth.new(\percu, [\buf, ~beats[4], \rate, 8]);
                        Synth.new(\kick, [amp: 1]);
                        // t.sched(1/3, {
                            Pbind(
                                \instrument, \percu,
                                \dur, Pseq([1/3], 3),
                                \buf, ~beats[4],
                                \amp, Pseq([2.5, 1.5, 1] * 0.5, 1),
                                \rate, Pseq([8, 16, 24], 1)
                            ).play;

                            Pbind(
                                \instrument, \percu,
                                \dur, Pseq([1/12], 12),
                                \buf, ~beats[4],
                                \amp, Pgeom.new([0.125, 1.05, 6] * 0.5, 2),
                                \rate, Pgeom.new([8, 1.25], 12)
                            ).play;
                    // });
                    });
/*                    if (floor(~frequency) == 415, {
                        // ~beats[2].play;
                        Synth.new(\percu, [\buf, ~beats[2], \rate, 3]);
                    });*/
                    Synth.new(\pulse, [
                        \freq: ~frequency,
                        \amp: 2,
                        \sus: ~sus, \pan: -1.1.rand2]);

/*                    if (floor(~currentChord).asInteger.even, {
                        ~bayouFreq = 0;
                    }, {
                        ~bayouFreq = 0;
                    });



                    Synth.new(\bayou, [
                        \rate: (a[~bayouFreq] + 40).midicps * 12.midiratio,
                        \sus: 6, \pan: -1.1.rand2]);
                        Synth.new(\bayou, [
                        \rate: (a[~bayouFreq] + 40).midicps * 0.midiratio,
                        \sus: 6, \pan: -1.1.rand2]);*/

/*                    Synth.new(\triangle, [
                        \freq: ~frequency,
                        \mod: [1, 2, 3].choose,
                        \amp: 0.5,
                        \sus: ~sus, \pan: -1.1.rand2]);*/
                });
        };
        x = schedule.value(freqModifier);
        x.value;
        freqModifier = freqModifier + 12;
            if (modulo.even, {
                ~iter2 = ~iter2 + (1/3);
            }, {
                ~iter2 = ~iter2 + (1/2);
            });
            // ~iter2 = ~iter2 + (1/3);
        // ~vol = ~vol - 0.1;
        // ~vol.postln;
        ~fre = ~fre - 1;
        modulo = modulo + 1;
    });

        // ~iter = 0;
/*    1.do({
        t.sched(~iter, {
            (\freq: (a[i] + 40).midicps * 12.midiratio, \sustain: ~sus, \pan: -1.1.rand2).play();
        });
        ~iter = ~iter + (1/4);
        ~vol = ~vol - 0.1;
            // ~vol.postln;
    });*/
/*    t.sched(~iter, {
        (\freq: (a[i] + 42).midicps, \sustain: 2, \pan: -1.1.rand2).play();
    });*/
});

6;
}
)

(
~currentChord = 0;
t.sched(1, {~f2.value});
)