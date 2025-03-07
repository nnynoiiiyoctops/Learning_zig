const expect = @import("std").testing.expect;

test "Common for loop" {
    // For used to iterate, not for cycle from start to end. I T E R A T I O N on object.
    //Цикл фор используется для итерации по объектам ТЕМ НЕ МЕНЕЕ. Он можнт быть использлван для цикла, НО с шагом в 1. Ниже будет пример
    const iteration_array = [_]i16{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 120, 124, 1, 312, 41, 2, 421, 4 };
    var summ: i16 = 0;

    for (iteration_array) |integer| summ += integer;

    try expect(summ > 1000);
}

test "for from official guide" {
    //character literals are equivalent to integer literals
    //Ну тут я взял с оффициального гайда потомкчто тогдатне мог примерлв при_умать
    const string = [_]u8{ 'a', 'b', 'c' };

    for (string, 0..) |character, index| {
        _ = character;
        _ = index;
    }

    for (string) |character| {
        _ = character;
    }

    for (string, 0..) |_, index| {
        _ = index;
    }

    for (string) |_| {}

    var bruh: usize = undefined; //Кстати, да, в for при переборе чисел - они имеют тип usize он зависит от арзитектуры процессора (вроде бы), просто будьте готовы к этому
    //И всё же кое-что доьавою)))
    for (0..100) |index| {
        bruh = index;
    }
    try expect(bruh == 99);
    //Вот тут по сути идет обычная итерация от 0 жо 100 НЕВКЛЮЧИТЕЛЬНО

}

test "String iteration" {
    const iteration_string: []const u8 = "ver and over and over again";
    var summ: u64 = 0;

    for (iteration_string) |char| {
        summ += char;
    }
    // Тут буквы - числа как и в друглм языке НО
    //Тут это явно числа, не char из C
    //Не byte из Go который по факту u8
    //Не rune из тогоже Go которая по факту u32
    //Это явно числа, меньше путаницы)

    try expect(summ != 0);
}

test "Test of indexs in array" {
    var summ: u64 = 0;
    //Еще 1 тест на итерацию
    //Тут заметьте что тоже не до конца итерация идет
    // 0+1+2+3+4 = 10

    for (0..5) |index| {
        summ += index;
    }

    try expect(summ == 10);
}

test "Another try to understanding for loop" {
    const itr_array = [5]i16{ 10, 10, 10, 10, 10 };
    var summ: i32 = 0;
    var indexs: usize = 0;

    for (itr_array[0..3], 0..3) |integer, index| {
        summ += integer; //занятный момент!
        indexs = index; //в for как можнг увидеть 2 аргумента
    }
    //объект для итерации и числа
    //Если их длинна не будет совпадать - компилятор бцдет ругаться. Можете попробовать)

    try expect(summ == 30);
    try expect(indexs == 2);
}
