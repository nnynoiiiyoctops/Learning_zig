const std = @import("std");
const expect = std.testing.expect;

fn ticker(step: u8) void {
    while (true) {
        std.time.sleep(1 * std.time.ns_per_s);
        tick += @as(isize, step);
    }
}

var tick: isize = 0;

test "threading" {
    const thread = try std.Thread.spawn(.{}, ticker, .{@as(u8, 1)});
    _ = thread;
    //В гайде тут var. Но с var не работает потомучто она не ищменяется, поставмл conat
    try expect(tick == 0);
    std.time.sleep(3 * std.time.ns_per_s / 2);
    try expect(tick == 1);
}

//Тут часть посвященная стандартной либе и она по сути требует чуть другого
