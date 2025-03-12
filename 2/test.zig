const std = @import("std");

const MyStruct = struct {
    a: i32,
    b: f64,
    c: bool,
};

pub fn main() void {
    const instance = MyStruct{
        .a = 42,
        .b = 3.14,
        .c = true,
    };

    // Итерируемся по полям структуры
    inline for (@typeInfo(MyStruct).Struct.fields) |field| {
        std.debug.print("Поле: {s}, тип: {s}, значение: {}\n", .{
            field.name,
            @typeName(field.type),
            @field(instance, field.name),
        });
    }
}
