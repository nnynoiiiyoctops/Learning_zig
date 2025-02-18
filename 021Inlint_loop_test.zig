const expect = @import("std").testing.expect;

//В отличии от inline функции тут смысл в другом. В итерации по разным типам

test "inline for test" {
    const d = [4]type{ u32, i32, f32, bool };
    var summ: u32 = 0;

    inline for (d) |elem| {
        summ += @sizeOf(elem);
    }
    //Как я понял тут суть в том что inline - указание для компилятора - поработать с типами

    try expect(summ > 10);
}
