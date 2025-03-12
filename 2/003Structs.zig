const std = @import("std");
const expect = std.testing.expect;

test {
    const scope_struct = struct {
        a: u8,
        b: u56,
    };

    const da: scope_struct = .{ .a = 10, .b = 15 };
    try expect(da.a != da.b);
}

//test {
//    const strct: scope_struct = .{.a = 5, .b = 5 };
//    try expect(strct.a == strct.b);
//}
//Не сработает так как структура зависит от видимости

const Point = struct {
    x: f64,
    y: f64,

    fn initZero() Point {
        return .{ .x = 0, .y = 0 };
    }
};

test {
    const a: Point = .{ .x = 0, .y = 0 };
    try expect(a.x == a.y);

    const zero: Point = .initZero();
    //Работает только на 0.14.0 и выше
    try expect(zero.x == zero.y);
}

const empty_struct = struct {
    pub const PI = 3.14;
};
test {
    try expect(empty_struct.PI == 3.14);
    try expect(@sizeOf(empty_struct) == 0);

    // Empty structs can be instantiated the same as usual.
    const does_nothing: empty_struct = .{};
    try expect(@TypeOf(does_nothing) == empty_struct);
    //  try expect( does_nothing.PI == 3.14 );
    //  этот код не будет работать так как структура не имеет полей
}

test {
    const arr_of_structs: [10]Point = comptime (std.mem.zeroes([10]Point));
    //Массив структур

    for (arr_of_structs) |point| try expect(point.x == point.y);
}

test {
    const point = .{ .{ .x = 0.0, .y = 0.0 }, .{ .x = 0.0, .y = 0.0 } } ** 5;

    try expect(point[1].x == point[1].y);
    try expect(point.len == 10);
}

//test "array of structs with tuple initialization" {
// Размер массива
//    const array_size = 10;

// Объявляем переменную с массивом структур
//    const points: [array_size]struct {
//        x: f64 = 0,
//        y: f64 = 0,
//    } = .{ .{ .x = 1.0, .y = 2.0 }, .{ .x = 1.0, .y = 2.0 } } ** (array_size / 2);

// Проверяем, что все элементы массива инициализированы правильно
//    for (points) |point| {
//        try std.testing.expect(point.x == point.y - 1);
//    }
//}

test "перемешивание полей" {
    const p1 = Point{ .x = 1.0, .y = 2.0 }; // Обычный порядок
    const p2 = Point{ .y = 3.0, .x = 4.0 }; // Порядок изменён

    try std.testing.expect(p1.x == 1.0);
    try std.testing.expect(p1.y == 2.0);
    try std.testing.expect(p2.x == 4.0);
    try std.testing.expect(p2.y == 3.0);
}

const Value = struct {
    value: i64,

    fn incr(self: *@This()) void {
        self.value +|= 1;
    }
};

test {
    var beta: Value = Value{ .value = 0 };
    beta.incr();

    try expect(beta.value == 1);
}

//extern struct для работы с C ABI

const cooler_value = packed struct {
    x: f64 = 0,
    y: f64 = 0,

    const default = @This(){ .x = 0, .y = 0 };
};

test {
    const a: cooler_value = .default;
    //packed struct отличается от обычных вотчем:
    //Нельзя мешать поля в памяти
    //Всё что понял
    try expect(a.x == a.y);
}

test {
    var arr: [10]struct { x: f64, y: f64 } = undefined;

    for (0..10) |i| arr[i] = .{ .x = 10.5, .y = 10.5 };
    try expect(arr[1].x == 10.5);
    //Работа с объявлением типа прямо в переменной
}

const iter_struct = struct {
    i: i32,
    u: u32,
    f: f32,
};

test {
    const itr: iter_struct = iter_struct{ .i = -10, .u = 10, .f = 0.1 };

    inline for (@typeInfo(iter_struct).@"struct".fields) |fild| {
        const value = @field(itr, fild.name);
        try expect(value != 0);
    }
}
