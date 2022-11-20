[0, 1, 2].stutter(4)      // This works
[0, 1, 2].stutter(2 + 2)  // This works
[0, 1, 2].stutter(6 - 2)  // This works
[0, 1, 2].stutter(2 * 2)  // This works
[0, 1, 2].stutter(8 / 2)  // ERROR: Primitive '_ArrayStutter' failed. Wrong type.




[0, 1, 2].wrapExtend(4)      // [ 0, 1, 2, 0 ]
[0, 1, 2].wrapExtend(2 + 2)  // [ 0, 1, 2, 0 ]
[0, 1, 2].wrapExtend(6 - 2)  // [ 0, 1, 2, 0 ]
[0, 1, 2].wrapExtend(2 * 2)  // [ 0, 1, 2, 0 ]
[0, 1, 2].wrapExtend(8 / 2)  // ERROR: Primitive '_ArrayExtendWrap' failed.

The array methods that take an integer as an argument fail when that integer
is the result of a division. I tested it with other methods
like rotate and foldExtend, they all fail the same way.

It's not a big deal, but still something that I think is worth fixing.