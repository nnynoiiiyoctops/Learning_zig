const expect = @import("std").testing.expect;

const union64 = union {
    int: i64,
    float: f64,
    string: [8]u8,
};

test "Первый Union" {
    @setRuntimeSafety(false);
    // Это надо чтобы компилятор не ругался
    //Здесь будет небезопасное использование union
    //У компилятора есть понятие "АКТИВНОЕ ПОЛЕ"

    //Но это покажу в следующем тесте. Мне просто надо было убедиться что
    //Я могу использовать Union таким образом
    //Превосходно!)
    var FU: union64 = union64{ .int = 10 };
    //FY - first union - первый union
    //union лучше будет перевести как объеденение
    //Хотя я бы назвал "наслоение"
    //Потомучто в union выделяется места столько,
    //Сколько в самом большом его поле
    //Остальное будет записываться поверх
    try expect(FU.int == 10);

    FU = union64{ .float = 10.5 };

    try expect(FU.int != 10);
}

test "Безопвсный Union" {
    var SU: union64 = union64{ .int = 1 };
    //В моем случае это Seond Union НО
    //Хочу отметить что общепринятый перевод SU - Sovet Union - советский союз

    //Хочу проверить можно ли мат действия производить

    const testest: i64 = 10 + SU.int;
    //Я пробовал просто SU. Так нельзя.
    //Хочу заметить что это происходит из-за несоответствия типов
    //Несмотря на то, что вроде и размер 1. А надо конкретезировать тип
    //Вот и i64 и этот Union - 1 размера - но типизация статическая
    try expect(testest == 11);

    SU = union64{ .float = 11.5 };
    //А вот и безопасное использовани. Происходит явное преобразование в котором видно
    //Какое поле используется и какое значение ему дается
    //Интересно можно ли дать методы Union ....

    const testest2: f64 = 10.5 + SU.float;
    try expect(testest2 == 22.0);
}
//NU - new union - новый юнион
const NU = union {
    int: i64,
    float: f64,

    fn FLOAT(self: NU) f64 {
        return self.float;
    }
};

test "Странный тест" {
    const qwq: NU = NU{ .float = 10.0 };
    const for_test: f64 = qwq.FLOAT();

    try expect(for_test == 10.0);
}

//ХАХАХХАХАХАХА
//ЭТО РЕАЛЬНО РАБОТАЕТ
//Не знал что и Union можно метод присвоить
//Можно) Тест собирается

// Разочарование. В оффициальной документации есть такой пример. НО В ГАЙДЕ НЕТ
//Продолжаем исследование

//Последняя необсужденная тема Tagged union
//Юнион с тегами
//Я даже близко не представляю зачем мне это но пусть будет

const someEnum = enum { qwe, poi, ytr };

const TU = union(someEnum) {
    //Можно оставить это на откуп компилятора и написать
    //= union(enum) {
    //Но я лучше в лоб наишу
    qwe: u16,
    poi: u16,
    ytr: u16,
};

fn ChangeValue(self: TU) u16 {
    switch (self) {
        .qwe => return self.qwe + 10,
        .poi => return self.poi - 100,
        .ytr => return self.ytr * 2,
    }
}

test "Тест детя яростного сношения Enum и Union" {
    var random_value: TU = TU{ .poi = 1000 };
    random_value.poi = ChangeValue(random_value);
    try expect(random_value.poi == 900);

    random_value = TU{ .qwe = 10 };
    random_value.qwe = ChangeValue(random_value);
    try expect(random_value.qwe == 20);

    random_value = TU{ .ytr = 100 };
    random_value.ytr = ChangeValue(random_value);
    try expect(random_value.ytr == 200);
}
//8 Раз переписывал....
//Хотел запихнуть функцию в метод А НЕЛЬЗЯ
//Тип может быть только константны а к константе не преминимы += -= *= и так далее.
//И вот вынес  вотдельную функцию, казалось бы в чём ещё может быть проблема...
//В том, .... Я придумал альтернативное решение надо потестить

test "Тест детя яростного сношения Enum и Union 2" {
    var random_value: TU = TU{ .poi = 1000 };
    switch (random_value) {
        .qwe => |*byte| byte.* += 10,
        .poi => |*mword| mword.* -= 100,
        .ytr => |*rune| rune.* *= 2,
    }
    try expect(random_value.poi == 900);
}

//Нет нельзя так. Опять таки потомучто константа.
//Опять таки сам факт того что значение типа - константно, не дает производить с ним некоторые манипуляции
