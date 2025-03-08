const std = @import("std");
const expect = std.testing.expect;

test {
    const a: i64, const b: i64, const c: i64, var result: i64 = .{ 12, 4, 3, 0 };
    //addition
    result = a + b + c; //12 + 4 + 3 = 19
    try expect(result == 19);
}

test {
    const a: u8, const b: u8, const c: u8, var result: u8 = .{ 12, 4, 255, 0 };

    result = a +| b;
    try expect(result == 16);

    result = c +| a;
    try expect(result == 255);
}

test {
    const a: u8, const b: u8, const c: u8, var result: u8 = .{ 12, 4, 255, 0 };

    result -|= c;
    try expect(result == 0);

    result = a -| b;
    try expect(result == 8);
}

test {
    var a: i11 = -1024;
    a = -%a;
    try expect(a == -1024);
    //Минус с переполнением. Но тут суть в том что он сохраняет знак
    const b: i11 = 11;

    a -%= b; // -1024 - 11 = -1035;
    //Но так как тут переполнение получаем 1013
    try expect(a == 1013);
}

test {
    var a: u8 = 10;

    a *|= 100;
    try expect(a == 255);
}

test {
    var a: u8 = 0b1;
    a <<= 1;
    try expect(a == 0b10);

    a >>= 1;
    try expect(a == 0b1);

    a <<|= 10;
    try expect(a == 255);
}

test {
    var a: u8 = 0b0000_0001;
    const b: u8 = 0b1111_0001;
    a = a & b;
    try expect(a == 1);

    a = 0b0000_1110;
    a = a | b;
    try expect(a == 0b1111_1111);
}

test {
    const a: u8 = 0b0101_1010;
    var b: u8 = 0b1001_0110;

    b ^= a;

    try expect(b == 0b1100_1100);
}

test {
    var a: u8 = 0b0110_1111;
    a = ~a;

    try expect(a == 0b1001_0000);
}

test {
    const i: u16 = 16;
    const float: switch (i) {
        16  => f16,
        32  => f32,
        64  => f64,
        80  => f80,
        128 => f128,
        0   => c_longdouble,
        //Как оказалось - зависит от системы
        else => unreachable,
        //Все типы float
    } = 10.5;

    try expect(float == 10.5);
}

test {
    const a: u32 align(8) = 10;
    try expect( @alignOf(@TypeOf(a)) == 4 );
    //Хз как ещё проверить ...
}

test {
    @setRuntimeSafety(false);
    const a: i8 = -1;
    const b: u8 = 255;
    const c: u8 = @bitCast(a);
    
    try expect(c == b);
}

test {
        const x: i8 = -1;
        const y: u8 = 255;

        const x_ptr: *u8 = @alignCast(@ptrCast(@constCast(&x)));

        if (x_ptr.* != y) {
            @panic("увы");
        }
        
}

test {
    const a, const b,const c, const d: u8 = .{10,10,15,10};
    //Можно и так объявлять
    try expect( a == b and a==d and a != c);
}

test {
    const q: ?u8 = null;
    const result: u8 = q orelse 0;
    //                 ^        ^
    //             если != null |
    //             если всё же  = null
    //Достаточно удобно для теста
    try expect( result == 0 );
}

test "Перемножение разных типов" {
    const a: i8 = 10;
    const b: u64 = 1;

    const result = a * b;
    try expect( result == 10 );
    //Как оказалось можно
    //Но только тогда, когда итоговый тип может репрезентовать полученной значение
}
