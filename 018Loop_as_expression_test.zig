//Я пропустил пару тем потомучто именнованные блоки и циклы обсудил в блоке Errors. Пока ничего не поменялось
const expect = @import("std").testing.expect;

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;
}

test "while loop expression" {
    try expect(rangeHasNumber(0, 10, 3));
}

//Код с гайда и я бы хотел его обсудить
//По факту тут важно лишь то, что тут как и в Python есть esle у while
//И работает точно также. Else выполнится только после заверщения цикла

//По сути тут заметна другая деталь. То как работает break и continue.
//Обычно - они заверщают цикл или завершают итерацию
//В zig break наделён большими полномочиями и может возвращать значение
//И опять таки можно указать блок в который он будет его возвращать. Но если блок не указан
//То вернёт в ближайший. Тоесть тот в котором находится

//Else в целом как и в питоне, ничего нового
//Может показаться странным что else возвращает значение. Но нет,
//Это нормально. Хочу отметить что тот же цикл можно использовать и для присвоения значения переменной.
//Поэтому нового тут нет и не понимаю почему в гайде это так далеко ...
