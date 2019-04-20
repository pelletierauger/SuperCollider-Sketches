(
{
    loop {
        Pgeom(1, 1.5, 4).next.postln;
        1.wait;
    }
}.fork;
)

~mypat = Pgeom(1, 1.5, 4);

~mypat.next;

(
~myRou = Routine({
   var inc = 0;
    loop{
        inc = inc + 1;
        inc.postln;
        inc.yield;
    }
});
)
~globalAmp = 1;
~globalAmpP = PatternProxy(Pn(1, inf));

(
~fadeOut = {
        ~globalAmp = ~globalAmp - 0.1;
        (floor(~globalAmp * 10)/10).postln;
        if (~globalAmp > 0, {
            1;
        }, {
            nil;
        });
};
)

~fadeOut.next;

TempoClock.default.sched(1, {~fadeOut.value});

TempoClock.default.clear;


b = 1;
b = b - 0.1;

~myRou.next;

(
r = Routine { arg inval;
    inval.postln; // Post the value passed in when started.
    5.do { arg i;
        inval = (i + 10).yield;
        inval.postln; // Post the value passed in when resumed.
    }
}
)

r.value;

[1, 2, 3].do{arg i; i.postln};