const expect = @import("std").testing.expect;

//Types
const std = @import("std");
const ArrayList = std.ArrayList;
const PageAllocator = std.heap.page_allocator;
const eql = std.mem.eql;

test "Ридер Врайтер" {
    var list = ArrayList(u8).init(PageAllocator);
    defer list.deinit();

    const bytes_writter = try list.writer().write("Test text");
    //Тут создается тот самый Writer
    //Вообще это обычная структура. В целом, в Go тоже самое
    //Просто структура которая помогает тебе упростить логику

    //Если вы будите смотреть в стандартную библиотеку, то увидите что
    //Reader и Writer есть почти у ВСЕХ типов что предполагают чтоение/запись
    //Это пример с записью в ArrayList

    try expect(bytes_writter == 9);
    try expect(eql(u8, list.items, "Test text"));
}

test " Чтение с файла" {
    const massege = "Test text";
    const file_name = "junkfile.txt";

    const file = try std.fs.cwd().createFile(
        file_name,
        .{ .read = true },
    );
    defer {
        file.close();
        std.fs.cwd().deleteFile(file_name) catch unreachable;
    }

    try file.writeAll(massege);
    try file.seekTo(0);

    const content = try file.reader().readAllAlloc(
        PageAllocator,
        massege.len,
    );
    defer PageAllocator.free(content);

    try expect(eql(u8, content, massege));
}
