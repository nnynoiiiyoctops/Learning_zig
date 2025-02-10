const std = @import("std");
const expect = std.testing.expect;

test "Create an array" {
    const array = [_]i32{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    try expect(array[2] == @as(i32, 2));
}

test "Array len" {
    const array = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    try expect(array.len == 5);
}
