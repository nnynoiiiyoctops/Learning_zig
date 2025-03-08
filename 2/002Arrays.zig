const expect = @import("std").testing.expect;
const mem = @import("std").mem;

test {
    const first_array: [10]u8 = [1]u8{1} ** 10;
    const second_array = [10]u8{1,1,1,1,1,1,1,1,1,1};
    try expect(mem.eql(u8, first_array[0..], second_array[0..]));
    //Как оказалось eql возвращает bool
}
