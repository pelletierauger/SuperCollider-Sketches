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
        a = [0, -5, 4, -1] - 5;
    }, {
        a = [2, -5, -3, -1] - 5;
    });
    ~currentChord = ~currentChord + 0.5;

    // 59.floor.even;

    // a = [4, -3, 7, 11];

~iter2 = 0;
~sus = 4;
    ~fre = 0;
    forBy (0, a.size - 1, 1, {
    // 1.postln;
    // forBy (a.size - 1, 0, -1, {
    arg i;
    // a[i].postln;
        // ~vol = 0.5;
    var freqModifier = 0;
    var modulo = 0;
    4.do({
            // ~fre.postln;
            // arg i;
        var schedule;
        schedule = {arg freqMod = 0;
                t.sched(~iter2, {
                    ~frequency = (a[i] + 40).midicps * 36.midiratio * freqMod.midiratio;
                    Synth.new(\pulse, [
                        \freq: ~frequency,
                        \sus: ~sus * 0.125, \pan: -1.1.rand2]);

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
                                t.sched(~iter2 * 3, {
                    ~frequency = (a[i] + 40).midicps * 48.midiratio * freqMod.midiratio;
                    Synth.new(\pulse, [
                        \freq: ~frequency,
                        \sus: ~sus * 0.5, \pan: -1.1.rand2]);
                    });
        };
        x = schedule.value(freqModifier);
        x.value;
        freqModifier = freqModifier - 12;
            if (modulo.even, {
                ~iter2 = ~iter2 + (1/3) * 0.5;
            }, {
                ~iter2 = ~iter2 + (5/3) * 0.5;
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

4;
}
)

(
~currentChord = 0;
t.sched(1, {~f2.value});
)