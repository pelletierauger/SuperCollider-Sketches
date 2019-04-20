s.boot;


a = [0, 3, 5, 7];
a;
a.size;
a[1];
~sus = 1.5;
// a = [0, 4, 7, 11];
(
f = {
    // a = [0, 4, 7, 11];

~iter = 1;
~sus = 0.05;
    // forBy (0, a.size - 1, 1, {
    // 1.postln;
    forBy (a.size - 2, 0, -1, {
    arg i;
    // a[i].postln;
        ~vol = 0.5;
    3.do({
        t.sched(~iter, {
                // (\freq: (a[i] + 40).midicps, \sustain: ~sus, \pan: -1.1.rand2).play();
                    Synth.new(\pulse, [
                    \freq: (a[i] + 40).midicps * 48.midiratio,
                    \sus: 0.25,
                    \pan: -1.1.rand2])

        });
        ~iter = ~iter + (1/4);
        ~vol = ~vol - 0.1;
            // ~vol.postln;
    });
        // ~iter = 0;
/*    4.do({
        t.sched(~iter, {
                // (\freq: (a[i] + 40).midicps * 12.midiratio, \sustain: ~sus, \pan: -1.1.rand2).play();

                Synth.new(\pulse, [\freq: (a[i] + 40).midicps * 12.midiratio, \sustain: ~sus, \pan: -1.1.rand2])
            });
        ~iter = ~iter + (1/4);
        ~vol = ~vol - 0.1;
            // ~vol.postln;
    });*/
/*    t.sched(~iter, {
        (\freq: (a[i] + 42).midicps, \sustain: 2, \pan: -1.1.rand2).play();
    });*/
});
    // 4;
}

)

f.value;
t.sched(1, {f.value});
t.clear;

(\freq: (a + 50).midicps, \sustain: 3).play();

t = TempoClock.new;
t.tempo_(72/60);
t.tempo_(140/60);
t.tempo_(105/60);

5.0.rand2;

;

j = 0.1;
j = j.floor;

2.do({"ah".postln;});