const std = @import("std");
const expect = std.testing.expect;

test "Constant test" {
    const Constant: bool = false;
    try expect(!Constant);

    var b: u8 = 27;
    try expect(b == 27);
    b += 50;
    try expect(b != 27);
}
