const expect = @import("std").testing.expect;
const std = @import("std");

const PageAllocator = std.heap.page_allocator;

test "Форматирование строки" {
    const string = try std.fmt.allocPrint(
        PageAllocator,
        "{d} + {d} = {d}",
        .{ 9, 9, 18 },
    );
    defer PageAllocator.free(string);

    try expect(std.mem.eql(u8, string, "9 + 9 = 18"));
}
//Библиотека для форматирования строк
//Добавить нечегj
