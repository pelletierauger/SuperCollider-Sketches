(
~f2 = {
    a = [0, 4, 7];
    // a = [2, -5, 9];

~iter2 = 0;
~sus = 0.1;
    forBy (0, a.size - 1, 1, {
    // 1.postln;
    // forBy (a.size - 1, 0, -1, {
    arg i;
    // a[i].postln;
        // ~vol = 0.5;
    2.do({
        t.sched(~iter2, {
            (\freq: (a[i] + 40).midicps * 12.midiratio, \sustain: ~sus, \pan: -1.1.rand2).play();
        });
            ~iter2 = ~iter2 + (1/3) + (0.1.rand2 * 0.2);
            // ~vol = ~vol - 0.1;
            // ~vol.postln;
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
1;
}
)

t.sched(1, {~f2.value});