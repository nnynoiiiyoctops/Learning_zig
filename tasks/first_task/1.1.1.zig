const std = @import("std");

pub fn main() !void {

    const input  = std.io.getStdOut().reader();
    const output = std.io.getStdIn().writer();
    var readed:[100:0]u8 = undefined;
    
    const len = try input.read(&readed);
    readed[len] = 0;

    _ = try output.write(readed[0..len+1]);
}
