const std = @import("std");
const math = std.math;
const expect = std.testing.expect;
//Задание:
//Записать выражение для алгоритмического языка программирования.
//Как решение предложу просто набор тестов

fn R1(l: f64, t: f64) f64 {
    return 3 * math.pow(f64, t, @as(f64, 3.0)) + 3 * math.pow(f64, l, @as(f64, 5.0)) + 4.9;
}

test "Вариант 1" {
    //В выражении:
    // \( R = 3 \cdot t^3 + 3 \cdot l^5 + 4.9
    //Для l и t нет ограничений по значениям

    try expect(R1(10.0, 10.0) == 3.030049e5);
    //И так далее
}

fn K1(y: f64, p: f64) f64 {
    return @log(math.pow(f64, p, 2) + math.pow(f64, y, 3)) + @exp(p);
}

test "Вариант второй" {
    //В выражении
    // ln ( p^2 + y^3 ) + e^p
    //Нет ограничений для значений p и y
    try expect(K1(10.0, 10.0) > 10.0);
}
