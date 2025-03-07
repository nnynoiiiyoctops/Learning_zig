//Ну наконеееец. Дождались
const std = @import("std");
const expect = std.testing.expect;

test "НАКОНЕЦ-ТО!)!)!)" {
    //pseudo random number generator
    //Генератор псевдослучайных чисел
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const a = rand.float(f64);
    const b = rand.boolean();
    const c = rand.int(i64);
    const d = rand.intRangeAtMost(u8, 0, 255);

    _ = .{ a, b, c, d };
}
