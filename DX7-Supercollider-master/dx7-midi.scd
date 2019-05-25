( // init
	s.boot;
  ~mainCaller = ("./DX7.scd").loadRelative.wrapAt(-1);
)
(
var presetz = Array.fill(128, 63);

MIDIdef.noteOn(\DX7, {arg vel, note;
	~mainCaller.value(note, vel, 8127);
},srcID:~midiInINST4,chan:2).add;

MIDIdef.cc(\DX7CC, {arg ...args;
	presetz[args[1]] = args[0];
},(0..1),srcID:~midiInINST4,chan:2).add;

MIDIdef.noteOff(\DX7off, {arg vel, note;
	~mainCaller.value(note, 0);
},srcID:~midiInINST4,chan:2).add;
)


29, doux piano
56, doux orgue
61, beau bois
10024, beau bois
10025, genre de snare,
556 et 573, près du electric piano
569, spooky wobble
(
MIDIIn.removeFuncFrom(\noteOn, ~myOn);
MIDIIn.removeFuncFrom(\noteOff, ~myOff);
~myOn = {arg src, chan, num, vel;
    // ~mainCaller.value(80, 100, 10000);
    ~mainCaller.value(num, vel, 4590);
    // num.postln;
};
MIDIIn.addFuncTo(\noteOn, ~myOn);

~myOff = {arg src, chan, num, vel;
    ~mainCaller.value(num, 0);
    // ~mainCaller.value(80, 0);
    // num.postln;
};
MIDIIn.addFuncTo(\noteOff, ~myOff);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~myOn);
MIDIIn.removeFuncFrom(\noteOff, ~myOff);
)

80.midicps
Array.fill(128, 63);

128 * 63 + 63;

(
var num = 70 + -20, vel = 50;
~mainCaller.value(num, vel, 56);
)
~mainCaller.value(70 + 12, 0);