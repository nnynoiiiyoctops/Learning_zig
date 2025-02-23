const expect = @import("std").testing.expect;
const std = @import("std");

//И тааак. Работа с файлами. Добрались.
//Много на каких языках работал но мало на каких доходил до этого

//И ТАААК
//Функции открывающие файл отдают "Дескриптор файла"
//По нему ОС будет считывать информацию с диска и передавать нам.
//Поэтому функции открывающие файлы надо применять на конкретные значения
//Закрывая файл мы закрываем и дескриптор и ОС знает что мы более не собираемся читать этот файл
//При закрытии программы вроде и дескриптор закрываются
//Но информация неточная

test "открываем файл, пишем, читаем и закрываем его" {
    //cwd = current working directory
    //Эта функция даёт директорию в которой находится файл
    //К директории применяется метода - createFile
    const file = try std.fs.cwd().createFile("test.txt", //Имя файла
        .{
        .read = true,
    });
    //Хочу заметить, что если файл существует то он не будет создан ещё раз
    //НО эта функция стерает предыдущее содержимое файла

    defer file.close();
    //Отложенное закрытие файла

    const tif: *const [12:0]u8 = "text to file";
    //tif = text io file

    try file.writeAll(tif);
    //Или эта стерает содержимое ....
    //В общем так вышло что этот код записывает всё с 0 и конец файла или текст что был до/после игнорируется

    var buffer: [100]u8 = undefined; //буфер для чтения
    try file.seekTo(0); //Переход в начало файла. Как перестановка каретки в терминале
    const bytes_read = try file.readAll(&buffer);
    //Число записанных в файл символов

    try expect(std.mem.eql(u8, buffer[0..bytes_read], tif));
    //Я не смог нормальную функцию для сравнения массивов написать
    //Воспальзуемся со стандартной библиотеки

    try expect(bytes_read != buffer.len);
}

//Мне лень и я тупо вставлю код из гайда
const eql = std.mem.eql;

test "file stat" {
    const file = try std.fs.cwd().createFile(
        "junk_file2.txt",
        .{ .read = true },
    );
    defer file.close();

    const stat = try file.stat();
    //Статистика по файлу. Дальше будет видно

    try expect(stat.size == 0); //размер
    try expect(stat.kind == .file); //файл ли это
    try expect(stat.ctime <= std.time.nanoTimestamp()); //Last status/metadata change time in nanoseconds, relative to UTC 1970-01-01.
    //Время последнего изменения статуса/метаданных
    try expect(stat.mtime <= std.time.nanoTimestamp()); //Last modification time in nanoseconds, relative to UTC 1970-01-01.
    //Время последнего изменения в наносекундах
    try expect(stat.atime <= std.time.nanoTimestamp()); //Last access time in nanoseconds, relative to UTC 1970-01-01.
    //Время последнего доступа в наносекундах

    //Я не знаю что это значит но обязательно ознакомлюсь
}

//Снова воруем с гайда
test "make dir" {
    try std.fs.cwd().makeDir("testDir");
    var iter_dir = try std.fs.cwd().openDir(
        "testDir",
        .{ .iterate = true }, //Занятная характеристика для директории ...
    );
    defer {
        iter_dir.close();
        std.fs.cwd().deleteTree("testDir") catch unreachable;
        //catch unreachable меня пугает....
        //И что за deleteTree ...
        //Почитал. Это рекурсивное удаление а Tree указывает на иерархическую структуру
        //Это буквально rm -rf
    }

    var a = try iter_dir.createFile("x", .{});
    a.close();
    //Нахожу занятным что файлы создаются но не закрываются ...
    a = try iter_dir.createFile("y", .{});
    a.close();
    //Поправил
    a = try iter_dir.createFile("z", .{});
    a.close();
    //Предположу что дело в том. Что дискриптор - игнорировался
    //На самом деле код страшный. Ведь до этого игнорировался дескриптор и файлы попросту удалялись...
    //Файл с существующем дескриптором удаляется...

    var file_count: usize = 0;
    var iter = iter_dir.iterate(); //Тут возвращаетсяя структура Iterator в которой есть поле, которое мы задаё bool
    //                => return Iterator{
    //                .dir = self.dir,
    //                .seek = 0,
    //                .index = 0,
    //                .end_index = 0,
    //                .buf = undefined,
    //                .first_iter = first_iter_start_value,
    //            },

    //Вот такая структура возвращается в функции iterate
    //Хочу заметить что это для Linux. Для других ОС структуры несколько отличаются
    //    https://ziglang.org/documentation/0.11.0/std/src/std/fs.zig.html
    //Вот тут код структуры брал. Но тут 0.11.0
    //А я использую 0.13.0....
    //Тестируем...

    while (try iter.next()) |entry| {
        if (entry.kind == .file) file_count += 1;
    }
    //try и |value| говорит о том что тут либо ошибка либо nill
    //Поэтому тут и while. В for вроде как нельзя так итерировать
    try expect(file_count == 3);
}
