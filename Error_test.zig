const expect = @import("std").testing.expect;

const RandomErrors = error{
    UwU,
    OwO,
    QwQ,
};

test "create errors" {
    const Just_for_test: RandomErrors = RandomErrors.OwO;
    try expect(Just_for_test == RandomErrors.OwO);
}

fn ReturnError() RandomErrors {
    return RandomErrors.UwU;
}

test "Test of returning from the function" {
    const Returning_value: RandomErrors = ReturnError();
    try expect(Returning_value == RandomErrors.UwU);
}

fn Return_error_or_value(flag: bool) RandomErrors!i32 {
    return if (flag) 42 else RandomErrors.UwU;
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
        return;
    };
    try expect(@TypeOf(bruh) != @TypeOf(RandomErrors.UwU));
}

test "Test of try" {
    try expect(@TypeOf(Return_error_or_value(false)) == RandomErrors!i32);
}

test "Second Test  of try" {
    const result: i32 = try Return_error_or_value(true);
    try expect(@TypeOf(result) == i32);
}

test "Test of catch" {
    const result = Return_error_or_value(false) catch |an_error| {
        switch (an_error) {
            RandomErrors.UwU => return,

            RandomErrors.OwO => return,

            RandomErrors.QwQ => return,
        }
    };

    try expect(result == 42);
}
