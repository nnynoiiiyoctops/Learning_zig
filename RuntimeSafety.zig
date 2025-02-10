const expect = @import("std").testing.expect;

fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable, //unreachablr - недостижимый. Это просто указание компилятору что этот код НИКОГДА не исполнится
        //Выполнение unreachable вызовет панику. Пу сути это договор с компилятором, в котором ты говоришь: это не должно исполняться
    };
}

test "unreachable switch" {
    try expect(asciiToUpper('a') == 'A');
    try expect(asciiToUpper('A') == 'A');
}

test "out of bounds, no safety" {
    @setRuntimeSafety(false); //ОТКЛЮЧЕНИЕ ПРОВЕРКИ НА БЕЗОПАСНОСТЬ В РАМКАХ БЛОКА
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];

    _ = b;
    index = index;
}
//За пределами блока проверка включается
