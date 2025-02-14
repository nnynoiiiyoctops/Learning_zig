const expect = @import("std").testing.expect;
//Ошибки
//Я этот фпйл переписывал больше других поэтому тема - юольная

//Объявление оштбок. Есть системные ошибки, есть ваши ошибки, можете добавлять или исполтзовать имеющиеся
//Для примера я добавлю
const RandomErrors = error{
    UwU, //Эта ошибка на самом деле - число
    //А именно 0, для упрощения работы она имеет:
    //Отдельный тип на КАЖДУЮ ошибку
    //числовой код чтобы это работало быстро
    OwO,
    QwQ,
};

test "create errors" {
    const Just_for_test: RandomErrors = RandomErrors.OwO;
    try expect(Just_for_test == RandomErrors.OwO);
    //Как можно заметить у ошибки - свой тип и вы можете намеренно её создать
}

fn ReturnError() RandomErrors {
    return RandomErrors.UwU;
    //Функции могут возвращаь ( и принимать ошибки)
}

test "Test of returning from the function" {
    const Returning_value: RandomErrors = ReturnError();
    try expect(Returning_value == RandomErrors.UwU);
}

fn Return_error_or_value(flag: bool) RandomErrors!i32 {
    return if (flag) 42 else RandomErrors.UwU;
    //Тут поподробнее, что за !  ?
    //Я только учу, но видел жто только в синтаксисе ошибок
    //Восклицательный знак говорит компиляторут что функция модет вернуть или ошибку или значение
    //тоесть синтаксис такой
    //ErrorType!Type
    // также можно просто !Type

    //В чём тогда разница?
    // !Type используется когда ошибка может быть ЛЮБОЙ
    //А если как в нашем примере, то ошибки строго определены
}

test "Other return test" {
    const ERROOR: RandomErrors!i32 = Return_error_or_value(false);
    try expect(ERROOR == RandomErrors.UwU);

    const NO_ERROOR: i32 = Return_error_or_value(true) catch 0;
    //А вот это самая забавная херня. Потомучто тут catch вернет 0 когда будет ошибка
    //Но тут как видно всегда вернется i32. А вот если присвоить тип ошибки -
    //Будет ошибка компиляции

    try expect(NO_ERROOR == 42);

    //Давайте в таком случае попробуем просто catch
    const bruh = Return_error_or_value(false) catch |an_error| {
        try expect(an_error == RandomErrors.UwU);
        return; //catch обязан сожержать return. Потоиучто он ловит ошибку и вы думаете как ее обработать и что сделать
    };
    try expect(@TypeOf(bruh) != @TypeOf(RandomErrors.UwU));
}

test "Test of try" {
    try expect(@TypeOf(Return_error_or_value(false)) == RandomErrors!i32);
    //Повторю - Если в коде правее try будет ошибка - произойдет заверше^ие блока и будет выход за его пределы с дальнейшим пробрасыванием ошибки
}

test "Second Test  of try" {
    const result: i32 = try Return_error_or_value(true);
    try expect(@TypeOf(result) == i32);
    //Но если как тут, тоесть ошибки не будет, то всё просто продолжится)
}

test "Test of catch" {
    const result = Return_error_or_value(false) catch |an_error| {
        switch (an_error) {
            RandomErrors.UwU => return,
            //Не менее заюавный момент, комрилятор требует
            //Anyerr или void. В жокументации нашел странный пример, но он использует неизвестный мне синтаксис
            // Надо будет вернуться к этому коду позже когда узнаю новый синтаксис
            RandomErrors.OwO => return,

            RandomErrors.QwQ => return,
        }
    };

    try expect(result == 42);
}
