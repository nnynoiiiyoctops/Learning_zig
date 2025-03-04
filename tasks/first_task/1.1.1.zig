const std = @import("std");

pub fn main() !void {
    const input = std.io.getStdIn().reader();
    const output = std.io.getStdOut().writer();
    var buffer: [100]u8 = undefined;
    
    var arg1: i64 = 0;
    var arg2: i64 = 0;
    var integers: [2]i64 = undefined;


    const readed = try input.read(&buffer);
    var iterated = std.mem.splitAny(u8, buffer[0..readed-1], " \n");

    {
        var index: usize = 0;
        while (iterated.next()) |value| : (index += 1) {
            if (value.len == 0) {
                index -= 1;
                continue;
            }
            if (index >= 2) break;
//            const trimmed  = std.mem.trim(u8, value, " \r\n");
            integers[index] = try std.fmt.parseInt(i64, value, 10);

            //std.debug.print( "{} {s}", .{ @TypeOf(value), value});
        }
    }

    arg1 = integers[0];
    arg2 = integers[1];

    _ = try output.write(buffer[0..readed-1]);
}
