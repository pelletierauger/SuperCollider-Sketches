MIDIClient.init;
MIDIIn.connect;
Server.local.options.sampleRate = 48000;
s.boot;
~mainCaller = ("./DX7-stereo.scd").loadRelative.wrapAt(-1);

~curAlg = 1439;
~curAlg = ~curAlg + 1;

(
~noteOn = {
    arg src, chan, num, vel;
    ~mainCaller.value(num, vel, ~curAlg);
};
~noteOff = {
    arg src, chan, num, vel;
    ~mainCaller.value(num, 0);
};
MIDIIn.addFuncTo(\noteOn, ~noteOn);
MIDIIn.addFuncTo(\noteOff, ~noteOff);
)

(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
)

// Change the DX7 algorithm using a button on the keyboard.
(
MIDIIn.removeFuncFrom(\control, ~control);
~control = {arg ... args;
    if (args[2] == 32, {~curAlg = ~curAlg + 1; ~curAlg.postln;});
};
MIDIIn.addFuncTo(\control, ~control);
)

// Set the server volume using a fader on the keyboard.
v = s.volume;
(
MIDIIn.removeFuncFrom(\control, ~volumeControl);
~volumeControl = {arg ... args;
    if (args[2] == 74, {
        var vol = (args[3] / 128 * 2).ampdb;
        AppClock.sched(0.0,{
            v.volume = vol;
        });
    });
};
MIDIIn.addFuncTo(\control, ~volumeControl);
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
8200, beau cuivre boueux
8236, printemps lourd, beau en Fa dorien (Fm, Cm... )

~curAlg;



// cleanup
(
MIDIIn.removeFuncFrom(\noteOn, ~noteOn);
MIDIIn.removeFuncFrom(\noteOff, ~noteOff);
MIDIIn.disconnectAll;
)