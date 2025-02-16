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

//Момент который повторится в структурах
//МЕТОДЫ
//Метод - функция применяемая к переменной
//Модно объяснить проще, это функция жля изменения определенного объекта . Да, она как обычная функция, но у неё есть обязательный параметр, то на что она применется и у неё чуть другой синтаксис

const EnumsWithMetods = enum {
    //Обычные поля
    Someone,
    aaahhh,
    i_dont_have_idea,
    qwq,

    fn IsSomeone(i: EnumsWithMetods) bool {
        return if (i == EnumsWithMetods.Someone) true else false;
    }
    //Количество методов может быть любым, просто укажите
    //функции в enum (или struct как мы увидем дальше)
    //Но тут как с переменными - если метод не исполтзуется - компилятор вам скажет
    //В гайде у функции была преписка pub
    //Логично если вы хотите исполтзова>ь тип вне 1 файла
    //Но это не обязательно

    //Также в гайде писалось что первый параметр зовется self.
    //Как видно из примера выше - это не обязательно
    //Если не верите - каждый тест можно проверить командой zig test filename
};

test "method tests" {
    const IDK: EnumsWithMetods = EnumsWithMetods.Someone;
    const flag: bool = IDK.IsSomeone(); //Метод вызывается к переменной через точку и скоьочки

    try expect(flag);
}
