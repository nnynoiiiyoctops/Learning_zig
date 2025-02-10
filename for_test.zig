const expect = @import("std").testing.expect;

test "Common for loop" {
    // For used to iterate, not for cycle from start to end. I T E R A T I O N on object.
    const iteration_array = [_]i16{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 120, 124, 1, 312, 41, 2, 421, 4 };
    var summ: i16 = 0;

    for (iteration_array) |integer| summ += integer;

    try expect(summ > 1000);
}

test "for from official guide" {
    //character literals are equivalent to integer literals
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string, 0..) |character, index| {
        _ = character;
        _ = index;
    }

    for (string) |character| {
        _ = character;
    }

    for (string, 0..) |_, index| {
        _ = index;
    }

    for (string) |_| {}
}

test "String iteration" {
    const iteration_string: []const u8 = "ver and over and over again";
    var summ: u64 = 0;

    for (iteration_string) |char| {
        summ += char;
    }

    try expect(summ != 0);
}

test "Test of indexs in array" {
    var summ: u64 = 0;

    for (0..5) |index| {
        summ += index;
    }

    try expect(summ == 10);
}

test "Try to iter on part of array" {
    const iteration_array: [5]i16 = .{ 10, 10, 10, 10, 10 };
    try expect(@TypeOf(iteration_array) == [5]i16);
}

test "Another try to understanding for loop" {
    const itr_array = [5]i16{ 10, 10, 10, 10, 10 };
    var summ: i32 = 0;
    var indexs: usize = 0;

    for (itr_array[0..3], 0..3) |integer, index| {
        summ += integer;
        indexs = index;
    }

    try expect(summ == 30);
    try expect(indexs == 2);
}

test "YEEEEEEEEEES" {
    const itr_arr = [6]i32{ 10, 10, 10, 20, 20, 30 };
    for (itr_arr) |elm| {
        _ = elm;
    }
}
