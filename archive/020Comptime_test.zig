const expect = @import("std").testing.expect;

//К моему сожелению - тут есть джинерики
//И да, они делаются через comptime
//Но не только джинерики через него делаются,
//Некоторым переменным можно присвоить значение на этапе компиляции

fn DificultCalculating(iterations: i32) i32 {
    var i: i32 = 0;
    var result: i32 = 0;
    while (i < iterations) : (i += 1) {
        result += i * iterations;
    }

    return result;
}

test "comptime" {
    const zi: i32 = DificultCalculating(0);
    //zero iteration -
    //Ноль итераций
    const ctc: i32 = comptime DificultCalculating(10);
    //ctc comptime calcilting -
    // посчитанное во время компиляци

    try expect(zi < ctc);
}

//А теперь такой момент
// если не объявлять тип переменной, то он будет
//comptime_int
//comptime_float
// ну и так далее
// conat a = 10; //Тип a = comptime_int
//Из весёлого
//Оказалось что модно сделать так:

test "tupetest" {
    const a: i32 = 1;
    const b: if (a > 0) i64 else i32 = 2048;

    try expect(@TypeOf(b) == i64);
}

fn MatrixInit(
    comptime T: type,
    comptime width: comptime_int,
    comptime height: comptime_int,
) type {
    return [height][width]T;
}

test "returning a type" {
    try expect(MatrixInit(f32, 4, 4) == [4][4]f32);
    //Это код из гайда, но я предлагаю добавить еще 2 теста

    const q: MatrixInit(i32, 4, 4) = undefined;
    try expect(@TypeOf(q) == [4][4]i32);
}
//Вот это вот уже страшно
//Потомучто comptime дает сгенерировать джинерики
//Слав тебе, Господи, не перегрузки

//Но модно и проще

inline fn RS(comptime T: type, a: T, b: T) T {
    //RS = random shit как и все файлы .rs
    return a + b;
}

test "RS test" {
    const q: i15 = RS(i15, 1, 12);
    const notq: i10 = RS(i10, 7, 6);

    try expect(q == notq);
}

//Ухххх
//Ну ………
// поехали
//Возьму код с гайда и бцду объяснять то что понял
fn Vec(
    comptime count: comptime_int,
    comptime T: type,
) type {
    return struct {
        data: [count]T,
        const Self = @This(); //Больше всего вопросов к этому
        //Сюда помещается ссылка на сам объект
        //Это не является ни полем ни методом
        //Это переменная которая сотрется

        fn abs(self: Self) Self {
            var tmp = Self{ .data = undefined };
            for (self.data, 0..) |elem, i| {
                tmp.data[i] = if (elem < 0) -elem else elem;
            }
            return tmp;
        } //Вместе с передачей метода мы передаем и его методы
        //ничего нового

        fn init(data: [count]T) Self {
            return Self{ .data = data };
        }
    };
}

const eql = @import("std").mem.eql;

test "generic vector" {
    const x = Vec(3, f32).init([_]f32{ 10, -10, 5 });
    //Сразу инициализируем и тип через функцию Vec и так как она возвращает тип применяем к нему метод init
    const y = x.abs(); //x уже облажаеи этим методом, поэтому можно
    try expect(eql(f32, &y.data, &[_]f32{ 10, 10, 5 }));
}
