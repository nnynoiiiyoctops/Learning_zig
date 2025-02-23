const expect = @import("std").testing.expect;

//Почему резкий перескок на 100?
//Потомучто в гайжетзавершил главу Language
//Теперь переходим к стандартной библиотеке!)
// Хотел бы отметить такой момент
// Дальше нового синтаксиса д не будет
// Будут только новые функции смысл работы которых надо понимать

//Также я оказался деюилом потому, что в zig всё это время была программа для сборки 1 конкретного файла. Тоесть с её помощью можно было из 1 файла кода получить 1 исполняемый
//zig build-exe file_name.zig

//Лучше поздно чем никогда!)
//Тем не менее. Тесты будут писаться и к ^им просто будет выходить дополнение
//Не все функции поддерживаются в тестахт поэтому да, придётся часть старых тестов поменять, дополнить, но, это не то чтобы трудно, после всех то новостей)

//ВСТУПЛЕНИЕ ВСЁ
//Теперь аллокаторы

const std = @import("std");
const page_allocator = std.heap.page_allocator;

test "Аллокатор" {
    var memory = try page_allocator.alloc(u8, 100);
    //помимо alloc есть resize remap и free
    defer page_allocator.free(memory);

    try expect(memory.len == 100);

    if (page_allocator.resize(memory, 100)) try expect(memory.len != 80);

    memory = try page_allocator.realloc(memory, 80);
    //Как оказалось resize возвращает правду о размере а не меняет длинру
    //remap тут нет к сожелению
    //relloc работает и переопределяет размер. Круто

    try expect(memory.len == 80);
}
//Ну и зачем вызывать какой-то аллокатор чтобы создать массив?
//Аллокаторы выделяют место в куче. Что видно по импорту
//heap = куча
//Это струткутра данных
//Есть :
//Стект Куча .data .bss и .text
//До этого мы работали только со стеком и .text
//(В .text хранятся тела функций)
//А в стеке хранились все константы и переменные которые мы создавали
//В .data и .bss компилятор кидает глобальные переменные и строки
// Также очень боль*ие константные структуры могут отправиться в .data (НАСКОЛЬКО МНЕ ИЗВЕСТНО ИНФОРМАЦИЯ НЕ ТОЧНАЯ)
// в чём суть:
//Куча может изменять размер
//Стек .data .text и .bss имеют фиксированный размер
//Вот зачем куча

const FBA = @import("std").heap.FixedBufferAllocator;

test "Аллокатор фиксированного буфера" {
    var buffer: [1000]u8 = undefined;
    var bal = FBA.init(&buffer);

    const allocator = bal.allocator();
    //Этот аллокатор именно что управляет,не создает, а управляет памятью в стеке ( потомучто массив инициализирован в стеке)
    //Как-то так
    const memory = try allocator.alloc(u8, 100);

    for (0..memory.len) |byte| {
        memory[byte] = 10;
    }
    //Понял в чём ошибка была
    //Я забыл как правильно for использовать. Вот поправил

    const second_section = try allocator.alloc(u8, 10);

    for (0..second_section.len) |byte| {
        second_section[byte] = 20;
    }

    //const third_section = try allocator.alloc(u8, 1000);
    //Тест того будет ли проверка выхода за раницы
    //    try expect(third_section.len == 1000);

    //Интересный вывод. Оно скомпилировалось. Но в ходе выполнения была передана ошибка
    //OutOfMemory
    //Так что, да) Оно соберётся. Но во время выполнения - упадёт с ошибкй выделения.
    //Учтём

    try expect(memory[0] == 10);
}
//Так как память выделена на стеке, то она не нуждается в освобождении, она автоматически освободится после выхода из области видимости
//Надо будет подробнее разобраться

const arena_allocator = std.heap.ArenaAllocator;

test "Тест аллокатора арены" {
    var arena = arena_allocator.init(page_allocator);
    const allocator = arena.allocator();
    defer arena.deinit();

    const buf1 = try allocator.alloc(u8, 100);
    const buf2 = try allocator.alloc(u8, 100);

    for (buf1) |*byte| byte.* = 10;
    for (buf1) |value| try expect(value == 10);

    for (buf2) |*byte| byte.* = 20;
    for (buf2) |value| try expect(value == 20);
}

//Для одиночных объектов лучше использовать create вместо alloc и destroy вместо free (alloc и free для массивов)

test "Аллокацыя единичных объектов" {
    const big_int = try page_allocator.create(u128);
    defer page_allocator.destroy(big_int);

    big_int.* = 0;
    big_int.* -%= 1;

    try expect(big_int.* > 1_000_000_000);
}
