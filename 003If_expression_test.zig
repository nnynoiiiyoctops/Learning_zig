const expect = @import("std").testing.expect;
//Тут я открыл для себя более простой способ экспортировать функцию.

test "min with if expression" {
    const a: i32 = 10;
    const b: i32 = 5;
    var minimum: i32 = undefined;
    //Переменная инициализирована но не используется

    if (a > b) {
        minimum = b;
    } else {
        minimum = a;
    }

    try expect(minimum == 5);
} //Простейшая реализация min

test "Ternar operator test" {
    const a: i32 = 10;
    const b: i32 = 5;
    var minimum: i32 = undefined;
    //indefined говорит о том, что у переменной нет значения и оно будет задано позже.
    //Вроде как тут идет выделение памяти на стеке для переменной для дальнейшей работы

    //Да, в Zig нет тернарного оператора. Но if - компенсирует это
    minimum = if (a > b) b else a;

    try expect(minimum == 5);
}
//Тут просто тестировал какой синтаксис может быть
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

    if (a > b) minimum = b else minimum = a;
    //if (a > b) {minimum = b} else { minimum = a };
    //Вот так к сожелению или счастью нельзя, компилятор ругается
    //Хоть  в строчку можно)

    try expect(minimum == 5);
}
