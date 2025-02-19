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
//func mySqrt(x float64) float64 {
//      var z, lastz float64 = 1.0, 0.0
//      for math.Abs(z - lastz) > 0.000001  {
//              lastz = z
//              z -= (z*z - x) / (2*z)
//              fmt.Printf("%8f | %8f\n", z , lastz)
//      }
//      return z
//}
//
//func main() {
//      fmt.Println(mySqrt(2))
//      fmt.Println(math.Sqrt(2))
//}//Код выше - 1 из заданий тура Golang. Хочу попробовать написать его на zig в 1 строку

test "sqrt" {
    var last: f64 = 0.0;
    var next: f64 = 1.0;

    const x: f64 = 2.0; //Число из которого будем брать корень

    while ((next - last) > 0 and (next - last) < 0.001) {
        last = next;
        next -= (next * next - x) / (2 * next);
    }
    //Вместо вызова функции легче проверить 2жды) Можно сделать хитрее и сделать что-то типо следующего теста
    try expect(next < 2);
}

test "sqrt2" {
    var last: f64 = 0.0;
    var next: f64 = 1.0;

    const x: f64 = 2.0; //Число из которого будем брать корень
    {
        var step: f64 = 1.0;
        while (step > 0 and step < 0.001) {
            last = next;
            next -= (next * next - x) / (2 * next);
            step = next - last;
        }
    }
    // Это блок. Все переменные в рамках блока - умерают после выхода из него.
    //Блок может использовать внешние переменные, как видно в примере
    //Тут блок нужен просто чтобы удалитm step после всего)
    //Вообще в блок можно еще и last и x засунуть. Но не вижу смысла. По мне и так неплохо)

    //Пи*у из будущего
    //Блоки тут намного круче чем в других языках и в блоке ошибок вы в этом убедитесь

    //Вместо вызова функции легче проверить 2жды) Можно сделать хитрее и сделать что-то типо следующего теста
    try expect(next < 2);
}

test "ловля значения" {
    var i: usize = 0;
    var summ: i32 = 0;
    const arr = [_]?u8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, null };
    //Вот этот вопрос, коиорый ? удостоился отдельного файла
    //Если коротко - он позволяет использовать null

    while (arr[i]) |value| : (i += 1) {
        summ += value;
    }
    //Пишу из будущего, while тоже может итерировать по коллекциям
    //Но у while всё еще есть преимущество перед for
    //У while - можно поставить различную длинну шага в отличии от for
    //Вообще сам синтаксис |value| почти всегда связан с null
    //Или ловлей ошибок
    try expect(summ == 45);
}
