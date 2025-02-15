const expect = @import("std").testing.expect;

const Colors = enum { Red, Green, Blue, Orange };

test "Создание переменной пренадлежащей Enum" {
    const red_color: Colors = Colors.Red;

    try expect(@TypeOf(red_color) == Colors);
}

const TEnum = enum {
    var Top: u4 = 1;
    Left,
    Right,
    Down,
    //По сути своей это все набор чисел от 0 до конца Enum
    //Просто на этапе компиляции у них есть тип, и на этапе компиляции мы видем это как Enum. На деле это перечисление intов
};

test "Типизированный Enum" {
    const tev: u4 = TEnum.Top;
    //tev - typed enum value

    try expect(tev == 1);
    //    try expect(@IntFromEnum(TypedEnum.Top) == 0); компилятор ругается на то что это недопустимая встроенная функция... Ну. Тогда это надо будет тестить в main

    TEnum.Top += 1;
    try expect(TEnum.Top == 2);
}
