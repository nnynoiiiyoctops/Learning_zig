// Как оказалось в Zig попросту разные указатели для массивов и единичных значений
const expect = @import("std").testing.expect;

fn MultOnTwo(buffer: [*]u8, byte_count: usize) void {
    var i: usize = 0;
    while (i < byte_count) : (i += 1) buffer[i] *= 2;
} // От себя ничего нет это функция из гайда с измененныйм называнием

test "Проверка массива переменного значения" {
    var buffer: [100]u8 = [_]u8{1} ** 100;
    const buffer_ptr: *[100]u8 = &buffer;

    try expect(buffer_ptr[2] == 1);

    MultOnTwo(buffer_ptr, buffer.len);
    try expect(buffer_ptr[2] == 2);
}

test "И так. Ещё раз" {
    const buffer: [10]u8 = [1]u8{1} ** 10;
    const ptr_bfr: *const [10]u8 = &buffer;

    try expect(ptr_bfr[2] == 1);
}

test "Хорошо, теперь попытаемся взять такой тип как [*]T" {
    var buffer = [1]u8{1} ** 100;
    const buffer_ptr: *[100]u8 = &buffer;
    // Вот в гайде уже от этого указателя брали другой указатель, и компилятор согласен ибо тут он выдавал ошибку несоответствия типов. Тогда возьмем уже от не&о указатель

    const another_ptr: [*]u8 = buffer_ptr;
    MultOnTwo(another_ptr, buffer.len);

    for (buffer) |char| try expect(char == 2);
}
