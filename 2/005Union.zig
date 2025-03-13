const std = @import("std");
const expect = std.testing.expect;

const sixty_four = union {
    int: i64,
    float: f64,
    string: [7:0]u8,
};

test {
    var d: sixty_four = .{ .int = 10 };
    try expect(d.int == 10);

    d.int +|= 100;
    try expect(d.int == 110);

    d = sixty_four{ .float = 10.5 };
    d.float -= 0.5;
    try expect(d.float == 10);

    //d.int = 50;
    //try expect(d.int == 50);
    //Так нельзя, пример того как надо выше
}

test {
    @setRuntimeSafety(false);
    //теперь можно
    var f: sixty_four = .{ .int = 10 };
    f.float = 10.5;

    try expect(f.int != 10);
}

test {
    @setRuntimeSafety(false);
    var prng: sixty_four = .{ .int = 13 };

    prng = sixty_four{ .string = [7:0]u8{ 'h', 'a', 'h', 'a', 'h', 'a', 'h' } };
    for (0..prng.string.len) |char| prng.string[char] +%= 13;

    try expect(prng.int > 1_000_000);
}

test {
    const tagged = union(enum){
        int: u64,
        uint: u64,
        float: f64,
    };

    const flag: tagged = .{ .int = 10 };
    const result = switch( flag ){
        .int => 10,
        .float => 20,
        .uint => 30,
    };

    try expect( result == 10 );
}
