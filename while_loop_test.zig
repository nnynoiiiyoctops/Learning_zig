const expect = @import("std").testing.expect;

test "while" {
    var counter: u8 = 0;
    var summ: u16 = 0;
    while (counter <= 254) : (counter += 1) summ += counter;

    try expect(summ > 256);
}

test "while polystring" {
    var counter: u8 = 0;
    var summ: u16 = 0;
    while (counter <= 254) : (counter += 1) {
        summ += counter;
    }

    try expect(summ > 256);
}

test "factorial" {
    var counter: i16 = 6;
    var factorial: i16 = 1;

    while (counter > 0) : (counter -= 1) {
        factorial *= counter;
    }

    try expect(factorial == 720);
}

test "useless test" {
    var i: i16 = 1;

    while (i < 1000) i += i;

    try expect(i == 1024);
}

test "Stupidest test of break and continue" {
    var counter: i16 = 0;
    var summ: i16 = 1;
    while (counter < 10) : (counter += 1) {
        if (counter < 10) continue else break;
        summ += 1;
    }

    try expect(summ == 1);
}
