[0, 1, 2].stutter(4)      // This works
[0, 1, 2].stutter(2 + 2)  // This works
[0, 1, 2].stutter(6 - 2)  // This works
[0, 1, 2].stutter(2 * 2)  // This works
[0, 1, 2].stutter(8 / 2)  // ERROR: Primitive '_ArrayStutter' failed. Wrong type.

