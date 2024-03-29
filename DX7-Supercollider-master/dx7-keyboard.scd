
MIDIClient.init;
MIDIIn.connect;
s.boot;
~mainCaller = ("./DX7-stereo.scd").loadRelative.wrapAt(-1);
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
1006, très beau synthé grimpant
1012, 1018, 1039, beau
1042, Twin Peaksy
1062, basse que j’aime, assez douce
1063, funny
1070, space-like
1072, orgue nerveux, beau lorsqu’aigu
1077, 1078, 1079, bel orgue mystérieux
1098, upsetting nightmare organ
1108, superbe orgue lointain
1109, folle chute
1110, orgue nostalgique, beau, doux
1113, orgue adorable
1138, orgue ensoleillé
1161, orgue qui siffle
1168, bel orgue dramatique
1440, pas pire orgue boueux
1474, quasi electric piano
1475, doux cuivres
1501, 1538, beau synthé clair
1512, Tokyo flottant
1531, château
1626, intéressant ramp up
6000, beau,
6110, bossa nova spatiale (et une autre un peu en bas !)
6123, orgue hésitant et spatial (gros lfo)
6156, orgue à l’envers
6159, pas pire piano
6160, orgue sombre et un peu à l’envers
6164, crispy, crunchy keys
6167, clés chaudes
6169, orgue cuivré
6172, crybaby
6157, douce vibration sous la cloche
6193, beau
6169, hanté
6197, gros lfo spatial
~cur;
~cur = 1438;
~cur = ~cur + 1;
(
// ~cur = ~cur + 1;
// MIDIIn.removeFuncFrom(\noteOn, ~myOn);
// MIDIIn.removeFuncFrom(\noteOff, ~myOff);
~myOn = {arg src, chan, num, vel;
    // ~mainCaller.value(80, 100, 10000);
    ~mainCaller.value(num, vel, ~cur);
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


// cleanup
(
MIDIIn.removeFuncFrom(\noteOn, ~noteOnFunc);
MIDIIn.removeFuncFrom(\noteOff, ~noteOffFunc);
MIDIIn.disconnectAll;
)