11399.103331095 - 11384.911329777
((11399.103331095 - 11384.911329777) * 1e4).round / 1e4

~keyboardRecord;
~a = [0]
~a.add(15)
~a.do({|item, index| index.postln});
(
var baseTime = ~keyboardRecord[0][0];
~formatted = [];
~keyboardRecord.do({
    |item, index|
    var i = [item[0], item[1], item[2], item[3]];
    i[0] = i[0] - baseTime;
    i[0] = (i[0] * 1e4).round;
    ~formatted = ~formatted.add(i);
});
)
~formatted.size;
~formatted;

(
var baseTime = ~keyboardRecord[0][0];
~writeRecordingOptimized = {
    arg fileName;
    var f, s, k, formattedK, path;
    k = ~keyboardRecord;
    formattedK = [];
    k.do({
        |item, index|
        var i = [item[0], item[1], item[2], item[3]];
        if (index == 0, {
            i[0] = 0;
        }, {
            i[0] = k[index][0] - k[index - 1][0];
            i[0] = (i[0] * 1e4).round;
        });
        formattedK = formattedK.add(i);
    });
    k = formattedK;
    s = "";
    k.size.do({|i, item|
        (k[i] - 1).size.do({|j|
            s = s ++ k[i][j] ++ " ";
        });
    });
    s.postln;
    path = "~/Desktop/Dropbox/Art/SuperCollider/SuperCollider-Sketches/sessions-au-piano/";
    f = File((path ++ fileName ++ ".txt").standardizePath, "w");
    f.write(s);
    f.close;
};
)

~writeRecordingOptimized.("pluie-velour-opt");