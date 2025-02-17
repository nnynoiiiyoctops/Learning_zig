const expect = @import("std").testing.expect;

//Опциональное

//В ошибках обучился !T синтаксису. Пришло время узнать ?T синтаксис
//В случае с !T была либо ошибка либо значение
//В случае с ?T либо значение либо ничего - null
//Это как undefined. Но тут другой тип с которым можно работать иначе как я понял

test "usless ? " {
    var alpaca: ?usize = null;
    const iter_arr = [_]u32{ 0, 1, 2, 3, 212, 3, 213, 1231, 23, 3, 10, 9 };

    name: for (iter_arr, 0..) |object, index| {
        if (object == 10) {
            alpaca = index;
            break :name; //Если мы нашли - зачем продолжать? Задача - определить есть ли в массиве число, а не кол-во чисел
        }
    }

    try expect(alpaca != null);
}

test "orelse" {
    const a: ?f32 = null;
    const zero: f32 = 0;
    const b: f32 = a orelse zero;

    try expect(b == 0);
    try expect(@TypeOf(b) == f32);

    const from: ?i32 = 1024;
    const null_from: ?i32 = null;
    const other_from: i32 = 0;

    const to1: i32 = from orelse other_from;
    try expect(to1 == from);

    const to2: i23 = null_from orelse other_from;
    try expect(to2 == other_from);

    const to3: i32 = if (null_from != null) null_from else other_from;
    //Этот if может заменить orelse. Тоесть это просто более простой способ работы с null
    //Хочу заметить что тип ?T это опять таки отдельный тип. Не конкретный.
    try expect(to3 == other_from);
}
//Понял
//orelse используется для проверки null
//Тут более подробно рассписано. Если null то

//В гайде приводится пример orelse unreachable
const expect = @import("std").testing.expect;

test "orelse unreachable" {
    const a: ?f32 = 5;
    const b = a orelse unreachable;
    const c = a.?;
    try expect(b == c);
    try expect(@TypeOf(c) == f32);
}

//Учитывая что orelse заменяется if, можно понять что это говорит компилятору что число никогда не будет null
//Но как по мне это не совсем нужно. Хотя, почему бы и нет)
//Язык богатый когда в нём есть и то и то. Почему нет)

test "if optional payload capture" {
    const a: ?i32 = 5;
    if (a != null) {
        const value = a.?;
        _ = value;
    }

    var b: ?i32 = 5;
    if (b) |*value| {
        //Занятный синтаксис
        //|v| захватывает значение. И тут захват идёт если значение не null
        value.* += 1;
    }
    try expect(b.? == 6);
} //Пиздим код с гайда
