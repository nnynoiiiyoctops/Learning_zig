const expect = @import("std").testing.expect;

//Цикл while. В других языках, шаг указывалс в самом цикле, тут же его вынесли в начало, что несомненно +
//Да и помогает когда шаг должен отличаться от 1. Или в том случае, когда нельзя предсказать кол-во итераций
test "while" {
    var counter: u8 = 0;
    var summ: u16 = 0;
    while (counter <= 254) : (counter += 1) summ += counter;

    try expect(summ > 256);
}
//Тест сверху и этот - делают одно и то же. Но мне после Golang приятно что можно в 1 строчку это писать)))
test "while polystring" {
    var counter: u8 = 0;
    var summ: u16 = 0;
    while (counter <= 254) : (counter += 1) {
        summ += counter;
    }

    try expect(summ > 256);
}

//Каждый кто преподает факториал в примере с рекурсией - идиот. Это не тот пример что требует рекурсии
//Так они еще и не хвостовую рекурсию дают
//Я ЗАПРЕЩАЮ ВАМ ИСПОЛЬЗОВАТЬ НЕ ХВОСТОВУЮ РЕКУРСИЮ
test "factorial" {
    var counter: i16 = 6;
    var factorial: i16 = 1;

    while (counter > 0) : (counter -= 1) {
        factorial *= counter;
    }

    try expect(factorial == 720);
}
//Пример не мой. Но показать что можно обойтись без шага - как-то надо
test "useless test" {
    var i: i16 = 1;

    while (i < 1000) i += i;

    try expect(i == 1024);
}

//Я не смог придумать нормального теста, поэтому вот...
//Простите ...

//НО этот тест демонстрирует что и break и continue тут есть и работают как надо)
test "Stupidest test of break and continue" {
    var counter: i16 = 0;
    var summ: i16 = 1;
    while (counter < 10) : (counter += 1) {
        if (counter < 10) continue else break;
        summ += 1;
    }

    try expect(summ == 1);
}
