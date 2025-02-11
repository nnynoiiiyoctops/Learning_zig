const expect = @import("std").testing.expect;

test "Создание слайсов" {
    const array: [16]u8 = ([1]u8{1} ** 4) ++( [1]u8{5} ** 8) ++( [1]u8{1} ** 4);
    const first_slice = array[4..12];

    for (0..8, 4..12) |index_slice, index_array| try expect(array[index_array] == first_slice[index_slice]);
}

