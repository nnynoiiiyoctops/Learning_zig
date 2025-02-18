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
