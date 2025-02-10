const expect = @import("std").testing.expect;

test "general wersoon of switch construction" {
    const flag: i8 = 5;
    const c: bool = switch (flag) {
        -128...-1 => true,
        1...127 => true,
        0 => false,
    };

    try expect(c);
}

test "better switch" {
    const flag: i8 = 5;
    const is_nill: bool = switch (flag) {
        0 => false,
        else => true,
    };

    try expect(is_nill);
}

test "someone swith" {
    const is_nill: bool = switch (@as(i8, 10)) {
        -128...0 => false,
        else => true,
    };

    try expect(is_nill);
}
