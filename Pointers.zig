//Оооооооххх
// Это будет больно ... Поехали

const expect = @import("std").testing.expect;

//Я пишу для себя, поэтому отныне все тесты - обозначаются на русском
test "Первый указатель ..." {
    const from: i32 = 10;
    const ptr: *const i32 = &from;

    try expect(ptr.* == from);
}

test "Второй указатель, разыменование указателя" {
    var changed_value: u8 = 10;
    const ptr_on_vle: *u8 = &changed_value;

    ptr_on_vle.* -= 2;

    try expect(changed_value == 8);
    //Занятный пример который показывает что если указатель не меняется - он константен но тип у него указывает на изменяемую переменную
    //Но если сама переменная будет const то и указатель будет *const type
}

// Теперь рассмотрим передачу указателя в функцию

fn NewInt(a: *const i32) i32 {
    return a.* + 10;
}
// С ПЕРВОГО РАЗА ЗАРАБОТАЛО!!!!!
test "Новое на основе старого" {
    const from: i32 = 1;
    const ptr: *const i32 = &from;

    const q: i32 = NewInt(ptr);

    try expect(q == 11);
}

fn ModifyValue(a: *u8) void {
    a.* = a.* + 10;
}

test "Теперь изменение существубщего" {
    var from: u8 = 64;
    ModifyValue(&from);

    try expect(from == 74);
}

// Тест из официального гайда. Просто занятная информация

test "usize" {
    try expect(@sizeOf(usize) == @sizeOf(*u8));
    try expect(@sizeOf(isize) == @sizeOf(*u8));
}
