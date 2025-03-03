const std = @import("std");

pub fn main() !viod {
    const finish:u32 = 1000;
    var sum:u32 = 0;

    const its_work:u32 = blk: {
        sum += 1;
        if (sum >= finish) {
            break :blk sum;
        }
        goto blk;
        //в версии 0.1.0 goto был. В дальнейшем он был удалён из языка
        //Так что да...
        //И как раз таки на замену goto пришли именованные блоки
        //Просто знаятное наблдение
    };

    try std.testing.expect( its_work == finish );
}
