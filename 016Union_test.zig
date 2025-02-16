const expect = @import("std").testing.expect;

const union64 = union {
    int: i64,
    float: f64,
    string: [8]u8,
};

test "Первый Union" {
    @setRuntimeSafety(false);
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
