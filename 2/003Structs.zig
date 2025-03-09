const std = @import("std");
const expect = std.testing.expect;

test {
    const scope_struct = struct{
        a: u8,
        b: u56,
    };

    const da: scope_struct = .{.a = 10, .b = 15 };
    try expect(da.a != da.b);
}

//test {
//    const strct: scope_struct = .{.a = 5, .b = 5 };
//    try expect(strct.a == strct.b);
//}
//Не сработает так как структура зависит от видимости

const Point = struct{
    x: f64,
    y: f64,

    fn initZero() Point { return .{.x = 0, .y = 0};}
};

test{
    const a: Point = .{.x = 0, .y = 0};
    try expect( a.x == a.y );

    const zero: Point = .initZero();
    //Работает только на 0.14.0 и выше
    try expect( zero.x == zero.y );
}

const empty_struct = struct {
    pub const PI = 3.14;
};
test {
    try expect(empty_struct.PI == 3.14);
    try expect(@sizeOf(empty_struct) == 0);

    // Empty structs can be instantiated the same as usual.
    const does_nothing: empty_struct = .{};
    try expect( @TypeOf(does_nothing) == empty_struct );
//  try expect( does_nothing.PI == 3.14 );
//  этот код не будет работать так как структура не имеет полей  
}
