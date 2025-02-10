const expect = @import("std").testing.expect;

test "min with if expression" {
    const a: i32 = 10;
    const b: i32 = 5;
    var minimum: i32 = undefined;

    if (a > b) {
        minimum = b;
    } else {
        minimum = a;
    }

    try expect(minimum == 5);
}

test "Ternar operator test" {
    const a: i32 = 10;
    const b: i32 = 5;
    var minimum: i32 = undefined;

    minimum = if (a > b) b else a;

    try expect(minimum == 5);
}

test "Strange codestyle" {
    const a: i32 = 10;
    const b: i32 = 5;
    var minimum: i32 = undefined;

    if (a > b) minimum = b else minimum = a;

    try expect(minimum == 5);
}

test "One line if expression" {
    const a: i32 = 10;
    const b: i32 = 5;
    var minimum: i32 = undefined;

    if (a > b) {
        minimum = b;
    } else {
        minimum = a;
    }

    try expect(minimum == 5);
}
