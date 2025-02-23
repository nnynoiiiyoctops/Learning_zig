const expect = @import("std").testing.expect;
const std = @import("std");
//Тут как с Vector. Ещё один тип данныйх
//Это буквально list из Python

test "List из Python" {
    const allocator = std.heap.page_allocator;
    var list = std.ArrayList(u32).init(allocator);
    defer list.deinit();

    try list.append(10);
    try list.append(10);

    const arr = [_]u32{ 10, 10, 10, 10 };

    try list.appendSlice(&arr);

    for (list.items) |value| try expect(value == 10);

    const ten: u32 = list.pop();
    //Удаление последнего значения с добавлением его в переменную
    try expect(ten == 10);
    //Вот так итерировать. Как оказалось len тут нету ...
    //Есть .items.len
    //Но у меня не сработало ... Требует доп тестов
}
